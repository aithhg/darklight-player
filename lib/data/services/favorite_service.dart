import '../db/database.dart';
import '../models/favorite_item.dart';

class FavoriteService {
  final AppDatabase _db;

  FavoriteService(this._db);

  Future<List<FavoriteItem>> getAll() async {
    final rows = await _db.getFavorites();
    return rows.map((r) => FavoriteItem(
      videoId: r['video_id'] as String,
      title: r['title'] as String,
      imageUrl: r['image_url'] as String?,
      sourceName: r['source_name'] as String?,
      typeName: r['type_name'] as String?,
      remarks: r['remarks'] as String?,
      addedAt: r['added_at'] != null
          ? DateTime.tryParse(r['added_at'] as String)
          : null,
    )).toList();
  }

  Future<void> add(FavoriteItem item) async {
    await _db.addFavorite({
      'video_id': item.videoId,
      'title': item.title,
      'image_url': item.imageUrl,
      'source_name': item.sourceName,
      'type_name': item.typeName,
      'remarks': item.remarks,
      'added_at': (item.addedAt ?? DateTime.now()).toIso8601String(),
    });
  }

  Future<void> remove(String videoId, String sourceName) async {
    await _db.removeFavorite(videoId, sourceName);
  }

  Future<bool> isFavorite(String videoId, String sourceName) async {
    return _db.isFavorite(videoId, sourceName);
  }

  Future<void> removeByTitle(String title) async {
    await _db.removeFavoriteByTitle(title);
  }
}
