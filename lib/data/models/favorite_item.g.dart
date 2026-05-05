// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteItemImpl _$$FavoriteItemImplFromJson(Map<String, dynamic> json) =>
    _$FavoriteItemImpl(
      videoId: json['videoId'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
      sourceName: json['sourceName'] as String?,
      typeName: json['typeName'] as String?,
      remarks: json['remarks'] as String?,
      addedAt: json['addedAt'] == null
          ? null
          : DateTime.parse(json['addedAt'] as String),
    );

Map<String, dynamic> _$$FavoriteItemImplToJson(_$FavoriteItemImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'sourceName': instance.sourceName,
      'typeName': instance.typeName,
      'remarks': instance.remarks,
      'addedAt': instance.addedAt?.toIso8601String(),
    };
