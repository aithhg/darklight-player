import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_task.freezed.dart';
part 'download_task.g.dart';

enum DownloadStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('downloading')
  downloading,
  @JsonValue('paused')
  paused,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('cancelled')
  cancelled,
}

@freezed
class DownloadTask with _$DownloadTask {
  const factory DownloadTask({
    required String id,
    required String title,
    required String url,
    required String savePath,
    @Default(DownloadStatus.pending) DownloadStatus status,
    @Default(0) int downloadedBytes,
    @Default(0) int totalBytes,
    @Default(0.0) double progress,
    @Default(0) int totalSegments,
    @Default(0) int downloadedSegments,
    String? sourceName,
    String? episodeName,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? completedAt,
  }) = _DownloadTask;

  factory DownloadTask.fromJson(Map<String, dynamic> json) =>
      _$DownloadTaskFromJson(json);
}
