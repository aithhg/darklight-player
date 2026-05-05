// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DownloadTask _$DownloadTaskFromJson(Map<String, dynamic> json) {
  return _DownloadTask.fromJson(json);
}

/// @nodoc
mixin _$DownloadTask {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get savePath => throw _privateConstructorUsedError;
  DownloadStatus get status => throw _privateConstructorUsedError;
  int get downloadedBytes => throw _privateConstructorUsedError;
  int get totalBytes => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  int get totalSegments => throw _privateConstructorUsedError;
  int get downloadedSegments => throw _privateConstructorUsedError;
  String? get sourceName => throw _privateConstructorUsedError;
  String? get episodeName => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this DownloadTask to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DownloadTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DownloadTaskCopyWith<DownloadTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadTaskCopyWith<$Res> {
  factory $DownloadTaskCopyWith(
    DownloadTask value,
    $Res Function(DownloadTask) then,
  ) = _$DownloadTaskCopyWithImpl<$Res, DownloadTask>;
  @useResult
  $Res call({
    String id,
    String title,
    String url,
    String savePath,
    DownloadStatus status,
    int downloadedBytes,
    int totalBytes,
    double progress,
    int totalSegments,
    int downloadedSegments,
    String? sourceName,
    String? episodeName,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? completedAt,
  });
}

/// @nodoc
class _$DownloadTaskCopyWithImpl<$Res, $Val extends DownloadTask>
    implements $DownloadTaskCopyWith<$Res> {
  _$DownloadTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DownloadTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? savePath = null,
    Object? status = null,
    Object? downloadedBytes = null,
    Object? totalBytes = null,
    Object? progress = null,
    Object? totalSegments = null,
    Object? downloadedSegments = null,
    Object? sourceName = freezed,
    Object? episodeName = freezed,
    Object? errorMessage = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            savePath: null == savePath
                ? _value.savePath
                : savePath // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DownloadStatus,
            downloadedBytes: null == downloadedBytes
                ? _value.downloadedBytes
                : downloadedBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            totalBytes: null == totalBytes
                ? _value.totalBytes
                : totalBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double,
            totalSegments: null == totalSegments
                ? _value.totalSegments
                : totalSegments // ignore: cast_nullable_to_non_nullable
                      as int,
            downloadedSegments: null == downloadedSegments
                ? _value.downloadedSegments
                : downloadedSegments // ignore: cast_nullable_to_non_nullable
                      as int,
            sourceName: freezed == sourceName
                ? _value.sourceName
                : sourceName // ignore: cast_nullable_to_non_nullable
                      as String?,
            episodeName: freezed == episodeName
                ? _value.episodeName
                : episodeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DownloadTaskImplCopyWith<$Res>
    implements $DownloadTaskCopyWith<$Res> {
  factory _$$DownloadTaskImplCopyWith(
    _$DownloadTaskImpl value,
    $Res Function(_$DownloadTaskImpl) then,
  ) = __$$DownloadTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String url,
    String savePath,
    DownloadStatus status,
    int downloadedBytes,
    int totalBytes,
    double progress,
    int totalSegments,
    int downloadedSegments,
    String? sourceName,
    String? episodeName,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? completedAt,
  });
}

