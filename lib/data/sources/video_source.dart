import '../models/search_result.dart';
import '../models/video_detail.dart';

/// Abstract interface for video source providers.
///
/// Each source implements a specific API protocol (e.g., maccms)
/// and provides search, detail, and category browsing capabilities.
abstract class VideoSource {
  /// Unique name identifying this source (e.g., "量子采集")
  String get name;

  /// Base API URL for this source
  String get apiBase;

  /// Whether this source is currently enabled
  bool get enabled;

  /// Search for videos matching [query]
  Future<List<SearchResult>> search(String query, {int page = 1});

  /// Get detailed information for a video by [videoId]
  Future<VideoDetail> getDetail(String videoId);

  /// Get home page feeds (latest/popular videos)
  Future<List<SearchResult>> getHomeFeed({int page = 1});

  /// Get videos in a specific [category]
  Future<List<SearchResult>> getCategory(String category, {int page = 1});

  /// Get available categories for this source
  Future<List<String>> getCategories();

  /// Check if this source's API is reachable
  Future<bool> healthCheck();
}
