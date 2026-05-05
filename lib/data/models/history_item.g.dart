// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryItemImpl _$$HistoryItemImplFromJson(Map<String, dynamic> json) =>
    _$HistoryItemImpl(
      videoId: json['videoId'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
      sourceName: json['sourceName'] as String?,
      episodeIndex: (json['episodeIndex'] as num?)?.toInt() ?? 0,
      episodeName: json['episodeName'] as String? ?? '',
      position: (json['position'] as num?)?.toDouble() ?? 0.0,
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      watchedAt: json['watchedAt'] == null
          ? null
          : DateTime.parse(json['watchedAt'] as String),
    );

Map<String, dynamic> _$$HistoryItemImplToJson(_$HistoryItemImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'sourceName': instance.sourceName,
      'episodeIndex': instance.episodeIndex,
      'episodeName': instance.episodeName,
      'position': instance.position,
      'duration': instance.duration,
      'watchedAt': instance.watchedAt?.toIso8601String(),
    };
