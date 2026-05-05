import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_item.freezed.dart';
part 'history_item.g.dart';

@freezed
class HistoryItem with _$HistoryItem {
  const factory HistoryItem({
    required String videoId,
    required String title,
    String? imageUrl,
    String? sourceName,
    @Default(0) int episodeIndex,
    @Default('') String episodeName,
    @Default(0.0) double position,
    @Default(0.0) double duration,
    DateTime? watchedAt,
  }) = _HistoryItem;

  factory HistoryItem.fromJson(Map<String, dynamic> json) =>
      _$HistoryItemFromJson(json);
}
