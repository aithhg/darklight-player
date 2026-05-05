import 'dart:async';
import '../models/search_result.dart';
import '../models/video_detail.dart';
import '../services/source_service.dart';
import 'video_source.dart';

/// Manages parallel search across multiple sources with deduplication.
class SourceRegistry {
  final SourceService _sourceService;

  SourceRegistry(this._sourceService);

  /// Search across all enabled sources in parallel.
  /// Returns deduplicated results sorted by relevance.
  Future<List<SearchResult>> searchAll(String query) async {
    final sources = _sourceService.enabledSources;
    if (sources.isEmpty) return [];

    final futures = sources.map((source) async {
      try {
        return await source.search(query);
      } catch (_) {
        return <SearchResult>[];
      }
    });

    final results = await Future.wait(futures);
    final allResults = results.expand((r) => r).toList();

    return _deduplicate(allResults);
  }

  /// Get detail from a specific source.
  Future<VideoDetail> getDetail(String sourceName, String videoId) async {
    final source = _sourceService.findSource(sourceName);
    if (source == null) {
      throw Exception('Source not found: $sourceName');
    }
    return source.getDetail(videoId);
  }

  /// Get home feeds from all enabled sources in parallel.
  Future<Map<String, List<SearchResult>>> getAllHomeFeeds() async {
    final sources = _sourceService.enabledSources;
    final map = <String, List<SearchResult>>{};

    final futures = sources.map((source) async {
      try {
        final feed = await source.getHomeFeed();
        map[source.name] = feed;
      } catch (_) {
        map[source.name] = [];
      }
    });

    await Future.wait(futures);
    return map;
  }

  /// Deduplicate results by title similarity.
  List<SearchResult> _deduplicate(List<SearchResult> results) {
    final seen = <String>{};
    final deduplicated = <SearchResult>[];

    for (final result in results) {
      final key = _normalizeTitle(result.title);
      if (!seen.contains(key)) {
        seen.add(key);
        deduplicated.add(result);
      }
    }

    return deduplicated;
  }

  String _normalizeTitle(String title) {
    return title
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll(RegExp(r'[第全集季期]'), '')
        .toLowerCase();
  }
}
