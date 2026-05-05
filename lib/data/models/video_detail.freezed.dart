// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VideoDetail _$VideoDetailFromJson(Map<String, dynamic> json) {
  return _VideoDetail.fromJson(json);
}

/// @nodoc
mixin _$VideoDetail {
  String get videoId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get year => throw _privateConstructorUsedError;
  String? get typeName => throw _privateConstructorUsedError;
  String? get area => throw _privateConstructorUsedError;
  String? get director => throw _privateConstructorUsedError;
  String? get actors => throw _privateConstructorUsedError;
  String? get remarks => throw _privateConstructorUsedError;
  String? get updateTime => throw _privateConstructorUsedError;
  List<Episode> get episodes => throw _privateConstructorUsedError;
  List<PlaybackSource> get playbackSources =>
      throw _privateConstructorUsedError;
  String? get sourceName => throw _privateConstructorUsedError;

  /// Serializes this VideoDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoDetailCopyWith<VideoDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoDetailCopyWith<$Res> {
  factory $VideoDetailCopyWith(
    VideoDetail value,
    $Res Function(VideoDetail) then,
  ) = _$VideoDetailCopyWithImpl<$Res, VideoDetail>;
  @useResult
  $Res call({
    String videoId,
    String title,
    String? imageUrl,
    String? description,
    String? year,
    String? typeName,
    String? area,
    String? director,
    String? actors,
    String? remarks,
    String? updateTime,
    List<Episode> episodes,
    List<PlaybackSource> playbackSources,
    String? sourceName,
  });
}

/// @nodoc
class _$VideoDetailCopyWithImpl<$Res, $Val extends VideoDetail>
    implements $VideoDetailCopyWith<$Res> {
  _$VideoDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? title = null,
    Object? imageUrl = freezed,
    Object? description = freezed,
    Object? year = freezed,
    Object? typeName = freezed,
    Object? area = freezed,
    Object? director = freezed,
    Object? actors = freezed,
    Object? remarks = freezed,
    Object? updateTime = freezed,
    Object? episodes = null,
    Object? playbackSources = null,
    Object? sourceName = freezed,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as String?,
            typeName: freezed == typeName
                ? _value.typeName
                : typeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            area: freezed == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as String?,
            director: freezed == director
                ? _value.director
                : director // ignore: cast_nullable_to_non_nullable
                      as String?,
            actors: freezed == actors
                ? _value.actors
                : actors // ignore: cast_nullable_to_non_nullable
                      as String?,
            remarks: freezed == remarks
                ? _value.remarks
                : remarks // ignore: cast_nullable_to_non_nullable
                      as String?,
            updateTime: freezed == updateTime
                ? _value.updateTime
                : updateTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            episodes: null == episodes
                ? _value.episodes
                : episodes // ignore: cast_nullable_to_non_nullable
                      as List<Episode>,
            playbackSources: null == playbackSources
                ? _value.playbackSources
                : playbackSources // ignore: cast_nullable_to_non_nullable
                      as List<PlaybackSource>,
            sourceName: freezed == sourceName
                ? _value.sourceName
                : sourceName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VideoDetailImplCopyWith<$Res>
    implements $VideoDetailCopyWith<$Res> {
  factory _$$VideoDetailImplCopyWith(
    _$VideoDetailImpl value,
    $Res Function(_$VideoDetailImpl) then,
  ) = __$$VideoDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String videoId,
    String title,
    String? imageUrl,
    String? description,
    String? year,
    String? typeName,
    String? area,
    String? director,
    String? actors,
    String? remarks,
    String? updateTime,
    List<Episode> episodes,
    List<PlaybackSource> playbackSources,
    String? sourceName,
  });
}

