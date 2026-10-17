import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/models/app_exception.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/services/history_database_schema.dart';
import 'package:sreerajp_qr_studio/services/history_field_cipher.dart';

/// Scan history in SQLite, with the content fields encrypted by
/// [HistoryFieldCipher] (AES-256-GCM, see docs/security.md §6).
class HistoryDatabaseService {
  static const String _tableName = HistoryDatabaseSchema.tableName;
  static const String _storageKeyName = 'db_encryption_key_v1';

  /// Columns whose values are encrypted.
  static const List<String> encryptedColumns = [
    'rawContent',
    'imageThumbnail',
    'locationTag',
    'notes',
    'metadata',
  ];

  final FlutterSecureStorage _secureStorage;
  Database? _db;
  HistoryFieldCipher? _cipher;
  bool _legacyUpgradeDone = false;

  HistoryDatabaseService({
    FlutterSecureStorage? secureStorage,
    Database? database,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
       _db = database;

  /// Loads the key, opens the database, and upgrades any rows still in the
  /// old encryption format. Throws [StorageException] if the key cannot be
  /// read or saved.
  Future<Database> get database async {
    await _initEncryption();
    _db ??= await _initDatabase();
    if (!_legacyUpgradeDone) {
      await _upgradeLegacyRows(_db!);
      _legacyUpgradeDone = true;
    }
    return _db!;
  }

  Future<void> _initEncryption() async {
    if (_cipher != null) return;

    String? keyB64;
    try {
      keyB64 = await _secureStorage.read(key: _storageKeyName);
    } catch (e, st) {
      // Never make a new key here: that would overwrite the stored one and
      // make every saved row unreadable.
      AppLogger.error('Reading history key failed', error: e, stackTrace: st);
      throw StorageException('history key unavailable', cause: e);
    }

    if (keyB64 == null || keyB64.isEmpty) {
      keyB64 = await _createAndSaveKey();
    }

    final List<int> keyBytes;
    try {
      keyBytes = base64Url.decode(keyB64);
      _cipher = HistoryFieldCipher(keyBytes);
    } catch (e, st) {
      AppLogger.error('History key is not valid', error: e, stackTrace: st);
      throw StorageException('history key invalid', cause: e);
    }
  }

  /// Makes a new key, saves it, and reads it back. The key is used only if
  /// the read-back matches, so nothing is encrypted with an unsaved key.
  Future<String> _createAndSaveKey() async {
    final random = Random.secure();
    final keyB64 = base64Url.encode(
      List<int>.generate(32, (_) => random.nextInt(256)),
    );
    try {
      await _secureStorage.write(key: _storageKeyName, value: keyB64);
      final readBack = await _secureStorage.read(key: _storageKeyName);
      if (readBack != keyB64) {
        throw StateError('history key read-back mismatch');
      }
    } catch (e, st) {
      AppLogger.error('Saving history key failed', error: e, stackTrace: st);
      throw StorageException('history key not saved', cause: e);
    }
    return keyB64;
  }

  String _encryptString(String plainText) {
    try {
      return _cipher!.encrypt(plainText);
    } catch (e) {
      throw StorageException('history field encryption failed', cause: e);
    }
  }

  String _decryptString(String stored) => _cipher!.decrypt(stored);

  /// Re-encrypts rows written before format v2. Runs in one transaction and
  /// is idempotent, so an interrupted run simply repeats on the next open.
  Future<void> _upgradeLegacyRows(Database db) async {
    final notCurrent = encryptedColumns
        .map(
          (c) =>
              "($c IS NOT NULL AND $c != '' "
              "AND $c NOT LIKE '${HistoryFieldCipher.formatPrefix}%')",
        )
        .join(' OR ');
    final rows = await db.query(
      _tableName,
      columns: ['id', ...encryptedColumns],
      where: notCurrent,
    );
    if (rows.isEmpty) return;

    final cipher = _cipher!;
    await db.transaction((txn) async {
      for (final row in rows) {
        final values = <String, Object?>{};
        for (final column in encryptedColumns) {
          final stored = row[column] as String?;
          if (stored == null || HistoryFieldCipher.isCurrentFormat(stored)) {
            continue;
          }
          values[column] = cipher.encrypt(cipher.decryptLegacy(stored));
        }
        if (values.isNotEmpty) {
          await txn.update(
            _tableName,
            values,
            where: 'id = ?',
            whereArgs: [row['id']],
          );
        }
      }
    });
    AppLogger.info('Upgraded ${rows.length} history rows to format v2');
  }

  static const String _fileName = 'sreeraj_scan_history.db';

  Future<String> _databasePath() async {
    try {
      final dbDir = await getApplicationDocumentsDirectory();
      return p.join(dbDir.path, _fileName);
    } catch (_) {
      return p.join(await getDatabasesPath(), _fileName);
    }
  }

  /// Closes the connection and deletes the database file together with its
  /// `-wal`, `-shm` and `-journal` files ("Delete all data", §15.4). The
  /// next call to [database] creates a fresh, empty database. The key itself
  /// lives in secure storage and is removed there by the caller.
  Future<void> closeAndDeleteDatabase() async {
    final open = _db;
    final paths = <String>{
      if (open != null && open.path != inMemoryDatabasePath) open.path,
    };
    try {
      paths.add(await _databasePath());
    } catch (_) {
      // No file path available (for example in tests); nothing to delete.
    }
    _db = null;
    _cipher = null;
    _legacyUpgradeDone = false;
    if (open != null && open.isOpen) {
      await open.close();
    }
    for (final path in paths) {
      await deleteDatabase(path);
    }
  }

  Future<Database> _initDatabase() async {
    await _initEncryption();
    final dbPath = await _databasePath();

    return await openDatabase(
      dbPath,
      version: HistoryDatabaseSchema.version,
      onConfigure: HistoryDatabaseSchema.onConfigure,
      onCreate: HistoryDatabaseSchema.onCreate,
      onUpgrade: HistoryDatabaseSchema.onUpgrade,
    );
  }

  /// Encrypts sensitive fields before saving to SQLite database.
  Map<String, dynamic> _toEncryptedMap(ScanRecord record) {
    return {
      'id': record.id,
      'timestamp': record.timestamp.millisecondsSinceEpoch,
      'rawContent': _encryptString(record.rawContent),
      'barcodeFormat': record.barcodeFormat,
      'category': record.category,
      'imageThumbnail': record.imageThumbnail != null
          ? _encryptString(record.imageThumbnail!)
          : null,
      'locationTag': record.locationTag != null
          ? _encryptString(record.locationTag!)
          : null,
      'safetyScore': record.safetyScore,
      'notes': record.notes != null ? _encryptString(record.notes!) : null,
      'isFavorite': record.isFavorite ? 1 : 0,
      'metadata': record.metadata != null
          ? _encryptString(jsonEncode(record.metadata))
          : null,
    };
  }

  /// Decrypts encrypted database fields back into ScanRecord domain object.
  ScanRecord _fromEncryptedMap(Map<String, dynamic> map) {
    final rawContentCipher = map['rawContent'] as String? ?? '';
    final thumbnailCipher = map['imageThumbnail'] as String?;
    final locationCipher = map['locationTag'] as String?;
    final notesCipher = map['notes'] as String?;
    final metadataCipher = map['metadata'] as String?;

    Map<String, dynamic>? parsedMetadata;
    if (metadataCipher != null && metadataCipher.isNotEmpty) {
      // A failed tag check throws here, so a changed row is skipped (below);
      // only bad JSON inside a readable value is treated as "no metadata".
      final decryptedMeta = _decryptString(metadataCipher);
      try {
        parsedMetadata = jsonDecode(decryptedMeta) as Map<String, dynamic>;
      } catch (_) {
        parsedMetadata = null;
      }
    }

    return ScanRecord(
      id: map['id'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      rawContent: _decryptString(rawContentCipher),
      barcodeFormat: map['barcodeFormat'] as String? ?? 'qrCode',
      category: map['category'] as String? ?? 'text',
      imageThumbnail: thumbnailCipher != null
          ? _decryptString(thumbnailCipher)
          : null,
      locationTag: locationCipher != null
          ? _decryptString(locationCipher)
          : null,
      safetyScore: (map['safetyScore'] as num?)?.toInt() ?? 100,
      notes: notesCipher != null ? _decryptString(notesCipher) : null,
      isFavorite: (map['isFavorite'] == 1 || map['isFavorite'] == true),
      metadata: parsedMetadata,
    );
  }

  /// Inserts a new scan record or updates if already exists.
  Future<void> insertRecord(ScanRecord record) async {
    final db = await database;
    await _initEncryption();
    final data = _toEncryptedMap(record);
    await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetches all records with optional filtering by category, favorites, and search query.
  Future<List<ScanRecord>> getRecords({
    String? category,
    bool? onlyFavorites,
    String? searchQuery,
  }) async {
    final db = await database;
    await _initEncryption();

    String? whereClause;
    final List<dynamic> whereArgs = [];

    if (category != null &&
        category.toLowerCase() != 'all' &&
        category.toLowerCase() != 'favorites') {
      whereClause = 'LOWER(category) = ?';
      whereArgs.add(category.toLowerCase());
    }

    if (onlyFavorites == true ||
        (category != null && category.toLowerCase() == 'favorites')) {
      if (whereClause != null) {
        whereClause += ' AND isFavorite = 1';
      } else {
        whereClause = 'isFavorite = 1';
      }
    }

    final maps = await db.query(
      _tableName,
      where: whereClause,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'timestamp DESC',
    );

    final records = <ScanRecord>[];
    var unreadable = 0;
    for (final map in maps) {
      try {
        records.add(_fromEncryptedMap(map));
      } catch (_) {
        // Changed or damaged row: skip it, keep it on disk.
        unreadable++;
      }
    }
    if (unreadable > 0) {
      AppLogger.warning('Skipped $unreadable unreadable history rows');
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      return records.where((r) {
        return r.rawContent.toLowerCase().contains(query) ||
            r.barcodeFormat.toLowerCase().contains(query) ||
            r.category.toLowerCase().contains(query) ||
            (r.notes != null && r.notes!.toLowerCase().contains(query)) ||
            (r.locationTag != null &&
                r.locationTag!.toLowerCase().contains(query));
      }).toList();
    }

    return records;
  }

  /// Toggles favorite status of a scan record.
  Future<void> toggleFavorite(String id, bool currentStatus) async {
    final db = await database;
    await db.update(
      _tableName,
      {'isFavorite': currentStatus ? 0 : 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Updates custom user notes for a scan record.
  Future<void> updateNotes(String id, String? notes) async {
    final db = await database;
    await _initEncryption();
    final encryptedNotes = notes != null ? _encryptString(notes) : null;
    await db.update(
      _tableName,
      {'notes': encryptedNotes},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Updates location tag for a scan record.
  Future<void> updateLocationTag(String id, String? locationTag) async {
    final db = await database;
    await _initEncryption();
    final encryptedLocation = locationTag != null
        ? _encryptString(locationTag)
        : null;
    await db.update(
      _tableName,
      {'locationTag': encryptedLocation},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Deletes a scan record by ID.
  Future<void> deleteRecord(String id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  /// Clears all scan records from database.
  Future<void> clearAll() async {
    final db = await database;
    await db.delete(_tableName);
  }
}
