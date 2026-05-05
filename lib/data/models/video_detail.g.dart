// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoDetailImpl _$$VideoDetailImplFromJson(Map<String, dynamic> json) =>
    _$VideoDetailImpl(
      videoId: json['videoId'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      year: json['year'] as String?,
      typeName: json['typeName'] as String?,
      area: json['area'] as String?,
      director: json['director'] as String?,
      actors: json['actors'] as String?,
      remarks: json['remarks'] as String?,
      updateTime: json['updateTime'] as String?,
      episodes:
          (json['episodes'] as List<dynamic>?)
              ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      playbackSources:
          (json['playbackSources'] as List<dynamic>?)
              ?.map((e) => PlaybackSource.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sourceName: json['sourceName'] as String?,
    );

Map<String, dynamic> _$$VideoDetailImplToJson(_$VideoDetailImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'year': instance.year,
      'typeName': instance.typeName,
      'area': instance.area,
      'director': instance.director,
      'actors': instance.actors,
      'remarks': instance.remarks,
      'updateTime': instance.updateTime,
      'episodes': instance.episodes,
      'playbackSources': instance.playbackSources,
      'sourceName': instance.sourceName,
    };
