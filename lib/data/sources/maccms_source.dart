import 'dart:convert';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/search_result.dart';
import '../models/video_detail.dart';
import '../models/episode.dart';
import '../models/playback_source.dart';
import 'video_source.dart';

const _searchTimeout = Duration(seconds: 8);
const _detailTimeout = Duration(seconds: 10);
const _pingTimeout = Duration(seconds: 5);

Dio _createDio() {
  final dio = Dio(BaseOptions(
    connectTimeout: _searchTimeout,
    receiveTimeout: _searchTimeout,
    responseType: ResponseType.plain,
    headers: {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      'Referer': 'https://www.baidu.com/',
    },
  ));
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback = (_, __, ___) => true;
    return client;
  };
  dio.interceptors.add(InterceptorsWrapper(
    onResponse: (response, handler) {
      if (response.data is String) {
        final str = response.data as String;
        // Skip HTML responses (redirect pages, captchas)
        if (str.trimLeft().startsWith('<')) {
          debugPrint('[MaccmsSource] Got HTML response, skipping JSON parse');
          handler.reject(DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: 'API returned HTML instead of JSON',
          ));
          return;
        }
        try {
          response.data = _parseJson(str);
        } catch (e) {
          debugPrint('[MaccmsSource] JSON parse error: $e');
        }
      }
      handler.next(response);
    },
  ));
  return dio;
}

Map<String, dynamic> _parseJson(String text) {
  // Use dart:convert's jsonDecode
  return Map<String, dynamic>.from(
    const JsonDecoder().convert(text) as Map,
  );
}

class MaccmsSource implements VideoSource {
  @override
  final String name;

  @override
  final String apiBase;

  @override
  bool enabled;

  final Dio _dio;

  MaccmsSource({
    required this.name,
    required this.apiBase,
    this.enabled = true,
    Dio? dio,
  }) : _dio = dio ?? _createDio();

  String get _api {
    var base = apiBase;
    if (!base.endsWith('/') && !base.endsWith('?')) base = '$base/';
    if (!base.endsWith('?')) base = '$base?';
    return base;
  }

  @override
  Future<List<SearchResult>> search(String query, {int page = 1}) async {
    final url = '${_api}ac=detail&wd=${Uri.encodeComponent(query)}&pg=$page';

    try {
      final resp = await _dio.get(url,
          options: Options(receiveTimeout: _searchTimeout));
      final data = resp.data as Map<String, dynamic>;
      return _parseSearchResults(data);
    } on DioException catch (e) {
      throw Exception('Search failed for $name: ${e.message}');
    }
  }

  @override
  Future<VideoDetail> getDetail(String videoId) async {
    final url = '${_api}ac=detail&ids=$videoId';

    try {
      final resp = await _dio.get(url,
          options: Options(receiveTimeout: _detailTimeout));
      final data = resp.data as Map<String, dynamic>;

      final item = _extractFirstItem(data);
      if (item == null) throw Exception('No video data in response');

      return _parseVideoDetail(item);
    } on DioException catch (e) {
      throw Exception('Detail failed for $name: ${e.message}');
    }
  }

  @override
  Future<List<SearchResult>> getHomeFeed({int page = 1}) async {
    final url = '${_api}ac=videolist&pg=$page';
    debugPrint('[MaccmsSource] $name getHomeFeed: $url');

    try {
      final resp = await _dio.get(url,
          options: Options(receiveTimeout: _searchTimeout));
      final data = resp.data as Map<String, dynamic>;
      final results = _parseSearchResults(data);
      debugPrint('[MaccmsSource] $name getHomeFeed: ${results.length} results');
      return results;
    } on DioException catch (e) {
      debugPrint('[MaccmsSource] $name getHomeFeed error: ${e.type} ${e.message}');
      throw Exception('Home feed failed for $name: ${e.message}');
    }
  }

