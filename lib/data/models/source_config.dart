import 'package:freezed_annotation/freezed_annotation.dart';

part 'source_config.freezed.dart';
part 'source_config.g.dart';

@freezed
class SourceConfig with _$SourceConfig {
  const factory SourceConfig({
    required String name,
    required String apiBase,
    @Default(true) bool enabled,
    @Default(0) int priority,
    @Default([]) List<String> categories,
    DateTime? lastHealthCheck,
    @Default(true) bool isHealthy,
  }) = _SourceConfig;

  factory SourceConfig.fromJson(Map<String, dynamic> json) =>
      _$SourceConfigFromJson(json);
}
