import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/service_provider.dart';
import '../../data/models/download_task.dart';
import '../../shared/utils/format_utils.dart';

class DownloadView extends StatefulWidget {
  const DownloadView({super.key});

  @override
  State<DownloadView> createState() => _DownloadViewState();
}

class _DownloadViewState extends State<DownloadView> {
  List<DownloadTask> _tasks = [];
  bool _loading = true;
  StreamSubscription<DownloadTask>? _progressSub;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _progressSub?.cancel();
    final sp = context.read<ServiceProvider>();
    _progressSub = sp.downloadService.progressStream.listen((task) {
      if (!mounted) return;
      setState(() {
        final idx = _tasks.indexWhere((t) => t.id == task.id);
        if (idx >= 0) {
          _tasks[idx] = task;
        } else if (task.status == DownloadStatus.cancelled) {
          _tasks.removeWhere((t) => t.id == task.id);
        }
      });
    });
    _loadTasks();
  }

  @override
  void dispose() {
    _progressSub?.cancel();
    super.dispose();
  }

  Future<void> _loadTasks() async {
    final sp = context.read<ServiceProvider>();
    final tasks = await sp.downloadService.getAll();
    if (!mounted) return;
    setState(() {
      _tasks = tasks;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('下载管理',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
              const Spacer(),
              if (_tasks.isNotEmpty)
                TextButton.icon(
                  onPressed: () async {
                    final sp = context.read<ServiceProvider>();
                    for (final t in _tasks) {
                      if (t.status == DownloadStatus.completed ||
                          t.status == DownloadStatus.failed ||
                          t.status == DownloadStatus.cancelled) {
                        await sp.downloadService.cancelDownload(t.id);
                      }
                    }
                    _loadTasks();
                  },
                  icon: const Icon(Icons.delete_sweep_rounded, size: 18),
                  label: const Text('清除已完成'),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _loading
                ? const Center(
                    child:
                        CircularProgressIndicator(color: AppTheme.accent))
                : _tasks.isEmpty
                    ? _buildEmpty()
                    : _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.download_rounded,
              size: 64,
              color: AppTheme.textTertiary.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text('暂无下载任务',
              style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textTertiary.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Text('在视频详情页可以添加下载任务',
              style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.textTertiary.withValues(alpha: 0.4))),
        ],
      ),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      color: AppTheme.accent,
      onRefresh: _loadTasks,
      child: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return _DownloadTile(
            task: task,
            onStart: (task.status == DownloadStatus.pending || task.status == DownloadStatus.failed)
                ? () => _startDownload(task.id)
                : null,
            onPause: task.status == DownloadStatus.downloading
                ? () => _pauseDownload(task.id)
                : null,
            onResume: task.status == DownloadStatus.paused
                ? () => _resumeDownload(task.id)
                : null,
            onPlay: task.status == DownloadStatus.completed
                ? () => _playDownload(task)
                : null,
            onOpenFolder: () {
              final folder = Directory(task.savePath).parent.path.replaceAll('/', '\\');
              Process.start('explorer', [folder]);
            },
            onCancel: () => _cancelDownload(task.id),
          );
        },
      ),
    );
  }

  Future<void> _startDownload(String id) async {
    final sp = context.read<ServiceProvider>();
    // Fire and forget — progress AND completion come via stream
    // Do NOT call _loadTasks() — it would overwrite stream progress with stale DB data
    sp.downloadService.startDownload(id);
    // Immediately show downloading status
    setState(() {
      final idx = _tasks.indexWhere((t) => t.id == id);
      if (idx >= 0) {
        _tasks[idx] = _tasks[idx].copyWith(status: DownloadStatus.downloading);
      }
    });
  }

  Future<void> _pauseDownload(String id) async {
    final sp = context.read<ServiceProvider>();
    await sp.downloadService.pauseDownload(id);
    _loadTasks();
  }

  Future<void> _resumeDownload(String id) async {
    final sp = context.read<ServiceProvider>();
    // Same as _startDownload — stream handles all updates
    sp.downloadService.startDownload(id);
    setState(() {
      final idx = _tasks.indexWhere((t) => t.id == id);
      if (idx >= 0) {
        _tasks[idx] = _tasks[idx].copyWith(status: DownloadStatus.downloading);
      }
    });
  }

  Future<void> _cancelDownload(String id) async {
    final sp = context.read<ServiceProvider>();
    await sp.downloadService.cancelDownload(id);
    _loadTasks();
  }

  void _playDownload(DownloadTask task) async {
    final savePath = task.savePath;
    final m3u8Path = savePath.replaceAll(RegExp(r'\.mp4$'), '.m3u8');
    String playPath;

    if (File(savePath).existsSync() && !_isM3u8Content(savePath)) {
      // File exists and is not m3u8 text — validate it's a real video (> 1MB)
      final fileSize = await File(savePath).length();
      if (fileSize > 1024 * 1024) {
        playPath = savePath; // Valid merged MP4
      } else {
        // MP4 too small — likely corrupt/partial, try m3u8 fallback
        playPath = File(m3u8Path).existsSync() ? m3u8Path : savePath;
      }
    } else if (File(m3u8Path).existsSync()) {
      playPath = m3u8Path;
    } else if (File(savePath).existsSync() && _isM3u8Content(savePath)) {
      // Legacy: .mp4 file actually contains m3u8 text — rename it
      File(savePath).renameSync(m3u8Path);
      playPath = m3u8Path;
    } else {
      playPath = savePath;
    }

    if (!mounted) return;
    context.push('/player', extra: {
      'sourceName': 'local',
      'videoId': task.id,
      'episodeIndex': 0,
      'title': task.title,
      'localPath': playPath,
    });
  }

  bool _isM3u8Content(String path) {
    try {
      final file = File(path);
      if (!file.existsSync()) return false;
      // Read first 200 bytes to check if it's m3u8 text
      final bytes = file.readAsBytesSync().take(200).toList();
      final content = String.fromCharCodes(bytes);
      return content.contains('#EXTM3U');
    } catch (_) {
      return false;
    }
  }
}

