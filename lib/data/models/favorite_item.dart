import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_item.freezed.dart';
part 'favorite_item.g.dart';

@freezed
class FavoriteItem with _$FavoriteItem {
  const factory FavoriteItem({
    required String videoId,
    required String title,
    String? imageUrl,
    String? sourceName,
    String? typeName,
    String? remarks,
    DateTime? addedAt,
  }) = _FavoriteItem;

  factory FavoriteItem.fromJson(Map<String, dynamic> json) =>
      _$FavoriteItemFromJson(json);
}
