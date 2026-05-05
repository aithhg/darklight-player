// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SourceConfigImpl _$$SourceConfigImplFromJson(Map<String, dynamic> json) =>
    _$SourceConfigImpl(
      name: json['name'] as String,
      apiBase: json['apiBase'] as String,
      enabled: json['enabled'] as bool? ?? true,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastHealthCheck: json['lastHealthCheck'] == null
          ? null
          : DateTime.parse(json['lastHealthCheck'] as String),
      isHealthy: json['isHealthy'] as bool? ?? true,
    );

Map<String, dynamic> _$$SourceConfigImplToJson(_$SourceConfigImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'apiBase': instance.apiBase,
      'enabled': instance.enabled,
      'priority': instance.priority,
      'categories': instance.categories,
      'lastHealthCheck': instance.lastHealthCheck?.toIso8601String(),
      'isHealthy': instance.isHealthy,
    };
