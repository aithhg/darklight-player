import 'package:dio/dio.dart';

class UrlResolver {
  final Dio _dio;

  UrlResolver(this._dio);

  /// Resolve a URL that might be a share/redirect URL or an API response.
  Future<String> resolve(String url) async {
    // Pattern 1: maccms play API URL
    if (url.contains('?ac=play&url=')) {
      return _resolvePlayApi(url);
    }

    // Pattern 2: Direct stream URL — use as-is
    if (_isStreamUrl(url)) {
      return url;
    }

    // Pattern 3: Share/redirect URL — try to resolve
    return _resolveRedirect(url);
  }

  Future<String> _resolvePlayApi(String url) async {
    try {
      final resp = await _dio.get(url);
      final data = resp.data;

      if (data is Map<String, dynamic>) {
        final resolved = data['url'] as String? ??
            data['data'] as String? ??
            (data['data'] is Map ? (data['data'] as Map)['url'] as String? : null) ??
            (data['data'] is Map ? (data['data'] as Map)['data'] as String? : null);
        if (resolved != null && resolved.isNotEmpty) return resolved;
      }

      if (data is String) return data;
      return url;
    } catch (_) {
      return url;
    }
  }

  Future<String> _resolveRedirect(String url) async {
    try {
      final resp = await _dio.get(url,
          options: Options(followRedirects: true, validateStatus: (s) => s != null && s < 400));
      final finalUrl = resp.realUri.toString();
      if (finalUrl != url && _isStreamUrl(finalUrl)) return finalUrl;

      final contentType = resp.headers.value('content-type') ?? '';
      if (contentType.contains('text/html')) {
        final body = resp.data as String;
        // Try absolute URL first
        final extracted = _extractStreamUrl(body);
        if (extracted != null) return extracted;
        // Try relative URL and resolve against page base
        final relative = _extractRelativeStreamUrl(body);
        if (relative != null) {
          final base = Uri.parse(url);
          return '${base.scheme}://${base.host}$relative';
        }
      }

      return url;
    } catch (_) {
      return url;
    }
  }

  bool _isStreamUrl(String url) {
    final lower = url.toLowerCase();
    return lower.contains('.m3u8') ||
        lower.contains('.mp4') ||
        lower.contains('.flv') ||
        lower.contains('.ts') ||
        lower.contains('.mkv');
  }

  String? _extractStreamUrl(String html) {
    final regex = RegExp(r"""https?://[^\s"'<>]+\.(?:m3u8|mp4|flv|ts)""");
    final match = regex.firstMatch(html);
    return match?.group(0);
  }

  String? _extractRelativeStreamUrl(String html) {
    // Match patterns like: var main = "/path/to/video.m3u8?sign=...";
    final regex = RegExp(r"""(?:var\s+main\s*=\s*|url\s*[:=]\s*)["'](/[^"'\s<>]+\.(?:m3u8|mp4|flv|ts)[^"'\s<>]*)["']""");
    final match = regex.firstMatch(html);
    return match?.group(1);
  }
}
