import 'package:freezed_annotation/freezed_annotation.dart';
import 'episode.dart';
import 'playback_source.dart';

part 'video_detail.freezed.dart';
part 'video_detail.g.dart';

@freezed
class VideoDetail with _$VideoDetail {
  const factory VideoDetail({
    required String videoId,
    required String title,
    String? imageUrl,
    String? description,
    String? year,
    String? typeName,
    String? area,
    String? director,
    String? actors,
    String? remarks,
    String? updateTime,
    @Default([]) List<Episode> episodes,
    @Default([]) List<PlaybackSource> playbackSources,
    String? sourceName,
  }) = _VideoDetail;

  factory VideoDetail.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailFromJson(json);
}
