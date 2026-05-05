import '../db/database.dart';
import '../models/history_item.dart';

class HistoryService {
  final AppDatabase _db;

  HistoryService(this._db);

  Future<List<HistoryItem>> getAll({int limit = 100}) async {
    final rows = await _db.getHistory(limit: limit);
    return rows.map((r) => HistoryItem(
      videoId: r['video_id'] as String,
      title: r['title'] as String,
      imageUrl: r['image_url'] as String?,
      sourceName: r['source_name'] as String?,
      episodeIndex: (r['episode_index'] as num?)?.toInt() ?? 0,
      episodeName: r['episode_name'] as String? ?? '',
      position: (r['position'] as num?)?.toDouble() ?? 0.0,
      duration: (r['duration'] as num?)?.toDouble() ?? 0.0,
      watchedAt: r['watched_at'] != null
          ? DateTime.tryParse(r['watched_at'] as String)
          : null,
    )).toList();
  }

  Future<void> add(HistoryItem item) async {
    await _db.addHistory({
      'video_id': item.videoId,
      'title': item.title,
      'image_url': item.imageUrl,
      'source_name': item.sourceName,
      'episode_index': item.episodeIndex,
      'episode_name': item.episodeName,
      'position': item.position,
      'duration': item.duration,
      'watched_at': (item.watchedAt ?? DateTime.now()).toIso8601String(),
    });
  }

  Future<void> updateProgress(
    String videoId,
    String sourceName, {
    required double position,
    required double duration,
    required int episodeIndex,
    String? episodeName,
  }) async {
    await _db.addHistory({
      'video_id': videoId,
      'title': '', // Will be preserved by UPSERT
      'source_name': sourceName,
      'episode_index': episodeIndex,
      'episode_name': episodeName ?? '',
      'position': position,
      'duration': duration,
      'watched_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> clear() async {
    await _db.clearHistory();
  }
}