/// @nodoc
class __$$VideoDetailImplCopyWithImpl<$Res>
    extends _$VideoDetailCopyWithImpl<$Res, _$VideoDetailImpl>
    implements _$$VideoDetailImplCopyWith<$Res> {
  __$$VideoDetailImplCopyWithImpl(
    _$VideoDetailImpl _value,
    $Res Function(_$VideoDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VideoDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? title = null,
    Object? imageUrl = freezed,
    Object? description = freezed,
    Object? year = freezed,
    Object? typeName = freezed,
    Object? area = freezed,
    Object? director = freezed,
    Object? actors = freezed,
    Object? remarks = freezed,
    Object? updateTime = freezed,
    Object? episodes = null,
    Object? playbackSources = null,
    Object? sourceName = freezed,
  }) {
    return _then(
      _$VideoDetailImpl(
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
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as String?,
        typeName: freezed == typeName
            ? _value.typeName
            : typeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        area: freezed == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as String?,
        director: freezed == director
            ? _value.director
            : director // ignore: cast_nullable_to_non_nullable
                  as String?,
        actors: freezed == actors
            ? _value.actors
            : actors // ignore: cast_nullable_to_non_nullable
                  as String?,
        remarks: freezed == remarks
            ? _value.remarks
            : remarks // ignore: cast_nullable_to_non_nullable
                  as String?,
        updateTime: freezed == updateTime
            ? _value.updateTime
            : updateTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        episodes: null == episodes
            ? _value._episodes
            : episodes // ignore: cast_nullable_to_non_nullable
                  as List<Episode>,
        playbackSources: null == playbackSources
            ? _value._playbackSources
            : playbackSources // ignore: cast_nullable_to_non_nullable
                  as List<PlaybackSource>,
        sourceName: freezed == sourceName
            ? _value.sourceName
            : sourceName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoDetailImpl implements _VideoDetail {
  const _$VideoDetailImpl({
    required this.videoId,
    required this.title,
    this.imageUrl,
    this.description,
    this.year,
    this.typeName,
    this.area,
    this.director,
    this.actors,
    this.remarks,
    this.updateTime,
    final List<Episode> episodes = const [],
    final List<PlaybackSource> playbackSources = const [],
    this.sourceName,
  }) : _episodes = episodes,
       _playbackSources = playbackSources;

  factory _$VideoDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoDetailImplFromJson(json);

  @override
  final String videoId;
  @override
  final String title;
  @override
  final String? imageUrl;
  @override
  final String? description;
  @override
  final String? year;
  @override
  final String? typeName;
  @override
  final String? area;
  @override
  final String? director;
  @override
  final String? actors;
  @override
  final String? remarks;
  @override
  final String? updateTime;
  final List<Episode> _episodes;
  @override
  @JsonKey()
  List<Episode> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  final List<PlaybackSource> _playbackSources;
  @override
  @JsonKey()
  List<PlaybackSource> get playbackSources {
    if (_playbackSources is EqualUnmodifiableListView) return _playbackSources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playbackSources);
  }

  @override
  final String? sourceName;

  @override
  String toString() {
    return 'VideoDetail(videoId: $videoId, title: $title, imageUrl: $imageUrl, description: $description, year: $year, typeName: $typeName, area: $area, director: $director, actors: $actors, remarks: $remarks, updateTime: $updateTime, episodes: $episodes, playbackSources: $playbackSources, sourceName: $sourceName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoDetailImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.director, director) ||
                other.director == director) &&
            (identical(other.actors, actors) || other.actors == actors) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes) &&
            const DeepCollectionEquality().equals(
              other._playbackSources,
              _playbackSources,
            ) &&
            (identical(other.sourceName, sourceName) ||
                other.sourceName == sourceName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    videoId,
    title,
    imageUrl,
    description,
    year,
    typeName,
    area,
    director,
    actors,
    remarks,
    updateTime,
    const DeepCollectionEquality().hash(_episodes),
    const DeepCollectionEquality().hash(_playbackSources),
    sourceName,
  );

  /// Create a copy of VideoDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoDetailImplCopyWith<_$VideoDetailImpl> get copyWith =>
      __$$VideoDetailImplCopyWithImpl<_$VideoDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoDetailImplToJson(this);
  }
}

abstract class _VideoDetail implements VideoDetail {
  const factory _VideoDetail({
    required final String videoId,
    required final String title,
    final String? imageUrl,
    final String? description,
    final String? year,
    final String? typeName,
    final String? area,
    final String? director,
    final String? actors,
    final String? remarks,
    final String? updateTime,
    final List<Episode> episodes,
    final List<PlaybackSource> playbackSources,
    final String? sourceName,
  }) = _$VideoDetailImpl;

  factory _VideoDetail.fromJson(Map<String, dynamic> json) =
      _$VideoDetailImpl.fromJson;

  @override
  String get videoId;
  @override
  String get title;
  @override
  String? get imageUrl;
  @override
  String? get description;
  @override
  String? get year;
  @override
  String? get typeName;
  @override
  String? get area;
  @override
  String? get director;
  @override
  String? get actors;
  @override
  String? get remarks;
  @override
  String? get updateTime;
  @override
  List<Episode> get episodes;
  @override
  List<PlaybackSource> get playbackSources;
  @override
  String? get sourceName;

  /// Create a copy of VideoDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoDetailImplCopyWith<_$VideoDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
