// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EpisodeImpl _$$EpisodeImplFromJson(Map<String, dynamic> json) =>
    _$EpisodeImpl(
      name: json['name'] as String,
      url: json['url'] as String,
      index: (json['index'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$EpisodeImplToJson(_$EpisodeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'index': instance.index,
    };
