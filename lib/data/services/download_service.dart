import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:uuid/uuid.dart';
import '../db/database.dart';
import '../models/download_task.dart';
import '../../shared/utils/url_resolver.dart';
import '../../shared/utils/m3u8_parser.dart';

class DownloadService {
  final AppDatabase _db;
  final UrlResolver _urlResolver;
  late final Dio _dio;
  final _cancelTokens = <String, CancelToken>{};
  final _taskStates = <String, DownloadTask>{};
  final _progressController = StreamController<DownloadTask>.broadcast();
  Future<void>? _initFuture;

  static const _maxConcurrentSegments = 3;
  static const _maxRetries = 3;
  static const _retryDelays = [1, 3, 9];

  DownloadService(this._db, this._urlResolver) {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        'Referer': 'https://www.baidu.com/',
      },
    ));
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (_, __, ___) => true;
      return client;
    };
    _initFuture = _initFromDb();
  }

  Stream<DownloadTask> get progressStream => _progressController.stream;

  /// Restore tasks from DB into memory, cleaning up stale/damaged records.
  Future<void> _initFromDb() async {
    final rows = await _db.getDownloads();
    for (final row in rows) {
      final id = row['id'] as String;
      final status = row['status'] as String;
      final savePath = row['save_path'] as String;
      final totalSegments = (row['total_segments'] as num?)?.toInt() ?? 0;
      final totalBytes = (row['total_bytes'] as num?)?.toInt() ?? 0;

      if (status == 'downloading') {
        final m3u8Path = savePath.replaceAll(RegExp(r'\.mp4$'), '.m3u8');
        if (File(savePath).existsSync()) {
          final updates = <String, dynamic>{
            'status': 'completed',
            'progress': 1.0,
            'completed_at': DateTime.now().toIso8601String(),
          };
          if (totalSegments == 0) {
            updates['total_bytes'] = await File(savePath).length();
          }
          await _db.updateDownload(id, updates);
        } else if (File(m3u8Path).existsSync()) {
          await _db.updateDownload(id, {
            'status': 'completed',
            'progress': 1.0,
            'completed_at': DateTime.now().toIso8601String(),
          });
        } else {
          await _db.updateDownload(id, {'status': 'failed', 'error_message': '下载中断'});
        }
      } else if (status == 'completed' && totalSegments == 0 && totalBytes > 0 && totalBytes < 1024) {
        // Damaged record from old bugs — tiny totalBytes with no segments
        await _db.updateDownload(id, {'status': 'failed', 'error_message': '下载记录损坏'});
      }
    }

    final cleaned = await _db.getDownloads();
    for (final row in cleaned) {
      _taskStates[row['id'] as String] = _rowToTask(row);
    }
  }

  /// Returns all tasks from the authoritative in-memory store.
  Future<List<DownloadTask>> getAll() async {
    await _initFuture;
    return _taskStates.values.toList();
  }

  Future<DownloadTask> addTask({
    required String title,
    required String url,
    required String savePath,
    String? sourceName,
    String? episodeName,
  }) async {
    final id = const Uuid().v4();
    final task = DownloadTask(
      id: id,
      title: title,
      url: url,
      savePath: savePath,
      sourceName: sourceName,
      episodeName: episodeName,
      createdAt: DateTime.now(),
    );

    _taskStates[id] = task;

    await _db.addDownload({
      'id': id,
      'title': title,
      'url': url,
      'save_path': savePath,
      'status': 'pending',
      'downloaded_bytes': 0,
      'total_bytes': 0,
      'progress': 0.0,
      'source_name': sourceName,
      'episode_name': episodeName,
      'created_at': DateTime.now().toIso8601String(),
    });

    return task;
  }

  Future<void> startDownload(String id) async {
    final task = _taskStates[id];
    if (task == null) return;

    final cancelToken = CancelToken();
    _cancelTokens[id] = cancelToken;

    _updateMemory(id, status: DownloadStatus.downloading);
    _db.updateDownload(id, {'status': 'downloading'});

    try {
      final resolvedUrl = await _urlResolver.resolve(task.url);

      if (_isM3u8Url(resolvedUrl)) {
        await _downloadM3u8(id, task.title, resolvedUrl, task.savePath, cancelToken);
      } else {
        await _downloadDirectFile(id, task.title, resolvedUrl, task.savePath, cancelToken);
      }

      final current = _taskStates[id];
      if (current != null) {
        _updateMemory(id, status: DownloadStatus.completed, progress: 1.0,
          completedAt: DateTime.now());

        if (current.totalSegments > 0) {
          await _db.updateDownload(id, {
            'status': 'completed', 'progress': 1.0,
            'completed_at': DateTime.now().toIso8601String(),
          });
        } else {
          await _db.updateDownload(id, {
            'status': 'completed', 'progress': 1.0,
            'total_bytes': current.downloadedBytes,
            'completed_at': DateTime.now().toIso8601String(),
          });
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        _updateMemory(id, status: DownloadStatus.paused);
        await _db.updateDownload(id, {'status': 'paused'});
      } else {
        _updateMemory(id, status: DownloadStatus.failed, errorMessage: e.message);
        await _db.updateDownload(id, {'status': 'failed', 'error_message': e.message});
      }
    } catch (e) {
      _updateMemory(id, status: DownloadStatus.failed, errorMessage: e.toString());
      await _db.updateDownload(id, {'status': 'failed', 'error_message': e.toString()});
    } finally {
      _cancelTokens.remove(id);
    }
  }

  void _updateMemory(String id, {
    DownloadStatus? status,
    double? progress,
    int? downloadedBytes,
    int? totalBytes,
    int? totalSegments,
    int? downloadedSegments,
    String? errorMessage,
    DateTime? completedAt,
  }) {
    final task = _taskStates[id];
    if (task == null) return;
    _taskStates[id] = task.copyWith(
      status: status ?? task.status,
      progress: progress ?? task.progress,
      downloadedBytes: downloadedBytes ?? task.downloadedBytes,
      totalBytes: totalBytes ?? task.totalBytes,
      totalSegments: totalSegments ?? task.totalSegments,
      downloadedSegments: downloadedSegments ?? task.downloadedSegments,
      errorMessage: errorMessage,
      completedAt: completedAt ?? task.completedAt,
    );
    _progressController.add(_taskStates[id]!);
  }

  Future<void> _downloadM3u8(
    String id,
    String title,
    String m3u8Url,
    String savePath,
    CancelToken cancelToken,
  ) async {
    final parser = M3u8Parser(_dio);
    final playlist = await parser.parse(m3u8Url, cancelToken: cancelToken);

    if (playlist.segments.isEmpty) {
      throw Exception('m3u8 playlist has no segments');
    }

    final segments = await parser.resolveNestedSegments(
      playlist.segments,
      cancelToken: cancelToken,
    );

    if (segments.isEmpty) {
      throw Exception('no downloadable segments found');
    }

    final dir = Directory(savePath).parent;
    final segDir = Directory('${dir.path}/segments');
    await segDir.create(recursive: true);

    final totalSegments = segments.length;
    var completedSegments = 0;
    var totalBytesDownloaded = 0;
    final localPaths = <String>[];
    final durations = <double>[];

    var lastDbFlush = DateTime.now();
    const flushInterval = Duration(seconds: 2);

    void flushProgress({bool force = false}) {
      final now = DateTime.now();
      final shouldFlushDb = force || now.difference(lastDbFlush) >= flushInterval;

      final progress = totalSegments > 0 ? completedSegments / totalSegments : 0.0;
      _updateMemory(id,
        downloadedBytes: totalBytesDownloaded,
        totalBytes: 0,
        totalSegments: totalSegments,
        downloadedSegments: completedSegments,
        progress: progress,
      );

      if (shouldFlushDb) {
        lastDbFlush = now;
        _db.updateDownload(id, {
          'downloaded_bytes': totalBytesDownloaded,
          'total_bytes': 0,
          'total_segments': totalSegments,
          'downloaded_segments': completedSegments,
          'progress': progress,
        });
      }
    }

    final semaphore = _Semaphore(_maxConcurrentSegments);
    final futures = <Future>[];

    for (var i = 0; i < segments.length; i++) {
      final seg = segments[i];
      final segPath = '${segDir.path}/seg_${i.toString().padLeft(5, '0')}.ts';
      localPaths.add(segPath);
      durations.add(seg.duration);

      if (File(segPath).existsSync() && await File(segPath).length() > 0) {
        completedSegments++;
        totalBytesDownloaded += await File(segPath).length();
        flushProgress();
        continue;
      }

      futures.add(semaphore.acquire().then((_) async {
        try {
          await _downloadSegmentWithRetry(seg.url, segPath, cancelToken);
          completedSegments++;
          if (File(segPath).existsSync()) {
            totalBytesDownloaded += await File(segPath).length();
          }
          flushProgress();
        } finally {
          semaphore.release();
        }
      }));
    }

    await Future.wait(futures);

    if (cancelToken.isCancelled) return;

    flushProgress(force: true);

    // Everything after this point is non-critical — segments are already on disk.
    // Failures must NOT prevent the download from being marked completed.
    try {
      // Download encryption keys (with 10s timeout per key to avoid hanging)
      final keyPaths = <String, String>{};
      for (var i = 0; i < segments.length; i++) {
        final seg = segments[i];
        if (seg.encryptionKeyUrl != null && !keyPaths.containsKey(seg.encryptionKeyUrl)) {
          final keyPath = '${segDir.path}/key_${keyPaths.length}.key';
          if (!File(keyPath).existsSync()) {
            await _dio.download(seg.encryptionKeyUrl!, keyPath, cancelToken: cancelToken)
                .timeout(const Duration(seconds: 10));
          }
          keyPaths[seg.encryptionKeyUrl!] = keyPath;
        }
      }

      // Build local m3u8
      final m3u8Path = savePath.replaceAll(RegExp(r'\.mp4$'), '.m3u8');
      final localM3u8 = parser.buildLocalM3u8(localPaths, durations: durations);
      await File(m3u8Path).writeAsString(localM3u8);

      // Fire-and-forget ffmpeg merge
      _runMergeAsync(segDir.path, localPaths, savePath, m3u8Path);
    } catch (e) {
      // Non-critical steps failed — segments are safely on disk, keep m3u8 as
      // fallback if it was written. The download will be marked completed.
    }
  }

  /// Run ffmpeg merge in background. Success or failure does not affect
  /// download completion status — m3u8 is always kept as fallback on failure.
  void _runMergeAsync(String segDir, List<String> segmentPaths, String outputPath, String m3u8Path) {
    Future.microtask(() async {
      try {
        await _mergeToMp4(segDir, segmentPaths, outputPath);
        if (File(outputPath).existsSync()) {
          try { await File(m3u8Path).delete(); } catch (_) {}
        }
      } catch (e) {
        // keep m3u8 as fallback
      }
    });
  }

  Future<void> _downloadDirectFile(
    String id,
    String title,
    String url,
    String savePath,
    CancelToken cancelToken,
  ) async {
    await Directory(savePath).parent.create(recursive: true);

    final file = File(savePath);
    int existingBytes = 0;
    if (file.existsSync()) {
      existingBytes = await file.length();
    }

    final options = Options(
      headers: existingBytes > 0 ? {'Range': 'bytes=$existingBytes-'} : null,
      followRedirects: true,
      validateStatus: (s) => s != null && (s < 400 || s == 206 || s == 416),
    );

    await _dio.download(
      url,
      savePath,
      cancelToken: cancelToken,
      options: options,
      deleteOnError: false,
      onReceiveProgress: (received, total) {
        final actualTotal = total > 0 ? total : 0;
        final actualReceived = received + existingBytes;
        if (actualTotal > 0) {
          _emitProgress(id, actualReceived, actualTotal);
        }
      },
    );

    if (file.existsSync()) {
      final size = await file.length();
      if (size < 1000) {
        final content = await file.openRead(0, 100).transform(
          SystemEncoding().decoder,
        ).join('');
        if (content.contains('<html') || content.contains('<!DOCTYPE')) {
          await file.delete();
          throw Exception('Server returned HTML page instead of video');
        }
      }
    }
  }

  Future<void> _downloadSegmentWithRetry(
    String url,
    String savePath,
    CancelToken cancelToken,
  ) async {
    final tmpPath = '$savePath.tmp';
    for (var attempt = 0; attempt < _maxRetries; attempt++) {
      try {
        if (cancelToken.isCancelled) throw DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.cancel,
        );

        await _dio.download(url, tmpPath, cancelToken: cancelToken);
        final tmpFile = File(tmpPath);
        if (await tmpFile.exists() && await tmpFile.length() > 0) {
          await tmpFile.rename(savePath);
          return;
        }
      } on DioException catch (e) {
        if (e.type == DioExceptionType.cancel) rethrow;
        if (attempt == _maxRetries - 1) rethrow;
        await Future.delayed(Duration(seconds: _retryDelays[attempt]));
      }
    }
  }

  Future<void> _mergeToMp4(String segDir, List<String> segmentPaths, String outputPath) async {
    final fileListPath = '$segDir/filelist.txt';
    final sb = StringBuffer();
    for (final segPath in segmentPaths) {
      final filename = segPath.split(RegExp(r'[/\\]')).last;
      sb.writeln("file '$filename'");
    }
    await File(fileListPath).writeAsString(sb.toString());

    final process = await Process.start('ffmpeg', [
      '-f', 'concat',
      '-safe', '0',
      '-i', fileListPath,
      '-c', 'copy',
      '-fflags', '+discardcorrupt+genpts',
      '-y',
      outputPath,
    ], workingDirectory: segDir);

    int exitCode;
    try {
      exitCode = await process.exitCode.timeout(
        const Duration(minutes: 2),
        onTimeout: () {
          process.kill(ProcessSignal.sigterm);
          return -1;
        },
      );
    } catch (e) {
      process.kill(ProcessSignal.sigterm);
      rethrow;
    }

    try { await File(fileListPath).delete(); } catch (_) {}

    if (exitCode != 0) {
      if (File(outputPath).existsSync()) {
        try { await File(outputPath).delete(); } catch (_) {}
      }
      throw Exception('ffmpeg merge failed (exit code: $exitCode)');
    }
  }

  void _emitProgress(String id, int received, int total) {
    final progress = total > 0 ? received / total : 0.0;
    _updateMemory(id,
      downloadedBytes: received,
      totalBytes: total,
      progress: progress,
    );
    _db.updateDownload(id, {
      'downloaded_bytes': received,
      'total_bytes': total,
      'progress': progress,
    });
  }

  bool _isM3u8Url(String url) {
    final lower = url.toLowerCase();
    return lower.contains('.m3u8') || lower.contains('m3u8');
  }

  Future<void> pauseDownload(String id) async {
    _cancelTokens[id]?.cancel('User paused');
    _updateMemory(id, status: DownloadStatus.paused);
    await _db.updateDownload(id, {'status': 'paused'});
  }

  Future<void> resumeDownload(String id) async {
    await startDownload(id);
  }

  Future<void> cancelDownload(String id) async {
    _cancelTokens[id]?.cancel('User cancelled');
    _taskStates.remove(id);
    _progressController.add(DownloadTask(
      id: id, title: '', url: '', savePath: '',
      status: DownloadStatus.cancelled,
    ));
    await _db.removeDownload(id);
  }

  DownloadTask _rowToTask(Map<String, dynamic> r) {
    return DownloadTask(
      id: r['id'] as String,
      title: r['title'] as String,
      url: r['url'] as String,
      savePath: r['save_path'] as String,
      status: DownloadStatus.values.firstWhere(
        (s) => s.name == r['status'],
        orElse: () => DownloadStatus.pending,
      ),
      downloadedBytes: (r['downloaded_bytes'] as num?)?.toInt() ?? 0,
      totalBytes: (r['total_bytes'] as num?)?.toInt() ?? 0,
      progress: (r['progress'] as num?)?.toDouble() ?? 0.0,
      totalSegments: (r['total_segments'] as num?)?.toInt() ?? 0,
      downloadedSegments: (r['downloaded_segments'] as num?)?.toInt() ?? 0,
      sourceName: r['source_name'] as String?,
      episodeName: r['episode_name'] as String?,
      errorMessage: r['error_message'] as String?,
      createdAt: r['created_at'] != null
          ? DateTime.tryParse(r['created_at'] as String)
          : null,
      completedAt: r['completed_at'] != null
          ? DateTime.tryParse(r['completed_at'] as String)
          : null,
    );
  }

  void dispose() {
    for (final token in _cancelTokens.values) {
      token.cancel('Service disposed');
    }
    _cancelTokens.clear();
    _progressController.close();
  }
}

/// Simple semaphore for controlling concurrent downloads.
class _Semaphore {
  final int maxCount;
  int _currentCount;
  final _waitQueue = <Completer<void>>[];

  _Semaphore(this.maxCount) : _currentCount = maxCount;

  Future<void> acquire() async {
    if (_currentCount > 0) {
      _currentCount--;
      return;
    }
    final completer = Completer<void>();
    _waitQueue.add(completer);
    return completer.future;
  }

  void release() {
    if (_waitQueue.isNotEmpty) {
      _waitQueue.removeAt(0).complete();
    } else {
      _currentCount++;
    }
  }
}