class _DownloadTile extends StatelessWidget {
  final DownloadTask task;
  final VoidCallback? onStart;
  final VoidCallback? onPause;
  final VoidCallback? onResume;
  final VoidCallback? onPlay;
  final VoidCallback? onCancel;
  final VoidCallback? onOpenFolder;

  const _DownloadTile({
    required this.task,
    this.onStart,
    this.onPause,
    this.onResume,
    this.onPlay,
    this.onCancel,
    this.onOpenFolder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary)),
                    if (task.episodeName != null)
                      Text(task.episodeName!,
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.textTertiary)),
                  ],
                ),
              ),
              _buildStatusChip(),
              const SizedBox(width: 8),
              _buildActions(),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: task.progress,
              backgroundColor: AppTheme.surface4,
              valueColor: AlwaysStoppedAnimation<Color>(
                task.status == DownloadStatus.completed
                    ? AppTheme.success
                    : AppTheme.accent,
              ),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _buildProgressText(task),
                style: const TextStyle(
                    fontSize: 12, color: AppTheme.textTertiary),
              ),
              Text(
                '${(task.progress * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                    fontSize: 12, color: AppTheme.textSecondary),
              ),
            ],
          ),
          if (task.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(task.errorMessage!,
                  style: const TextStyle(fontSize: 12, color: AppTheme.error)),
            ),
        ],
      ),
    );
  }

  String _buildProgressText(DownloadTask task) {
    // m3u8 download: show segment progress (totalSegments is the source of truth)
    if (task.totalSegments > 0) {
      if (task.status == DownloadStatus.completed) {
        // Show final size
        return task.downloadedBytes > 0
            ? '已完成 ${FormatUtils.fileSize(task.downloadedBytes)}'
            : '已完成';
      }
      return '${task.downloadedSegments}/${task.totalSegments} 分段';
    }
    // Direct file download: show bytes (only if totalBytes makes sense)
    if (task.totalBytes > 1024 && task.totalBytes > task.downloadedBytes) {
      return '${FormatUtils.fileSize(task.downloadedBytes)} / ${FormatUtils.fileSize(task.totalBytes)}';
    }
    // Fallback: just show downloaded bytes
    if (task.downloadedBytes > 0) {
      return '已下载 ${FormatUtils.fileSize(task.downloadedBytes)}';
    }
    return '准备中...';
  }

  Widget _buildStatusChip() {
    final (label, color) = switch (task.status) {
      DownloadStatus.pending => ('等待中', AppTheme.textTertiary),
      DownloadStatus.downloading => ('下载中', AppTheme.accent),
      DownloadStatus.paused => ('已暂停', AppTheme.warning),
      DownloadStatus.completed => ('已完成', AppTheme.success),
      DownloadStatus.failed => ('失败', AppTheme.error),
      DownloadStatus.cancelled => ('已取消', AppTheme.textTertiary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onPlay != null)
          IconButton(
            icon: const Icon(Icons.play_circle_filled_rounded, size: 20),
            onPressed: onPlay,
            color: AppTheme.accent,
            tooltip: '播放',
          ),
        if (onStart != null)
          IconButton(
            icon: const Icon(Icons.play_arrow_rounded, size: 20),
            onPressed: onStart,
            color: AppTheme.accent,
            tooltip: '开始',
          ),
        if (onPause != null)
          IconButton(
            icon: const Icon(Icons.pause_rounded, size: 20),
            onPressed: onPause,
            color: AppTheme.textSecondary,
            tooltip: '暂停',
          ),
        if (onResume != null)
          IconButton(
            icon: const Icon(Icons.play_arrow_rounded, size: 20),
            onPressed: onResume,
            color: AppTheme.accent,
            tooltip: '继续',
          ),
        if (onOpenFolder != null)
          IconButton(
            icon: const Icon(Icons.folder_open_rounded, size: 20),
            onPressed: onOpenFolder,
            color: AppTheme.textSecondary,
            tooltip: '打开文件夹',
          ),
        if (onCancel != null)
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 20),
            onPressed: onCancel,
            color: AppTheme.textTertiary,
            tooltip: '取消',
          ),
      ],
    );
  }
}
