// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DownloadTaskImpl _$$DownloadTaskImplFromJson(Map<String, dynamic> json) =>
    _$DownloadTaskImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      savePath: json['savePath'] as String,
      status:
          $enumDecodeNullable(_$DownloadStatusEnumMap, json['status']) ??
          DownloadStatus.pending,
      downloadedBytes: (json['downloadedBytes'] as num?)?.toInt() ?? 0,
      totalBytes: (json['totalBytes'] as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      totalSegments: (json['totalSegments'] as num?)?.toInt() ?? 0,
      downloadedSegments: (json['downloadedSegments'] as num?)?.toInt() ?? 0,
      sourceName: json['sourceName'] as String?,
      episodeName: json['episodeName'] as String?,
      errorMessage: json['errorMessage'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$DownloadTaskImplToJson(_$DownloadTaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'savePath': instance.savePath,
      'status': _$DownloadStatusEnumMap[instance.status]!,
      'downloadedBytes': instance.downloadedBytes,
      'totalBytes': instance.totalBytes,
      'progress': instance.progress,
      'totalSegments': instance.totalSegments,
      'downloadedSegments': instance.downloadedSegments,
      'sourceName': instance.sourceName,
      'episodeName': instance.episodeName,
      'errorMessage': instance.errorMessage,
      'createdAt': instance.createdAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$DownloadStatusEnumMap = {
  DownloadStatus.pending: 'pending',
  DownloadStatus.downloading: 'downloading',
  DownloadStatus.paused: 'paused',
  DownloadStatus.completed: 'completed',
  DownloadStatus.failed: 'failed',
  DownloadStatus.cancelled: 'cancelled',
};
