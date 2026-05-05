import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:media_kit/media_kit.dart';
import '../data/db/database.dart';
import '../data/services/source_service.dart';
import '../data/services/favorite_service.dart';
import '../data/services/history_service.dart';
import '../data/services/download_service.dart';
import '../data/sources/source_registry.dart';
import '../data/sources/builtin_sources.dart';
import '../shared/utils/url_resolver.dart';

/// Holds all application-level services.
/// Initialized once in main.dart and provided via Provider.
class ServiceProvider extends ChangeNotifier {
  late final AppDatabase db;
  late final Dio dio;
  late final SourceService sourceService;
  late final FavoriteService favoriteService;
  late final HistoryService historyService;
  late final DownloadService downloadService;
  late final SourceRegistry sourceRegistry;
  late final UrlResolver urlResolver;

  bool _initialized = false;
  bool get initialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;

    // Initialize media_kit
    MediaKit.ensureInitialized();

    // Database
    db = AppDatabase.instance;

    // HTTP client with SSL bypass for Chinese video APIs
    dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.plain,
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      },
    ));
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (_, __, ___) => true;
      return client;
    };
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        if (response.data is String) {
          try {
            response.data = jsonDecode(response.data as String);
          } catch (_) {}
        }
        handler.next(response);
      },
    ));

    // Services
    sourceService = SourceService(db);
    favoriteService = FavoriteService(db);
    historyService = HistoryService(db);
    urlResolver = UrlResolver(dio);
    downloadService = DownloadService(db, urlResolver);

    // Register builtin sources
    for (final source in createBuiltinSources()) {
      sourceService.registerSource(source);
    }
    await sourceService.initialize();

    // Source registry
    sourceRegistry = SourceRegistry(sourceService);

    _initialized = true;
    notifyListeners();
  }

  @override
  void dispose() {
    downloadService.dispose();
    dio.close();
    db.close();
    super.dispose();
  }
}
