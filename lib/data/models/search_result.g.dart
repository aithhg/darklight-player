// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      videoId: json['videoId'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
      sourceName: json['sourceName'] as String?,
      year: json['year'] as String?,
      typeName: json['typeName'] as String?,
      remarks: json['remarks'] as String?,
      area: json['area'] as String?,
      actors: json['actors'] as String?,
    );

Map<String, dynamic> _$$SearchResultImplToJson(_$SearchResultImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'sourceName': instance.sourceName,
      'year': instance.year,
      'typeName': instance.typeName,
      'remarks': instance.remarks,
      'area': instance.area,
      'actors': instance.actors,
    };
