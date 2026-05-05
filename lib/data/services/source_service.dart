import 'dart:convert';
import '../db/database.dart';
import '../models/source_config.dart';
import '../sources/video_source.dart';

class SourceService {
  final AppDatabase _db;
  final List<VideoSource> _builtinSources = [];

  SourceService(this._db);

  /// Register a builtin source implementation
  void registerSource(VideoSource source) {
    _builtinSources.add(source);
  }

  /// Get all registered source implementations
  List<VideoSource> get sources => List.unmodifiable(_builtinSources);

  /// Get enabled sources sorted by priority
  List<VideoSource> get enabledSources {
    return _builtinSources.where((s) => s.enabled).toList();
  }

  /// Find a source by name
  VideoSource? findSource(String name) {
    try {
      return _builtinSources.firstWhere((s) => s.name == name);
    } catch (_) {
      return null;
    }
  }

  /// Load source configs from database and sync with builtin sources
  Future<void> initialize() async {
    final rows = await _db.getSources();
    final dbConfigs = <String, SourceConfig>{};

    for (final row in rows) {
      final config = SourceConfig(
        name: row['name'] as String,
        apiBase: row['api_base'] as String,
        enabled: (row['enabled'] as int?) == 1,
        priority: (row['priority'] as int?) ?? 0,
        categories: row['categories'] != null
            ? List<String>.from(jsonDecode(row['categories'] as String))
            : [],
        lastHealthCheck: row['last_health_check'] != null
            ? DateTime.tryParse(row['last_health_check'] as String)
            : null,
        isHealthy: (row['is_healthy'] as int?) != 0,
      );
      dbConfigs[config.name] = config;
    }

    // Sync builtin sources with database
    for (final source in _builtinSources) {
      if (!dbConfigs.containsKey(source.name)) {
        await _db.upsertSource({
          'name': source.name,
          'api_base': source.apiBase,
          'enabled': 1,
          'priority': 0,
          'categories': '[]',
          'is_healthy': 1,
        });
      }
    }
  }

  /// Run health check on all enabled sources
  Future<Map<String, bool>> healthCheckAll() async {
    final results = <String, bool>{};
    for (final source in enabledSources) {
      try {
        final healthy = await source.healthCheck();
        results[source.name] = healthy;
        await _db.upsertSource({
          'name': source.name,
          'api_base': source.apiBase,
          'enabled': 1,
          'last_health_check': DateTime.now().toIso8601String(),
          'is_healthy': healthy ? 1 : 0,
        });
      } catch (_) {
        results[source.name] = false;
      }
    }
    return results;
  }

  /// Toggle a source enabled/disabled
  Future<void> toggleSource(String name, bool enabled) async {
    final source = findSource(name);
    if (source == null) return;

    await _db.upsertSource({
      'name': name,
      'api_base': source.apiBase,
      'enabled': enabled ? 1 : 0,
    });
  }
}
