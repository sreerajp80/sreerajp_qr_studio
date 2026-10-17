import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sreerajp_qr_studio/models/app_exception.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/services/history_database_schema.dart';
import 'package:sreerajp_qr_studio/services/history_database_service.dart';

class FakeFlutterSecureStorage extends Fake implements FlutterSecureStorage {
  final Map<String, String> _storage = {};

  @override
  Future<String?> read({
    required String key,
    AndroidOptions? aOptions,
    AppleOptions? iOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    return _storage[key];
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
    AndroidOptions? aOptions,
    AppleOptions? iOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    if (value != null) {
      _storage[key] = value;
    } else {
      _storage.remove(key);
    }
  }
}

class _ThrowingReadStorage extends FakeFlutterSecureStorage {
  int writes = 0;

  @override
  Future<String?> read({
    required String key,
    AndroidOptions? aOptions,
    AppleOptions? iOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async => throw Exception('keystore unavailable');

  @override
  Future<void> write({
    required String key,
    required String? value,
    AndroidOptions? aOptions,
    AppleOptions? iOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    writes++;
  }
}

class _ThrowingWriteStorage extends FakeFlutterSecureStorage {
  @override
  Future<void> write({
    required String key,
    required String? value,
    AndroidOptions? aOptions,
    AppleOptions? iOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async => throw Exception('keystore write failed');
}

/// The exact pre-v2 scheme: AES-CBC, PKCS7, IV = first 16 key bytes.
String _legacyEncrypt(List<int> keyBytes, String plain) {
  final key = enc.Key(Uint8List.fromList(keyBytes.take(32).toList()));
  final iv = enc.IV(
    Uint8List.fromList(
      List<int>.generate(16, (i) => keyBytes[i % keyBytes.length]),
    ),
  );
  return enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc))
      .encrypt(plain, iv: iv)
      .base64;
}

Future<Database> _freshDb() => openDatabase(
  inMemoryDatabasePath,
  version: HistoryDatabaseSchema.version,
  singleInstance: false,
  onConfigure: HistoryDatabaseSchema.onConfigure,
  onCreate: HistoryDatabaseSchema.onCreate,
  onUpgrade: HistoryDatabaseSchema.onUpgrade,
);

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('HistoryDatabaseService Tests', () {
    late HistoryDatabaseService dbService;
    late FakeFlutterSecureStorage fakeStorage;

    setUp(() async {
      fakeStorage = FakeFlutterSecureStorage();
      final inMemoryDb = await openDatabase(
        inMemoryDatabasePath,
        version: HistoryDatabaseSchema.version,
        onConfigure: HistoryDatabaseSchema.onConfigure,
        onCreate: HistoryDatabaseSchema.onCreate,
        onUpgrade: HistoryDatabaseSchema.onUpgrade,
      );

      dbService = HistoryDatabaseService(
        secureStorage: fakeStorage,
        database: inMemoryDb,
      );
      await dbService.clearAll();
    });

    tearDown(() async {
      await dbService.clearAll();
    });

    test('insertRecord and getRecords retrieves decrypted record', () async {
      final record = ScanRecord(
        id: 'rec-db-1',
        timestamp: DateTime(2026, 7, 31, 10),
        rawContent: 'https://encrypted-test.org',
        barcodeFormat: 'qrCode',
        category: 'url',
        safetyScore: 90,
        notes: 'Secret Note',
        isFavorite: true,
      );

      await dbService.insertRecord(record);

      final records = await dbService.getRecords();
      expect(records.length, 1);
      expect(records.first.id, 'rec-db-1');
      expect(records.first.rawContent, 'https://encrypted-test.org');
      expect(records.first.notes, 'Secret Note');
      expect(records.first.isFavorite, true);
    });

    test('getRecords filters by category and search query', () async {
      await dbService.insertRecord(
        ScanRecord(
          id: '1',
          timestamp: DateTime.now(),
          rawContent: 'WIFI:S:HomeNet;;',
          barcodeFormat: 'qrCode',
          category: 'wifi',
        ),
      );
      await dbService.insertRecord(
        ScanRecord(
          id: '2',
          timestamp: DateTime.now(),
          rawContent: 'https://google.com',
          barcodeFormat: 'qrCode',
          category: 'url',
        ),
      );

      final wifiOnly = await dbService.getRecords(category: 'wifi');
      expect(wifiOnly.length, 1);
      expect(wifiOnly.first.category, 'wifi');

      final searchGoogle = await dbService.getRecords(searchQuery: 'google');
      expect(searchGoogle.length, 1);
      expect(searchGoogle.first.rawContent, contains('google.com'));
    });

    test('toggleFavorite updates favorite status', () async {
      await dbService.insertRecord(
        ScanRecord(
          id: 'fav-1',
          timestamp: DateTime.now(),
          rawContent: 'Test',
          barcodeFormat: 'qrCode',
          category: 'text',
        ),
      );

      await dbService.toggleFavorite('fav-1', false);
      final updated = await dbService.getRecords();
      expect(updated.first.isFavorite, true);
    });

    test('updateNotes updates custom user notes', () async {
      await dbService.insertRecord(
        ScanRecord(
          id: 'note-1',
          timestamp: DateTime.now(),
          rawContent: 'Test',
          barcodeFormat: 'qrCode',
          category: 'text',
        ),
      );

      await dbService.updateNotes('note-1', 'Added new note');
      final updated = await dbService.getRecords();
      expect(updated.first.notes, 'Added new note');
    });

    test('deleteRecord removes record from database', () async {
      await dbService.insertRecord(
        ScanRecord(
          id: 'del-1',
          timestamp: DateTime.now(),
          rawContent: 'Test',
          barcodeFormat: 'qrCode',
          category: 'text',
        ),
      );

      await dbService.deleteRecord('del-1');
      final list = await dbService.getRecords();
      expect(list.isEmpty, true);
    });

    test('clearAll wipes database table', () async {
      await dbService.insertRecord(
        ScanRecord(
          id: 'c-1',
          timestamp: DateTime.now(),
          rawContent: 'Test 1',
          barcodeFormat: 'qrCode',
          category: 'text',
        ),
      );
      await dbService.insertRecord(
        ScanRecord(
          id: 'c-2',
          timestamp: DateTime.now(),
          rawContent: 'Test 2',
          barcodeFormat: 'qrCode',
          category: 'text',
        ),
      );

      await dbService.clearAll();
      final list = await dbService.getRecords();
      expect(list.isEmpty, true);
    });
  });

  group('History encryption (format v2)', () {
    final keyBytes = List<int>.generate(32, (i) => i);
    final keyB64 = base64Url.encode(keyBytes);

    Future<FakeFlutterSecureStorage> storageWithKey() async {
      final storage = FakeFlutterSecureStorage();
      await storage.write(key: 'db_encryption_key_v1', value: keyB64);
      return storage;
    }

    test('fields are stored in h2: format, never as plain text', () async {
      final db = await _freshDb();
      final service = HistoryDatabaseService(
        secureStorage: await storageWithKey(),
        database: db,
      );
      await service.insertRecord(
        ScanRecord(
          id: 'v2-1',
          timestamp: DateTime(2026, 10, 12),
          rawContent: 'https://plain.example',
          barcodeFormat: 'qrCode',
          category: 'url',
          notes: 'note text',
        ),
      );
      final row = (await db.query(HistoryDatabaseSchema.tableName)).single;
      expect(row['rawContent'], startsWith('h2:'));
      expect(row['notes'], startsWith('h2:'));
      expect(row['rawContent'], isNot(contains('plain.example')));
      final list = await service.getRecords();
      expect(list.single.rawContent, 'https://plain.example');
      expect(list.single.notes, 'note text');
      await db.close();
    });

    test(
      'old-format rows are upgraded on open and read back the same',
      () async {
        final db = await _freshDb();
        await db.insert(HistoryDatabaseSchema.tableName, {
          'id': 'old-1',
          'timestamp': 1,
          'rawContent': _legacyEncrypt(keyBytes, 'legacy content'),
          'barcodeFormat': 'qrCode',
          'category': 'text',
          'safetyScore': 100,
          'isFavorite': 0,
          'notes': 'plain fallback note',
          'metadata': _legacyEncrypt(keyBytes, '{"k":"v"}'),
        });

        final service = HistoryDatabaseService(
          secureStorage: await storageWithKey(),
          database: db,
        );
        final list = await service.getRecords();
        expect(list.single.rawContent, 'legacy content');
        expect(list.single.notes, 'plain fallback note');
        expect(list.single.metadata, {'k': 'v'});

        final row = (await db.query(HistoryDatabaseSchema.tableName)).single;
        for (final column in ['rawContent', 'notes', 'metadata']) {
          expect(row[column], startsWith('h2:'), reason: column);
        }
        await db.close();
      },
    );

    test('a key read error throws and never writes a new key', () async {
      final db = await _freshDb();
      final storage = _ThrowingReadStorage();
      final service = HistoryDatabaseService(
        secureStorage: storage,
        database: db,
      );
      await expectLater(service.getRecords(), throwsA(isA<StorageException>()));
      expect(storage.writes, 0);
      await db.close();
    });

    test('a key write error stops the insert; nothing is stored', () async {
      final db = await _freshDb();
      final service = HistoryDatabaseService(
        secureStorage: _ThrowingWriteStorage(),
        database: db,
      );
      await expectLater(
        service.insertRecord(
          ScanRecord(
            id: 'w-1',
            timestamp: DateTime.now(),
            rawContent: 'secret',
            barcodeFormat: 'qrCode',
            category: 'text',
          ),
        ),
        throwsA(isA<StorageException>()),
      );
      expect(await db.query(HistoryDatabaseSchema.tableName), isEmpty);
      await db.close();
    });

    test('a changed row is skipped and the others still load', () async {
      final db = await _freshDb();
      final service = HistoryDatabaseService(
        secureStorage: await storageWithKey(),
        database: db,
      );
      for (final id in ['good', 'bad']) {
        await service.insertRecord(
          ScanRecord(
            id: id,
            timestamp: DateTime.now(),
            rawContent: 'content $id',
            barcodeFormat: 'qrCode',
            category: 'text',
          ),
        );
      }
      final bad = (await db.query(
        HistoryDatabaseSchema.tableName,
        where: 'id = ?',
        whereArgs: ['bad'],
      )).single;
      final bytes = base64Url.decode(
        (bad['rawContent']! as String).substring(3),
      );
      bytes[bytes.length - 1] ^= 0x01;
      await db.update(
        HistoryDatabaseSchema.tableName,
        {'rawContent': 'h2:${base64Url.encode(bytes)}'},
        where: 'id = ?',
        whereArgs: ['bad'],
      );

      final list = await service.getRecords();
      expect(list.map((r) => r.id), ['good']);
      expect(
        await db.query(HistoryDatabaseSchema.tableName),
        hasLength(2),
        reason: 'the changed row is kept on disk',
      );
      await db.close();
    });
  });

  test(
    'closeAndDeleteDatabase closes and removes the file and WAL files',
    () async {
      final dir = await Directory.systemTemp.createTemp('history_delete');
      final path = '${dir.path}/history.db';
      final db = await openDatabase(
        path,
        version: HistoryDatabaseSchema.version,
        onConfigure: HistoryDatabaseSchema.onConfigure,
        onCreate: HistoryDatabaseSchema.onCreate,
        onUpgrade: HistoryDatabaseSchema.onUpgrade,
      );
      final storage = FakeFlutterSecureStorage();
      final service = HistoryDatabaseService(
        secureStorage: storage,
        database: db,
      );
      await service.insertRecord(
        ScanRecord(
          id: 'del-1',
          timestamp: DateTime.now(),
          rawContent: 'to be deleted',
          barcodeFormat: 'qrCode',
          category: 'text',
        ),
      );
      expect(File(path).existsSync(), isTrue);

      await service.closeAndDeleteDatabase();

      expect(db.isOpen, isFalse);
      for (final suffix in ['', '-wal', '-shm', '-journal']) {
        expect(File('$path$suffix').existsSync(), isFalse, reason: suffix);
      }
      await dir.delete(recursive: true);
    },
  );
}
