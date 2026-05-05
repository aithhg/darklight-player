// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HistoryItem _$HistoryItemFromJson(Map<String, dynamic> json) {
  return _HistoryItem.fromJson(json);
}

/// @nodoc
mixin _$HistoryItem {
  String get videoId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get sourceName => throw _privateConstructorUsedError;
  int get episodeIndex => throw _privateConstructorUsedError;
  String get episodeName => throw _privateConstructorUsedError;
  double get position => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  DateTime? get watchedAt => throw _privateConstructorUsedError;

  /// Serializes this HistoryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryItemCopyWith<HistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryItemCopyWith<$Res> {
  factory $HistoryItemCopyWith(
    HistoryItem value,
    $Res Function(HistoryItem) then,
  ) = _$HistoryItemCopyWithImpl<$Res, HistoryItem>;
  @useResult
  $Res call({
    String videoId,
    String title,
    String? imageUrl,
    String? sourceName,
    int episodeIndex,
    String episodeName,
    double position,
    double duration,
    DateTime? watchedAt,
  });
}

/// @nodoc
class _$HistoryItemCopyWithImpl<$Res, $Val extends HistoryItem>
    implements $HistoryItemCopyWith<$Res> {
  _$HistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? title = null,
    Object? imageUrl = freezed,
    Object? sourceName = freezed,
    Object? episodeIndex = null,
    Object? episodeName = null,
    Object? position = null,
    Object? duration = null,
    Object? watchedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            videoId: null == videoId
                ? _value.videoId
                : videoId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceName: freezed == sourceName
                ? _value.sourceName
                : sourceName // ignore: cast_nullable_to_non_nullable
                      as String?,
            episodeIndex: null == episodeIndex
                ? _value.episodeIndex
                : episodeIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            episodeName: null == episodeName
                ? _value.episodeName
                : episodeName // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as double,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as double,
            watchedAt: freezed == watchedAt
                ? _value.watchedAt
                : watchedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HistoryItemImplCopyWith<$Res>
    implements $HistoryItemCopyWith<$Res> {
  factory _$$HistoryItemImplCopyWith(
    _$HistoryItemImpl value,
    $Res Function(_$HistoryItemImpl) then,
  ) = __$$HistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String videoId,
    String title,
    String? imageUrl,
    String? sourceName,
    int episodeIndex,
    String episodeName,
    double position,
    double duration,
    DateTime? watchedAt,
  });
}

/// @nodoc
class __$$HistoryItemImplCopyWithImpl<$Res>
    extends _$HistoryItemCopyWithImpl<$Res, _$HistoryItemImpl>
    implements _$$HistoryItemImplCopyWith<$Res> {
  __$$HistoryItemImplCopyWithImpl(
    _$HistoryItemImpl _value,
    $Res Function(_$HistoryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? title = null,
    Object? imageUrl = freezed,
    Object? sourceName = freezed,
    Object? episodeIndex = null,
    Object? episodeName = null,
    Object? position = null,
    Object? duration = null,
    Object? watchedAt = freezed,
  }) {
    return _then(
      _$HistoryItemImpl(
        videoId: null == videoId
            ? _value.videoId
            : videoId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceName: freezed == sourceName
            ? _value.sourceName
            : sourceName // ignore: cast_nullable_to_non_nullable
                  as String?,
        episodeIndex: null == episodeIndex
            ? _value.episodeIndex
            : episodeIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        episodeName: null == episodeName
            ? _value.episodeName
            : episodeName // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as double,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as double,
        watchedAt: freezed == watchedAt
            ? _value.watchedAt
            : watchedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryItemImpl implements _HistoryItem {
  const _$HistoryItemImpl({
    required this.videoId,
    required this.title,
    this.imageUrl,
    this.sourceName,
    this.episodeIndex = 0,
    this.episodeName = '',
    this.position = 0.0,
    this.duration = 0.0,
    this.watchedAt,
  });

  factory _$HistoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryItemImplFromJson(json);

  @override
  final String videoId;
  @override
  final String title;
  @override
  final String? imageUrl;
  @override
  final String? sourceName;
  @override
  @JsonKey()
  final int episodeIndex;
  @override
  @JsonKey()
  final String episodeName;
  @override
  @JsonKey()
  final double position;
  @override
  @JsonKey()
  final double duration;
  @override
  final DateTime? watchedAt;

  @override
  String toString() {
    return 'HistoryItem(videoId: $videoId, title: $title, imageUrl: $imageUrl, sourceName: $sourceName, episodeIndex: $episodeIndex, episodeName: $episodeName, position: $position, duration: $duration, watchedAt: $watchedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryItemImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.sourceName, sourceName) ||
                other.sourceName == sourceName) &&
            (identical(other.episodeIndex, episodeIndex) ||
                other.episodeIndex == episodeIndex) &&
            (identical(other.episodeName, episodeName) ||
                other.episodeName == episodeName) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.watchedAt, watchedAt) ||
                other.watchedAt == watchedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    videoId,
    title,
    imageUrl,
    sourceName,
    episodeIndex,
    episodeName,
    position,
    duration,
    watchedAt,
  );

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryItemImplCopyWith<_$HistoryItemImpl> get copyWith =>
      __$$HistoryItemImplCopyWithImpl<_$HistoryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryItemImplToJson(this);
  }
}

abstract class _HistoryItem implements HistoryItem {
  const factory _HistoryItem({
    required final String videoId,
    required final String title,
    final String? imageUrl,
    final String? sourceName,
    final int episodeIndex,
    final String episodeName,
    final double position,
    final double duration,
    final DateTime? watchedAt,
  }) = _$HistoryItemImpl;

  factory _HistoryItem.fromJson(Map<String, dynamic> json) =
      _$HistoryItemImpl.fromJson;

  @override
  String get videoId;
  @override
  String get title;
  @override
  String? get imageUrl;
  @override
  String? get sourceName;
  @override
  int get episodeIndex;
  @override
  String get episodeName;
  @override
  double get position;
  @override
  double get duration;
  @override
  DateTime? get watchedAt;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryItemImplCopyWith<_$HistoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
