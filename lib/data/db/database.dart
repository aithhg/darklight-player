import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AppDatabase {
  static AppDatabase? _instance;
  static Database? _database;

  AppDatabase._();

  static AppDatabase get instance {
    _instance ??= AppDatabase._();
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    sqfliteFfiInit();
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(appDir.path, 'darklight', 'darklight.db');

    // Ensure directory exists
    await Directory(p.dirname(dbPath)).create(recursive: true);

    final db = await databaseFactoryFfi.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 2,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      ),
    );

    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        video_id TEXT NOT NULL,
        title TEXT NOT NULL,
        image_url TEXT,
        source_name TEXT,
        type_name TEXT,
        remarks TEXT,
        added_at TEXT NOT NULL,
        PRIMARY KEY (video_id, source_name)
      )
    ''');

    await db.execute('''
      CREATE TABLE history (
        video_id TEXT NOT NULL,
        title TEXT NOT NULL,
        image_url TEXT,
        source_name TEXT,
        episode_index INTEGER DEFAULT 0,
        episode_name TEXT DEFAULT '',
        position REAL DEFAULT 0,
        duration REAL DEFAULT 0,
        watched_at TEXT NOT NULL,
        PRIMARY KEY (video_id, source_name)
      )
    ''');

    await db.execute('''
      CREATE TABLE downloads (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        url TEXT NOT NULL,
        save_path TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'pending',
        downloaded_bytes INTEGER DEFAULT 0,
        total_bytes INTEGER DEFAULT 0,
        progress REAL DEFAULT 0,
        total_segments INTEGER DEFAULT 0,
        downloaded_segments INTEGER DEFAULT 0,
        source_name TEXT,
        episode_name TEXT,
        error_message TEXT,
        created_at TEXT NOT NULL,
        completed_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sources (
        name TEXT PRIMARY KEY,
        api_base TEXT NOT NULL,
        enabled INTEGER DEFAULT 1,
        priority INTEGER DEFAULT 0,
        categories TEXT DEFAULT '[]',
        last_health_check TEXT,
        is_healthy INTEGER DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');

    // Create indexes
    await db.execute(
        'CREATE INDEX idx_history_watched_at ON history(watched_at DESC)');
    await db.execute(
        'CREATE INDEX idx_favorites_added_at ON favorites(added_at DESC)');
    await db.execute(
        'CREATE INDEX idx_downloads_status ON downloads(status)');
    await db.execute(
        'CREATE INDEX idx_sources_enabled ON sources(enabled, priority)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add segment tracking columns to downloads table
      try {
        await db.execute('ALTER TABLE downloads ADD COLUMN total_segments INTEGER DEFAULT 0');
      } catch (_) {}
      try {
        await db.execute('ALTER TABLE downloads ADD COLUMN downloaded_segments INTEGER DEFAULT 0');
      } catch (_) {}
    }
  }

  // --- Favorites ---

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return db.query('favorites', orderBy: 'added_at DESC');
  }

  Future<void> addFavorite(Map<String, dynamic> item) async {
    final db = await database;
    await db.insert('favorites', item,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFavorite(String videoId, String sourceName) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'video_id = ? AND source_name = ?',
      whereArgs: [videoId, sourceName],
    );
  }

  Future<bool> isFavorite(String videoId, String sourceName) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'video_id = ? AND source_name = ?',
      whereArgs: [videoId, sourceName],
    );
    return result.isNotEmpty;
  }

  Future<void> removeFavoriteByTitle(String title) async {
    final db = await database;
    await db.delete('favorites', where: 'title = ?', whereArgs: [title]);
  }

  // --- History ---

  Future<List<Map<String, dynamic>>> getHistory({int limit = 100}) async {
    final db = await database;
    return db.query('history', orderBy: 'watched_at DESC', limit: limit);
  }

  Future<void> addHistory(Map<String, dynamic> item) async {
    final db = await database;
    await db.insert('history', item,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> clearHistory() async {
    final db = await database;
    await db.delete('history');
  }

  // --- Downloads ---

  Future<List<Map<String, dynamic>>> getDownloads() async {
    final db = await database;
    return db.query('downloads', orderBy: 'created_at DESC');
  }

  Future<void> addDownload(Map<String, dynamic> task) async {
    final db = await database;
    await db.insert('downloads', task,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateDownload(String id, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update('downloads', updates, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> removeDownload(String id) async {
    final db = await database;
    await db.delete('downloads', where: 'id = ?', whereArgs: [id]);
  }

  // --- Sources ---

  Future<List<Map<String, dynamic>>> getSources() async {
    final db = await database;
    return db.query('sources', orderBy: 'priority ASC');
  }

  Future<void> upsertSource(Map<String, dynamic> source) async {
    final db = await database;
    await db.insert('sources', source,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeSource(String name) async {
    final db = await database;
    await db.delete('sources', where: 'name = ?', whereArgs: [name]);
  }

  // --- Settings ---

  Future<String?> getSetting(String key) async {
    final db = await database;
    final result = await db.query(
      'settings',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: [key],
    );
    if (result.isNotEmpty) {
      return result.first['value'] as String?;
    }
    return null;
  }

  Future<void> setSetting(String key, String value) async {
    final db = await database;
    await db.insert(
      'settings',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