  @override
  Future<List<SearchResult>> getCategory(String category, {int page = 1}) async {
    final url = '${_api}ac=videolist&t=$category&pg=$page';

    try {
      final resp = await _dio.get(url,
          options: Options(receiveTimeout: _searchTimeout));
      final data = resp.data as Map<String, dynamic>;
      return _parseSearchResults(data);
    } on DioException catch (e) {
      throw Exception('Category failed for $name: ${e.message}');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    return ['电影', '剧集', '动漫', '综艺', '纪录片'];
  }

  @override
  Future<bool> healthCheck() async {
    final url = '${_api}ac=detail&wd=test';
    try {
      final resp = await _dio.get(url,
          options: Options(receiveTimeout: _pingTimeout));
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  // --- Parsing ---

  List<SearchResult> _parseSearchResults(Map<String, dynamic> data) {
    final arr = (data['list'] ?? data['data']) as List<dynamic>?;
    if (arr == null || arr.isEmpty) return [];

    return arr.map((item) {
      final m = item as Map<String, dynamic>;
      return SearchResult(
        videoId: _valStr(m, 'vod_id') ?? '',
        title: _valStr(m, 'vod_name') ?? '',
        imageUrl: _valStr(m, 'vod_pic'),
        sourceName: name,
        year: _valStr(m, 'vod_year'),
        typeName: _valStr(m, 'type_name'),
        remarks: _valStr(m, 'vod_remarks'),
        area: _valStr(m, 'vod_area'),
        actors: _valStr(m, 'vod_actor'),
      );
    }).toList();
  }

  Map<String, dynamic>? _extractFirstItem(Map<String, dynamic> data) {
    final arr = (data['list'] ?? data['data']) as List<dynamic>?;
    if (arr == null || arr.isEmpty) return null;
    return arr.first as Map<String, dynamic>;
  }

  VideoDetail _parseVideoDetail(Map<String, dynamic> item) {
    final episodes = _parseEpisodes(item);

    return VideoDetail(
      videoId: _valStr(item, 'vod_id') ?? '',
      title: _valStr(item, 'vod_name') ?? '',
      imageUrl: _valStr(item, 'vod_pic'),
      description: _valStr(item, 'vod_content') ?? _valStr(item, 'vod_blurb'),
      year: _valStr(item, 'vod_year'),
      typeName: _valStr(item, 'type_name'),
      area: _valStr(item, 'vod_area'),
      director: _valStr(item, 'vod_director'),
      actors: _valStr(item, 'vod_actor'),
      remarks: _valStr(item, 'vod_remarks'),
      updateTime: _valStr(item, 'vod_time'),
      episodes: episodes,
      sourceName: name,
    );
  }

  List<Episode> _parseEpisodes(Map<String, dynamic> item) {
    final playFrom = _valStr(item, 'vod_play_from') ?? '';
    final playUrlStr = _valStr(item, 'vod_play_url') ?? '';

    final sep = '\$\$\$';
    final fromList = playFrom.split(sep).where((s) => s.isNotEmpty).toList();
    final urlList = playUrlStr.split(sep).where((s) => s.isNotEmpty).toList();

    // Collect all sources per episode
    final episodeSources = <String, List<MapEntry<String, String>>>{};

    for (var i = 0; i < fromList.length && i < urlList.length; i++) {
      final sourceName = fromList[i].trim();
      final epLines = urlList[i].split('#').where((s) => s.isNotEmpty);

      for (final epLine in epLines) {
        final parts = epLine.split('\$');
        if (parts.length == 2) {
          final epTitle = parts[0].trim();
          final rawUrl = parts[1].trim();
          final url = (rawUrl.startsWith('http://') || rawUrl.startsWith('https://'))
              ? rawUrl
              : '${_api}ac=play&url=$rawUrl';

          episodeSources.putIfAbsent(epTitle, () => []);
          episodeSources[epTitle]!.add(MapEntry(sourceName, url));
        }
      }
    }

    // For each episode, prefer direct stream URLs over share/redirect URLs
    return episodeSources.entries.map((entry) {
      final sources = entry.value;
      // Pick the best URL: direct stream > share/redirect
      var best = sources.first;
      for (final src in sources) {
        if (_isDirectStream(src.value) && !_isDirectStream(best.value)) {
          best = src;
          break;
        }
      }
      return Episode(name: entry.key, url: best.value);
    }).toList();
  }

  bool _isDirectStream(String url) {
    final lower = url.toLowerCase();
    return lower.contains('.m3u8') ||
        lower.contains('.mp4') ||
        lower.contains('.flv') ||
        lower.contains('.ts');
  }

  String? _valStr(Map<String, dynamic> m, String key) {
    final v = m[key];
    if (v == null) return null;
    final s = v.toString().trim();
    return s.isEmpty ? null : s;
  }
}
