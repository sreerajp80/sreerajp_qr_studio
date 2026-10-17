import 'package:sqflite/sqflite.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';

/// Schema and migrations of the scan-history database
/// (engineering standard §13).
///
/// Migrations are append-only: never edit one that has shipped. A schema
/// change adds a new version to [_migrations], raises [version], and adds an
/// upgrade test.
abstract final class HistoryDatabaseSchema {
  static const int version = 2;
  static const String tableName = 'scan_records';

  /// Runs on every connection sqflite opens (§13.2, §13.4).
  static Future<void> onConfigure(Database db) async {
    try {
      await db.execute('PRAGMA foreign_keys = ON');
    } catch (e, st) {
      AppLogger.error('Enabling foreign keys failed', error: e, stackTrace: st);
    }
    try {
      // journal_mode returns a row, so it must go through rawQuery on Android.
      await db.rawQuery('PRAGMA journal_mode = WAL');
    } catch (e) {
      AppLogger.warning('Enabling WAL journal mode failed', error: e);
    }
  }

  static Future<void> onCreate(Database db, int version) =>
      _runMigrations(db, fromVersion: 0, toVersion: version);

  static Future<void> onUpgrade(Database db, int oldVersion, int newVersion) =>
      _runMigrations(db, fromVersion: oldVersion, toVersion: newVersion);

  static Future<void> _runMigrations(
    Database db, {
    required int fromVersion,
    required int toVersion,
  }) async {
    for (var v = fromVersion + 1; v <= toVersion; v++) {
      final migration = _migrations[v];
      if (migration == null) {
        throw StateError('No history database migration for version $v');
      }
      await db.transaction((txn) => migration(txn));
    }
  }

  static final Map<int, Future<void> Function(Transaction)> _migrations = {
    1: _v1CreateTable,
    2: _v2ConstraintsAndIndexes,
  };

  /// The original v1 table. Frozen — kept so the upgrade path can be tested.
  static const String v1CreateTableSql =
      '''
    CREATE TABLE $tableName (
      id TEXT PRIMARY KEY,
      timestamp INTEGER NOT NULL,
      rawContent TEXT NOT NULL,
      barcodeFormat TEXT NOT NULL,
      category TEXT NOT NULL,
      imageThumbnail TEXT,
      locationTag TEXT,
      safetyScore INTEGER NOT NULL,
      notes TEXT,
      isFavorite INTEGER NOT NULL DEFAULT 0,
      metadata TEXT
    )
  ''';

  static Future<void> _v1CreateTable(Transaction txn) =>
      txn.execute(v1CreateTableSql);

  /// v2: CHECK constraints (needs a table rebuild in SQLite) and indexes.
  static Future<void> _v2ConstraintsAndIndexes(Transaction txn) async {
    await txn.execute('''
      CREATE TABLE ${tableName}_v2 (
        id TEXT PRIMARY KEY,
        timestamp INTEGER NOT NULL,
        rawContent TEXT NOT NULL,
        barcodeFormat TEXT NOT NULL,
        category TEXT NOT NULL,
        imageThumbnail TEXT,
        locationTag TEXT,
        safetyScore INTEGER NOT NULL CHECK (safetyScore BETWEEN 0 AND 100),
        notes TEXT,
        isFavorite INTEGER NOT NULL DEFAULT 0 CHECK (isFavorite IN (0, 1)),
        metadata TEXT
      )
    ''');
    // Values are clamped so the copy can never fail on old data.
    await txn.execute('''
      INSERT INTO ${tableName}_v2 (
        id, timestamp, rawContent, barcodeFormat, category, imageThumbnail,
        locationTag, safetyScore, notes, isFavorite, metadata
      )
      SELECT
        id, timestamp, rawContent, barcodeFormat, category, imageThumbnail,
        locationTag, MIN(MAX(safetyScore, 0), 100),
        notes, CASE WHEN isFavorite = 0 THEN 0 ELSE 1 END, metadata
      FROM $tableName
    ''');
    await txn.execute('DROP TABLE $tableName');
    await txn.execute('ALTER TABLE ${tableName}_v2 RENAME TO $tableName');
    await txn.execute(
      'CREATE INDEX IF NOT EXISTS idx_scan_records_timestamp '
      'ON $tableName (timestamp)',
    );
    await txn.execute(
      'CREATE INDEX IF NOT EXISTS idx_scan_records_category '
      'ON $tableName (LOWER(category))',
    );
    await txn.execute(
      'CREATE INDEX IF NOT EXISTS idx_scan_records_favorite '
      'ON $tableName (isFavorite, timestamp)',
    );
  }
}
