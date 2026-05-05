// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'source_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SourceConfig _$SourceConfigFromJson(Map<String, dynamic> json) {
  return _SourceConfig.fromJson(json);
}

/// @nodoc
mixin _$SourceConfig {
  String get name => throw _privateConstructorUsedError;
  String get apiBase => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  DateTime? get lastHealthCheck => throw _privateConstructorUsedError;
  bool get isHealthy => throw _privateConstructorUsedError;

  /// Serializes this SourceConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceConfigCopyWith<SourceConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceConfigCopyWith<$Res> {
  factory $SourceConfigCopyWith(
    SourceConfig value,
    $Res Function(SourceConfig) then,
  ) = _$SourceConfigCopyWithImpl<$Res, SourceConfig>;
  @useResult
  $Res call({
    String name,
    String apiBase,
    bool enabled,
    int priority,
    List<String> categories,
    DateTime? lastHealthCheck,
    bool isHealthy,
  });
}

/// @nodoc
class _$SourceConfigCopyWithImpl<$Res, $Val extends SourceConfig>
    implements $SourceConfigCopyWith<$Res> {
  _$SourceConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? apiBase = null,
    Object? enabled = null,
    Object? priority = null,
    Object? categories = null,
    Object? lastHealthCheck = freezed,
    Object? isHealthy = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            apiBase: null == apiBase
                ? _value.apiBase
                : apiBase // ignore: cast_nullable_to_non_nullable
                      as String,
            enabled: null == enabled
                ? _value.enabled
                : enabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as int,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            lastHealthCheck: freezed == lastHealthCheck
                ? _value.lastHealthCheck
                : lastHealthCheck // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isHealthy: null == isHealthy
                ? _value.isHealthy
                : isHealthy // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SourceConfigImplCopyWith<$Res>
    implements $SourceConfigCopyWith<$Res> {
  factory _$$SourceConfigImplCopyWith(
    _$SourceConfigImpl value,
    $Res Function(_$SourceConfigImpl) then,
  ) = __$$SourceConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String apiBase,
    bool enabled,
    int priority,
    List<String> categories,
    DateTime? lastHealthCheck,
    bool isHealthy,
  });
}

/// @nodoc
class __$$SourceConfigImplCopyWithImpl<$Res>
    extends _$SourceConfigCopyWithImpl<$Res, _$SourceConfigImpl>
    implements _$$SourceConfigImplCopyWith<$Res> {
  __$$SourceConfigImplCopyWithImpl(
    _$SourceConfigImpl _value,
    $Res Function(_$SourceConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? apiBase = null,
    Object? enabled = null,
    Object? priority = null,
    Object? categories = null,
    Object? lastHealthCheck = freezed,
    Object? isHealthy = null,
  }) {
    return _then(
      _$SourceConfigImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        apiBase: null == apiBase
            ? _value.apiBase
            : apiBase // ignore: cast_nullable_to_non_nullable
                  as String,
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as int,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        lastHealthCheck: freezed == lastHealthCheck
            ? _value.lastHealthCheck
            : lastHealthCheck // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isHealthy: null == isHealthy
            ? _value.isHealthy
            : isHealthy // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceConfigImpl implements _SourceConfig {
  const _$SourceConfigImpl({
    required this.name,
    required this.apiBase,
    this.enabled = true,
    this.priority = 0,
    final List<String> categories = const [],
    this.lastHealthCheck,
    this.isHealthy = true,
  }) : _categories = categories;

  factory _$SourceConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceConfigImplFromJson(json);

  @override
  final String name;
  @override
  final String apiBase;
  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final int priority;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final DateTime? lastHealthCheck;
  @override
  @JsonKey()
  final bool isHealthy;

  @override
  String toString() {
    return 'SourceConfig(name: $name, apiBase: $apiBase, enabled: $enabled, priority: $priority, categories: $categories, lastHealthCheck: $lastHealthCheck, isHealthy: $isHealthy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceConfigImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.apiBase, apiBase) || other.apiBase == apiBase) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.lastHealthCheck, lastHealthCheck) ||
                other.lastHealthCheck == lastHealthCheck) &&
            (identical(other.isHealthy, isHealthy) ||
                other.isHealthy == isHealthy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    apiBase,
    enabled,
    priority,
    const DeepCollectionEquality().hash(_categories),
    lastHealthCheck,
    isHealthy,
  );

  /// Create a copy of SourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceConfigImplCopyWith<_$SourceConfigImpl> get copyWith =>
      __$$SourceConfigImplCopyWithImpl<_$SourceConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceConfigImplToJson(this);
  }
}

abstract class _SourceConfig implements SourceConfig {
  const factory _SourceConfig({
    required final String name,
    required final String apiBase,
    final bool enabled,
    final int priority,
    final List<String> categories,
    final DateTime? lastHealthCheck,
    final bool isHealthy,
  }) = _$SourceConfigImpl;

  factory _SourceConfig.fromJson(Map<String, dynamic> json) =
      _$SourceConfigImpl.fromJson;

  @override
  String get name;
  @override
  String get apiBase;
  @override
  bool get enabled;
  @override
  int get priority;
  @override
  List<String> get categories;
  @override
  DateTime? get lastHealthCheck;
  @override
  bool get isHealthy;

  /// Create a copy of SourceConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceConfigImplCopyWith<_$SourceConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
