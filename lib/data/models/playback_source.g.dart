// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaybackSourceImpl _$$PlaybackSourceImplFromJson(Map<String, dynamic> json) =>
    _$PlaybackSourceImpl(
      name: json['name'] as String,
      urls:
          (json['urls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      format: json['format'] as String? ?? 'auto',
      quality: json['quality'] as String? ?? 'auto',
    );

Map<String, dynamic> _$$PlaybackSourceImplToJson(
  _$PlaybackSourceImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'urls': instance.urls,
  'format': instance.format,
  'quality': instance.quality,
};
