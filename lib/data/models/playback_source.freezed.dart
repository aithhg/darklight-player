// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlaybackSource _$PlaybackSourceFromJson(Map<String, dynamic> json) {
  return _PlaybackSource.fromJson(json);
}

/// @nodoc
mixin _$PlaybackSource {
  String get name => throw _privateConstructorUsedError;
  List<String> get urls => throw _privateConstructorUsedError;
  String get format => throw _privateConstructorUsedError;
  String get quality => throw _privateConstructorUsedError;

  /// Serializes this PlaybackSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaybackSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybackSourceCopyWith<PlaybackSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybackSourceCopyWith<$Res> {
  factory $PlaybackSourceCopyWith(
    PlaybackSource value,
    $Res Function(PlaybackSource) then,
  ) = _$PlaybackSourceCopyWithImpl<$Res, PlaybackSource>;
  @useResult
  $Res call({String name, List<String> urls, String format, String quality});
}

/// @nodoc
class _$PlaybackSourceCopyWithImpl<$Res, $Val extends PlaybackSource>
    implements $PlaybackSourceCopyWith<$Res> {
  _$PlaybackSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybackSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? urls = null,
    Object? format = null,
    Object? quality = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            urls: null == urls
                ? _value.urls
                : urls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            format: null == format
                ? _value.format
                : format // ignore: cast_nullable_to_non_nullable
                      as String,
            quality: null == quality
                ? _value.quality
                : quality // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaybackSourceImplCopyWith<$Res>
    implements $PlaybackSourceCopyWith<$Res> {
  factory _$$PlaybackSourceImplCopyWith(
    _$PlaybackSourceImpl value,
    $Res Function(_$PlaybackSourceImpl) then,
  ) = __$$PlaybackSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<String> urls, String format, String quality});
}

/// @nodoc
class __$$PlaybackSourceImplCopyWithImpl<$Res>
    extends _$PlaybackSourceCopyWithImpl<$Res, _$PlaybackSourceImpl>
    implements _$$PlaybackSourceImplCopyWith<$Res> {
  __$$PlaybackSourceImplCopyWithImpl(
    _$PlaybackSourceImpl _value,
    $Res Function(_$PlaybackSourceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaybackSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? urls = null,
    Object? format = null,
    Object? quality = null,
  }) {
    return _then(
      _$PlaybackSourceImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        urls: null == urls
            ? _value._urls
            : urls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        format: null == format
            ? _value.format
            : format // ignore: cast_nullable_to_non_nullable
                  as String,
        quality: null == quality
            ? _value.quality
            : quality // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaybackSourceImpl implements _PlaybackSource {
  const _$PlaybackSourceImpl({
    required this.name,
    final List<String> urls = const [],
    this.format = 'auto',
    this.quality = 'auto',
  }) : _urls = urls;

  factory _$PlaybackSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaybackSourceImplFromJson(json);

  @override
  final String name;
  final List<String> _urls;
  @override
  @JsonKey()
  List<String> get urls {
    if (_urls is EqualUnmodifiableListView) return _urls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_urls);
  }

  @override
  @JsonKey()
  final String format;
  @override
  @JsonKey()
  final String quality;

  @override
  String toString() {
    return 'PlaybackSource(name: $name, urls: $urls, format: $format, quality: $quality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybackSourceImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._urls, _urls) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.quality, quality) || other.quality == quality));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    const DeepCollectionEquality().hash(_urls),
    format,
    quality,
  );

  /// Create a copy of PlaybackSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybackSourceImplCopyWith<_$PlaybackSourceImpl> get copyWith =>
      __$$PlaybackSourceImplCopyWithImpl<_$PlaybackSourceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaybackSourceImplToJson(this);
  }
}

abstract class _PlaybackSource implements PlaybackSource {
  const factory _PlaybackSource({
    required final String name,
    final List<String> urls,
    final String format,
    final String quality,
  }) = _$PlaybackSourceImpl;

  factory _PlaybackSource.fromJson(Map<String, dynamic> json) =
      _$PlaybackSourceImpl.fromJson;

  @override
  String get name;
  @override
  List<String> get urls;
  @override
  String get format;
  @override
  String get quality;

  /// Create a copy of PlaybackSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybackSourceImplCopyWith<_$PlaybackSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
