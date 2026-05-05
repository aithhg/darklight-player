// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FavoriteItem _$FavoriteItemFromJson(Map<String, dynamic> json) {
  return _FavoriteItem.fromJson(json);
}

/// @nodoc
mixin _$FavoriteItem {
  String get videoId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get sourceName => throw _privateConstructorUsedError;
  String? get typeName => throw _privateConstructorUsedError;
  String? get remarks => throw _privateConstructorUsedError;
  DateTime? get addedAt => throw _privateConstructorUsedError;

  /// Serializes this FavoriteItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteItemCopyWith<FavoriteItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteItemCopyWith<$Res> {
  factory $FavoriteItemCopyWith(
    FavoriteItem value,
    $Res Function(FavoriteItem) then,
  ) = _$FavoriteItemCopyWithImpl<$Res, FavoriteItem>;
  @useResult
  $Res call({
    String videoId,
    String title,
    String? imageUrl,
    String? sourceName,
    String? typeName,
    String? remarks,
    DateTime? addedAt,
  });
}

/// @nodoc
class _$FavoriteItemCopyWithImpl<$Res, $Val extends FavoriteItem>
    implements $FavoriteItemCopyWith<$Res> {
  _$FavoriteItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? title = null,
    Object? imageUrl = freezed,
    Object? sourceName = freezed,
    Object? typeName = freezed,
    Object? remarks = freezed,
    Object? addedAt = freezed,
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
            typeName: freezed == typeName
                ? _value.typeName
                : typeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            remarks: freezed == remarks
                ? _value.remarks
                : remarks // ignore: cast_nullable_to_non_nullable
                      as String?,
            addedAt: freezed == addedAt
                ? _value.addedAt
                : addedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FavoriteItemImplCopyWith<$Res>
    implements $FavoriteItemCopyWith<$Res> {
  factory _$$FavoriteItemImplCopyWith(
    _$FavoriteItemImpl value,
    $Res Function(_$FavoriteItemImpl) then,
  ) = __$$FavoriteItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String videoId,
    String title,
    String? imageUrl,
    String? sourceName,
    String? typeName,
    String? remarks,
    DateTime? addedAt,
  });
}

/// @nodoc
class __$$FavoriteItemImplCopyWithImpl<$Res>
    extends _$FavoriteItemCopyWithImpl<$Res, _$FavoriteItemImpl>
    implements _$$FavoriteItemImplCopyWith<$Res> {
  __$$FavoriteItemImplCopyWithImpl(
    _$FavoriteItemImpl _value,
    $Res Function(_$FavoriteItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? title = null,
    Object? imageUrl = freezed,
    Object? sourceName = freezed,
    Object? typeName = freezed,
    Object? remarks = freezed,
    Object? addedAt = freezed,
  }) {
    return _then(
      _$FavoriteItemImpl(
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
        typeName: freezed == typeName
            ? _value.typeName
            : typeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        remarks: freezed == remarks
            ? _value.remarks
            : remarks // ignore: cast_nullable_to_non_nullable
                  as String?,
        addedAt: freezed == addedAt
            ? _value.addedAt
            : addedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteItemImpl implements _FavoriteItem {
  const _$FavoriteItemImpl({
    required this.videoId,
    required this.title,
    this.imageUrl,
    this.sourceName,
    this.typeName,
    this.remarks,
    this.addedAt,
  });

  factory _$FavoriteItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteItemImplFromJson(json);

  @override
  final String videoId;
  @override
  final String title;
  @override
  final String? imageUrl;
  @override
  final String? sourceName;
  @override
  final String? typeName;
  @override
  final String? remarks;
  @override
  final DateTime? addedAt;

  @override
  String toString() {
    return 'FavoriteItem(videoId: $videoId, title: $title, imageUrl: $imageUrl, sourceName: $sourceName, typeName: $typeName, remarks: $remarks, addedAt: $addedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteItemImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.sourceName, sourceName) ||
                other.sourceName == sourceName) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    videoId,
    title,
    imageUrl,
    sourceName,
    typeName,
    remarks,
    addedAt,
  );

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteItemImplCopyWith<_$FavoriteItemImpl> get copyWith =>
      __$$FavoriteItemImplCopyWithImpl<_$FavoriteItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteItemImplToJson(this);
  }
}

abstract class _FavoriteItem implements FavoriteItem {
  const factory _FavoriteItem({
    required final String videoId,
    required final String title,
    final String? imageUrl,
    final String? sourceName,
    final String? typeName,
    final String? remarks,
    final DateTime? addedAt,
  }) = _$FavoriteItemImpl;

  factory _FavoriteItem.fromJson(Map<String, dynamic> json) =
      _$FavoriteItemImpl.fromJson;

  @override
  String get videoId;
  @override
  String get title;
  @override
  String? get imageUrl;
  @override
  String? get sourceName;
  @override
  String? get typeName;
  @override
  String? get remarks;
  @override
  DateTime? get addedAt;

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteItemImplCopyWith<_$FavoriteItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
