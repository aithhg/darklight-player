import 'dart:convert';
import 'package:dio/dio.dart';

class M3u8Segment {
  final double duration;
  final String url;
  final String? encryptionKeyUrl;
  final String? encryptionIv;

  const M3u8Segment({
    required this.duration,
    required this.url,
    this.encryptionKeyUrl,
    this.encryptionIv,
  });
}

class M3u8Playlist {
  final List<M3u8Variant> variants;
  final List<M3u8Segment> segments;
  final bool isMaster;

  const M3u8Playlist({
    this.variants = const [],
    this.segments = const [],
    this.isMaster = false,
  });

  M3u8Variant? get bestVariant {
    if (variants.isEmpty) return null;
    return variants.reduce((a, b) =>
        a.bandwidth > b.bandwidth ? a : b);
  }
}

class M3u8Variant {
  final String url;
  final int bandwidth;
  final String? resolution;

  const M3u8Variant({
    required this.url,
    required this.bandwidth,
    this.resolution,
  });
}

class M3u8Parser {
  final Dio _dio;

  M3u8Parser(this._dio);

  /// Parse an m3u8 URL, resolving master playlists to the best variant.
  Future<M3u8Playlist> parse(String url, {CancelToken? cancelToken}) async {
    final playlist = await _fetchAndParse(url, cancelToken: cancelToken);

    if (playlist.isMaster && playlist.variants.isNotEmpty) {
      final best = playlist.bestVariant!;
      final variantUrl = _resolveRelativeUrl(url, best.url);
      return await _fetchAndParse(variantUrl, cancelToken: cancelToken);
    }

    return playlist;
  }

  Future<M3u8Playlist> _fetchAndParse(String url, {CancelToken? cancelToken}) async {
    final resp = await _dio.get<String>(url,
        cancelToken: cancelToken,
        options: Options(responseType: ResponseType.plain));
    final body = resp.data ?? '';
    return _parseBody(body, baseUrl: url);
  }

  M3u8Playlist _parseBody(String body, {required String baseUrl}) {
    final lines = body.split('\n').map((l) => l.trim()).toList();

    if (!lines.any((l) => l.startsWith('#EXTM3U'))) {
      return const M3u8Playlist();
    }

    // Check if master playlist
    if (lines.any((l) => l.startsWith('#EXT-X-STREAM-INF'))) {
      return _parseMasterPlaylist(lines, baseUrl: baseUrl);
    }

    return _parseMediaPlaylist(lines, baseUrl: baseUrl);
  }

  M3u8Playlist _parseMasterPlaylist(List<String> lines, {required String baseUrl}) {
    final variants = <M3u8Variant>[];

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (!line.startsWith('#EXT-X-STREAM-INF')) continue;

      final bandwidth = _extractAttribute(line, 'BANDWIDTH');
      final resolution = _extractAttribute(line, 'RESOLUTION');

      // Next non-empty line is the URL
      var url = '';
      for (var j = i + 1; j < lines.length; j++) {
        if (lines[j].isNotEmpty && !lines[j].startsWith('#')) {
          url = lines[j];
          break;
        }
      }

      if (url.isNotEmpty && bandwidth != null) {
        variants.add(M3u8Variant(
          url: url,
          bandwidth: int.tryParse(bandwidth) ?? 0,
          resolution: resolution,
        ));
      }
    }

    return M3u8Playlist(variants: variants, isMaster: true);
  }

  M3u8Playlist _parseMediaPlaylist(List<String> lines, {required String baseUrl}) {
    final segments = <M3u8Segment>[];
    var currentDuration = 0.0;
    String? currentKeyUrl;
    String? currentKeyIv;

    for (final line in lines) {
      if (line.startsWith('#EXT-X-KEY')) {
        final method = _extractAttribute(line, 'METHOD');
        if (method != null && method != 'NONE') {
          currentKeyUrl = _extractQuotedAttribute(line, 'URI');
          currentKeyIv = _extractAttribute(line, 'IV');
        } else {
          currentKeyUrl = null;
          currentKeyIv = null;
        }
      } else if (line.startsWith('#EXTINF')) {
        final match = RegExp(r'#EXTINF:([\d.]+)').firstMatch(line);
        currentDuration = double.tryParse(match?.group(1) ?? '0') ?? 0;
      } else if (line.isNotEmpty && !line.startsWith('#')) {
        final resolvedKey = currentKeyUrl != null
            ? _resolveRelativeUrl(baseUrl, currentKeyUrl)
            : null;
        segments.add(M3u8Segment(
          duration: currentDuration,
          url: _resolveRelativeUrl(baseUrl, line),
          encryptionKeyUrl: resolvedKey,
          encryptionIv: currentKeyIv,
        ));
        currentDuration = 0;
      }
    }

    return M3u8Playlist(segments: segments, isMaster: false);
  }

  /// Resolve nested m3u8 references (up to 3 levels deep).
  Future<List<M3u8Segment>> resolveNestedSegments(
    List<M3u8Segment> segments, {
    CancelToken? cancelToken,
    int maxDepth = 3,
  }) async {
    if (maxDepth <= 0) return segments;

    final resolved = <M3u8Segment>[];
    for (final seg in segments) {
      if (seg.url.endsWith('.m3u8')) {
        final nested = await _fetchAndParse(seg.url, cancelToken: cancelToken);
        final nestedResolved = await resolveNestedSegments(
          nested.segments,
          cancelToken: cancelToken,
          maxDepth: maxDepth - 1,
        );
        resolved.addAll(nestedResolved);
      } else {
        resolved.add(seg);
      }
    }
    return resolved;
  }

  /// Build a local m3u8 playlist that references local .ts files.
  String buildLocalM3u8(List<String> localSegmentPaths, {List<double>? durations}) {
    final sb = StringBuffer();
    sb.writeln('#EXTM3U');
    sb.writeln('#EXT-X-VERSION:3');
    sb.writeln('#EXT-X-TARGETDURATION:10');
    sb.writeln('#EXT-X-MEDIA-SEQUENCE:0');

    for (var i = 0; i < localSegmentPaths.length; i++) {
      final duration = (durations != null && i < durations.length)
          ? durations[i]
          : 10.0;
      sb.writeln('#EXTINF:${duration.toStringAsFixed(3)},');
      // Normalize path separators for mpv compatibility
      sb.writeln(localSegmentPaths[i].replaceAll('\\', '/'));
    }

    sb.writeln('#EXT-X-ENDLIST');
    return sb.toString();
  }

  String _resolveRelativeUrl(String baseUrl, String relativeUrl) {
    if (relativeUrl.startsWith('http://') || relativeUrl.startsWith('https://')) {
      return relativeUrl;
    }
    final base = Uri.parse(baseUrl);
    if (relativeUrl.startsWith('/')) {
      return '${base.scheme}://${base.host}$relativeUrl';
    }
    final basePath = base.path.substring(0, base.path.lastIndexOf('/') + 1);
    return '${base.scheme}://${base.host}$basePath$relativeUrl';
  }

  String? _extractAttribute(String line, String attr) {
    final regex = RegExp('$attr=(\\d+)');
    return regex.firstMatch(line)?.group(1);
  }

  String? _extractQuotedAttribute(String line, String attr) {
    final regex = RegExp('$attr="([^"]+)"');
    return regex.firstMatch(line)?.group(1);
  }
}