/// @nodoc
class __$$DownloadTaskImplCopyWithImpl<$Res>
    extends _$DownloadTaskCopyWithImpl<$Res, _$DownloadTaskImpl>
    implements _$$DownloadTaskImplCopyWith<$Res> {
  __$$DownloadTaskImplCopyWithImpl(
    _$DownloadTaskImpl _value,
    $Res Function(_$DownloadTaskImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DownloadTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? savePath = null,
    Object? status = null,
    Object? downloadedBytes = null,
    Object? totalBytes = null,
    Object? progress = null,
    Object? totalSegments = null,
    Object? downloadedSegments = null,
    Object? sourceName = freezed,
    Object? episodeName = freezed,
    Object? errorMessage = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$DownloadTaskImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        savePath: null == savePath
            ? _value.savePath
            : savePath // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DownloadStatus,
        downloadedBytes: null == downloadedBytes
            ? _value.downloadedBytes
            : downloadedBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        totalBytes: null == totalBytes
            ? _value.totalBytes
            : totalBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        totalSegments: null == totalSegments
            ? _value.totalSegments
            : totalSegments // ignore: cast_nullable_to_non_nullable
                  as int,
        downloadedSegments: null == downloadedSegments
            ? _value.downloadedSegments
            : downloadedSegments // ignore: cast_nullable_to_non_nullable
                  as int,
        sourceName: freezed == sourceName
            ? _value.sourceName
            : sourceName // ignore: cast_nullable_to_non_nullable
                  as String?,
        episodeName: freezed == episodeName
            ? _value.episodeName
            : episodeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DownloadTaskImpl implements _DownloadTask {
  const _$DownloadTaskImpl({
    required this.id,
    required this.title,
    required this.url,
    required this.savePath,
    this.status = DownloadStatus.pending,
    this.downloadedBytes = 0,
    this.totalBytes = 0,
    this.progress = 0.0,
    this.totalSegments = 0,
    this.downloadedSegments = 0,
    this.sourceName,
    this.episodeName,
    this.errorMessage,
    this.createdAt,
    this.completedAt,
  });

  factory _$DownloadTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$DownloadTaskImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String url;
  @override
  final String savePath;
  @override
  @JsonKey()
  final DownloadStatus status;
  @override
  @JsonKey()
  final int downloadedBytes;
  @override
  @JsonKey()
  final int totalBytes;
  @override
  @JsonKey()
  final double progress;
  @override
  @JsonKey()
  final int totalSegments;
  @override
  @JsonKey()
  final int downloadedSegments;
  @override
  final String? sourceName;
  @override
  final String? episodeName;
  @override
  final String? errorMessage;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'DownloadTask(id: $id, title: $title, url: $url, savePath: $savePath, status: $status, downloadedBytes: $downloadedBytes, totalBytes: $totalBytes, progress: $progress, totalSegments: $totalSegments, downloadedSegments: $downloadedSegments, sourceName: $sourceName, episodeName: $episodeName, errorMessage: $errorMessage, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadTaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.savePath, savePath) ||
                other.savePath == savePath) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.downloadedBytes, downloadedBytes) ||
                other.downloadedBytes == downloadedBytes) &&
            (identical(other.totalBytes, totalBytes) ||
                other.totalBytes == totalBytes) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.totalSegments, totalSegments) ||
                other.totalSegments == totalSegments) &&
            (identical(other.downloadedSegments, downloadedSegments) ||
                other.downloadedSegments == downloadedSegments) &&
            (identical(other.sourceName, sourceName) ||
                other.sourceName == sourceName) &&
            (identical(other.episodeName, episodeName) ||
                other.episodeName == episodeName) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    url,
    savePath,
    status,
    downloadedBytes,
    totalBytes,
    progress,
    totalSegments,
    downloadedSegments,
    sourceName,
    episodeName,
    errorMessage,
    createdAt,
    completedAt,
  );

  /// Create a copy of DownloadTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadTaskImplCopyWith<_$DownloadTaskImpl> get copyWith =>
      __$$DownloadTaskImplCopyWithImpl<_$DownloadTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DownloadTaskImplToJson(this);
  }
}

abstract class _DownloadTask implements DownloadTask {
  const factory _DownloadTask({
    required final String id,
    required final String title,
    required final String url,
    required final String savePath,
    final DownloadStatus status,
    final int downloadedBytes,
    final int totalBytes,
    final double progress,
    final int totalSegments,
    final int downloadedSegments,
    final String? sourceName,
    final String? episodeName,
    final String? errorMessage,
    final DateTime? createdAt,
    final DateTime? completedAt,
  }) = _$DownloadTaskImpl;

  factory _DownloadTask.fromJson(Map<String, dynamic> json) =
      _$DownloadTaskImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get url;
  @override
  String get savePath;
  @override
  DownloadStatus get status;
  @override
  int get downloadedBytes;
  @override
  int get totalBytes;
  @override
  double get progress;
  @override
  int get totalSegments;
  @override
  int get downloadedSegments;
  @override
  String? get sourceName;
  @override
  String? get episodeName;
  @override
  String? get errorMessage;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of DownloadTask
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DownloadTaskImplCopyWith<_$DownloadTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
