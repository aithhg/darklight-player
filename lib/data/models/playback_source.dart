import 'package:freezed_annotation/freezed_annotation.dart';

part 'playback_source.freezed.dart';
part 'playback_source.g.dart';

@freezed
class PlaybackSource with _$PlaybackSource {
  const factory PlaybackSource({
    required String name,
    @Default([]) List<String> urls,
    @Default('auto') String format,
    @Default('auto') String quality,
  }) = _PlaybackSource;

  factory PlaybackSource.fromJson(Map<String, dynamic> json) =>
      _$PlaybackSourceFromJson(json);
}
