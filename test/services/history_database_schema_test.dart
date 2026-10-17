import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sreerajp_qr_studio/services/history_database_schema.dart';

Future<Database> _openCurrent(String path) => openDatabase(
  path,
  version: HistoryDatabaseSchema.version,
  onConfigure: HistoryDatabaseSchema.onConfigure,
  onCreate: HistoryDatabaseSchema.onCreate,
  onUpgrade: HistoryDatabaseSchema.onUpgrade,
);

Map<String, Object?> _row(
  String id, {
  int safetyScore = 80,
  int isFavorite = 0,
  int timestamp = 1000,
}) => {
  'id': id,
  'timestamp': timestamp,
  'rawContent': 'cipher-$id',
  'barcodeFormat': 'qrCode',
  'category': 'url',
  'safetyScore': safetyScore,
  'isFavorite': isFavorite,
};

Future<Set<String>> _indexNames(Database db) async {
  final rows = await db.rawQuery(
    "SELECT name FROM sqlite_master WHERE type = 'index' "
    "AND tbl_name = '${HistoryDatabaseSchema.tableName}' "
    "AND name NOT LIKE 'sqlite_autoindex%'",
  );
  return rows.map((r) => r['name']! as String).toSet();
}

void main() {
  late Directory tempDir;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('history_schema_test');
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  test('a fresh install gets the current schema with indexes', () async {
    final db = await _openCurrent(p.join(tempDir.path, 'fresh.db'));
    expect(await db.getVersion(), HistoryDatabaseSchema.version);
    expect(await _indexNames(db), {
      'idx_scan_records_timestamp',
      'idx_scan_records_category',
      'idx_scan_records_favorite',
    });
    await db.close();
  });

  test('foreign keys are enabled on open', () async {
    final db = await _openCurrent(p.join(tempDir.path, 'fk.db'));
    final rows = await db.rawQuery('PRAGMA foreign_keys');
    expect(rows.first.values.first, 1);
    await db.close();
  });

  test('WAL journal mode is enabled for a file database', () async {
    final db = await _openCurrent(p.join(tempDir.path, 'wal.db'));
    final rows = await db.rawQuery('PRAGMA journal_mode');
    expect((rows.first.values.first! as String).toLowerCase(), 'wal');
    await db.close();
  });

  test('CHECK constraints reject bad values', () async {
    final db = await _openCurrent(p.join(tempDir.path, 'check.db'));
    await db.insert(HistoryDatabaseSchema.tableName, _row('ok'));
    await expectLater(
      db.insert(HistoryDatabaseSchema.tableName, _row('fav', isFavorite: 2)),
      throwsA(isA<DatabaseException>()),
    );
    await expectLater(
      db.insert(HistoryDatabaseSchema.tableName, _row('low', safetyScore: -1)),
      throwsA(isA<DatabaseException>()),
    );
    await expectLater(
      db.insert(
        HistoryDatabaseSchema.tableName,
        _row('high', safetyScore: 101),
      ),
      throwsA(isA<DatabaseException>()),
    );
    await db.close();
  });

  test('upgrading from v1 keeps every row and clamps bad values', () async {
    final path = p.join(tempDir.path, 'upgrade.db');

    // A database as shipped with schema v1.
    final v1 = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) => db.execute(HistoryDatabaseSchema.v1CreateTableSql),
    );
    await v1.insert(HistoryDatabaseSchema.tableName, _row('a', timestamp: 1));
    await v1.insert(
      HistoryDatabaseSchema.tableName,
      _row('b', safetyScore: 150, isFavorite: 1, timestamp: 2),
    );
    await v1.insert(
      HistoryDatabaseSchema.tableName,
      _row('c', safetyScore: -5, isFavorite: 7, timestamp: 3),
    );
    await v1.close();

    final db = await _openCurrent(path);
    expect(await db.getVersion(), HistoryDatabaseSchema.version);

    final rows = await db.query(
      HistoryDatabaseSchema.tableName,
      orderBy: 'timestamp',
    );
    expect(rows.map((r) => r['id']), ['a', 'b', 'c']);
    expect(rows.map((r) => r['safetyScore']), [80, 100, 0]);
    expect(rows.map((r) => r['isFavorite']), [0, 1, 1]);
    expect(rows.first['rawContent'], 'cipher-a');
    expect(await _indexNames(db), hasLength(3));
    await db.close();
  });
}
