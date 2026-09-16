import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreeraj_qr_reader/models/backup_exception.dart';
import 'package:sreeraj_qr_reader/models/device_sync_data.dart';
import 'package:sreeraj_qr_reader/models/scan_record.dart';
import 'package:sreeraj_qr_reader/services/device_sync_service.dart';
import 'package:sreeraj_qr_reader/services/history_export_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DeviceSyncService service;
  final now = DateTime(2026, 9, 14, 21);

  final sampleRecords = [
    ScanRecord(
      id: 'scan-1',
      timestamp: now,
      rawContent: 'https://example.com/safe',
      barcodeFormat: 'qrCode',
      category: 'url',
      safetyScore: 98,
      notes: 'Test URL note',
      isFavorite: true,
    ),
    ScanRecord(
      id: 'scan-2',
      timestamp: now.add(const Duration(minutes: 5)),
      rawContent: 'WIFI:T:WPA;S:HomeNetwork;P:SuperSecret;;',
      barcodeFormat: 'qrCode',
      category: 'wifi',
    ),
  ];

  final sampleSettings = <String, dynamic>{
    DeviceSyncService.prefThemeModeKey: 'dark',
    DeviceSyncService.prefUseDynamicColorKey: false,
    DeviceSyncService.prefScanOverlayStyleKey: 'cyberneticGrid',
    DeviceSyncService.prefLanguageKey: 'ml',
    DeviceSyncService.prefVibrationKey: true,
    DeviceSyncService.prefSoundKey: false,
    DeviceSyncService.prefActiveProbingKey: true,
    DeviceSyncService.prefFlashModeKey: 'auto',
    DeviceSyncService.prefResolutionPresetKey: 'fullHd',
  };

  setUp(() {
    service = DeviceSyncService();
  });

  group('DeviceSyncData Model', () {
    test('serializes to JSON and deserializes correctly', () {
      final syncData = DeviceSyncData(
        exportedAt: now,
        records: sampleRecords,
        settings: sampleSettings,
      );

      final json = syncData.toJson();
      expect(json['app'], 'SreerajP QR Reader');
      expect(json['totalRecords'], 2);
      expect(json['records'], hasLength(2));
      expect(json['settings'], equals(sampleSettings));

      final restored = DeviceSyncData.fromJson(json);
      expect(restored.version, syncData.version);
      expect(restored.records.length, 2);
      expect(restored.records.first.id, 'scan-1');
      expect(restored.records.first.isFavorite, isTrue);
      expect(restored.settings, equals(sampleSettings));
    });
  });

  group('DeviceSyncService Encryption & Decryption', () {
    test('creates encrypted package and inspects header metadata', () {
      final syncData = DeviceSyncData(
        exportedAt: now,
        records: sampleRecords,
        settings: sampleSettings,
      );

      const passphrase = 'MySecureSyncPin123';
      final package = service.createEncryptedSyncPackage(syncData, passphrase);

      expect(service.isSyncPackage(package), isTrue);

      final headerInfo = service.inspectPackageHeader(package);
      expect(headerInfo, isNotNull);
      expect(headerInfo!['header'], DeviceSyncService.syncHeaderV1);
      expect(headerInfo['recordsCount'], 2);
      expect(headerInfo['hasSettings'], isTrue);
    });

    test('successfully decrypts package with correct passphrase', () {
      final syncData = DeviceSyncData(
        exportedAt: now,
        records: sampleRecords,
        settings: sampleSettings,
      );

      const passphrase = 'CorrectPassphrase!';
      final package = service.createEncryptedSyncPackage(syncData, passphrase);

      final decrypted = service.decryptSyncPackage(package, passphrase);
      expect(decrypted.records.length, 2);
      expect(decrypted.records[0].rawContent, 'https://example.com/safe');
      expect(decrypted.records[1].category, 'wifi');
      expect(decrypted.settings[DeviceSyncService.prefThemeModeKey], 'dark');
      expect(decrypted.settings[DeviceSyncService.prefLanguageKey], 'ml');
    });

    test('throws BackupException with wrong passphrase', () {
      final syncData = DeviceSyncData(
        exportedAt: now,
        records: sampleRecords,
        settings: sampleSettings,
      );

      final package = service.createEncryptedSyncPackage(syncData, 'Pass123');

      expect(
        () => service.decryptSyncPackage(package, 'WrongPassphrase'),
        throwsA(isA<BackupException>()),
      );
    });

    test('throws BackupException on malformed payload or bad header', () {
      expect(
        () => service.decryptSyncPackage('not a json', 'Pass123'),
        throwsA(isA<BackupException>()),
      );

      expect(
        () => service.decryptSyncPackage(
          '{"header": "UNKNOWN", "encryptedData": "abc"}',
          'Pass123',
        ),
        throwsA(isA<BackupException>()),
      );
    });

    test('decrypts legacy SREERAJ_QR_BACKUP_V1 backup format seamlessly', () {
      final exportService = HistoryExportService();
      const passphrase = 'LegacyPassword99';
      final legacyPackage = exportService.createEncryptedBackup(
        sampleRecords,
        passphrase,
      );

      expect(service.isSyncPackage(legacyPackage), isTrue);

      final decrypted = service.decryptSyncPackage(legacyPackage, passphrase);
      expect(decrypted.records.length, 2);
      expect(decrypted.records[0].id, 'scan-1');
      expect(decrypted.settings, isEmpty);
    });
  });

  group('DeviceSyncService Settings Collection & Application', () {
    test('collects settings from SharedPreferences correctly', () async {
      SharedPreferences.setMockInitialValues({
        DeviceSyncService.prefThemeModeKey: 'oled',
        DeviceSyncService.prefUseDynamicColorKey: true,
        DeviceSyncService.prefScanOverlayStyleKey: 'laserLine',
        DeviceSyncService.prefLanguageKey: 'sa',
        DeviceSyncService.prefVibrationKey: false,
        DeviceSyncService.prefSoundKey: true,
        DeviceSyncService.prefActiveProbingKey: false,
        DeviceSyncService.prefFlashModeKey: 'on',
        DeviceSyncService.prefResolutionPresetKey: 'hd',
      });

      final prefs = await SharedPreferences.getInstance();
      final collected = service.collectSettings(prefs);

      expect(collected[DeviceSyncService.prefThemeModeKey], 'oled');
      expect(collected[DeviceSyncService.prefLanguageKey], 'sa');
      expect(collected[DeviceSyncService.prefVibrationKey], isFalse);
      expect(collected[DeviceSyncService.prefSoundKey], isTrue);
      expect(collected[DeviceSyncService.prefFlashModeKey], 'on');
    });

    test('applies synced settings into SharedPreferences correctly', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await service.applySettings(sampleSettings, prefs);

      expect(prefs.getString(DeviceSyncService.prefThemeModeKey), 'dark');
      expect(prefs.getBool(DeviceSyncService.prefUseDynamicColorKey), isFalse);
      expect(
        prefs.getString(DeviceSyncService.prefScanOverlayStyleKey),
        'cyberneticGrid',
      );
      expect(prefs.getString(DeviceSyncService.prefLanguageKey), 'ml');
      expect(prefs.getBool(DeviceSyncService.prefVibrationKey), isTrue);
      expect(prefs.getBool(DeviceSyncService.prefSoundKey), isFalse);
    });
  });
}
