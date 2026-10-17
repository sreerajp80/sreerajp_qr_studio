import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/backup_exception.dart';
import 'package:sreerajp_qr_studio/models/device_sync_data.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/providers/camera_settings_provider.dart';
import 'package:sreerajp_qr_studio/services/device_sync_service.dart';
import 'package:sreerajp_qr_studio/services/history_export_service.dart';
import 'package:sreerajp_qr_studio/services/passphrase_cipher.dart';

import 'history_export_service_test.dart' show legacyV1Backup, legacyV1Package;

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
    service = DeviceSyncService(cipher: PassphraseCipher(iterations: 10000));
  });

  group('DeviceSyncData Model', () {
    test('serializes to JSON and deserializes correctly', () {
      final syncData = DeviceSyncData(
        exportedAt: now,
        records: sampleRecords,
        settings: sampleSettings,
      );

      final json = syncData.toJson();
      expect(json['app'], 'SreerajP QR Studio');
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
    DeviceSyncData syncData() => DeviceSyncData(
      exportedAt: now,
      records: sampleRecords,
      settings: sampleSettings,
    );

    test('creates a v2 package and inspects header metadata', () async {
      const passphrase = 'MySecureSyncPin123';
      final package = await service.createEncryptedSyncPackage(
        syncData(),
        passphrase,
      );

      expect(service.isSyncPackage(package), isTrue);
      final container = jsonDecode(package) as Map<String, dynamic>;
      expect(container['kdf'], 'pbkdf2-hmac-sha256');
      expect(package, isNot(contains('SuperSecret')));

      final headerInfo = service.inspectPackageHeader(package);
      expect(headerInfo, isNotNull);
      expect(headerInfo!['header'], DeviceSyncService.syncHeaderV2);
      expect(headerInfo['recordsCount'], 2);
      expect(headerInfo['hasSettings'], isTrue);
    });

    test('successfully decrypts package with correct passphrase', () async {
      const passphrase = 'CorrectPassphrase!';
      final package = await service.createEncryptedSyncPackage(
        syncData(),
        passphrase,
      );

      final decrypted = await service.decryptSyncPackage(package, passphrase);
      expect(decrypted.records.length, 2);
      expect(decrypted.records[0].rawContent, 'https://example.com/safe');
      expect(decrypted.records[1].category, 'wifi');
      expect(decrypted.settings[DeviceSyncService.prefThemeModeKey], 'dark');
      expect(decrypted.settings[DeviceSyncService.prefLanguageKey], 'ml');
    });

    test('throws BackupException with wrong passphrase', () async {
      final package = await service.createEncryptedSyncPackage(
        syncData(),
        'Pass123',
      );
      await expectLater(
        service.decryptSyncPackage(package, 'WrongPassphrase'),
        throwsA(isA<BackupException>()),
      );
    });

    test('throws BackupException on malformed payload or bad header', () async {
      await expectLater(
        service.decryptSyncPackage('not a json', 'Pass123'),
        throwsA(isA<BackupException>()),
      );
      await expectLater(
        service.decryptSyncPackage(
          '{"header": "UNKNOWN", "encryptedData": "abc"}',
          'Pass123',
        ),
        throwsA(isA<BackupException>()),
      );
    });

    test('still reads an old v1 sync package', () async {
      const passphrase = 'OldSyncPin';
      final v1 = legacyV1Package(
        DeviceSyncService.syncHeaderV1,
        jsonEncode(syncData().toJson()),
        passphrase,
      );
      expect(service.isSyncPackage(v1), isTrue);
      final decrypted = await service.decryptSyncPackage(v1, passphrase);
      expect(decrypted.records.length, 2);
      expect(decrypted.settings[DeviceSyncService.prefThemeModeKey], 'dark');
    });

    test(
      'decrypts legacy SREERAJ_QR_BACKUP_V1 backup format seamlessly',
      () async {
        final exportService = HistoryExportService();
        const passphrase = 'LegacyPassword99';
        final legacyPackage = legacyV1Backup(
          exportService.exportToJson(sampleRecords),
          passphrase,
        );

        expect(service.isSyncPackage(legacyPackage), isTrue);

        final decrypted = await service.decryptSyncPackage(
          legacyPackage,
          passphrase,
        );
        expect(decrypted.records.length, 2);
        expect(decrypted.records[0].id, 'scan-1');
        expect(decrypted.settings, isEmpty);
      },
    );

    test(
      'recognises and decrypts a v2 history backup sent over AirQR',
      () async {
        final exportService = HistoryExportService(
          cipher: PassphraseCipher(iterations: 10000),
        );
        const passphrase = 'BackupPass';
        final backup = await exportService.createEncryptedBackup(
          sampleRecords,
          passphrase,
        );
        expect(service.isSyncPackage(backup), isTrue);
        expect(
          service.inspectPackageHeader(backup)!['header'],
          HistoryExportService.backupHeaderV2,
        );
        final fast = DeviceSyncService(
          cipher: PassphraseCipher(iterations: 10000),
        );
        final decrypted = await fast.decryptSyncPackage(backup, passphrase);
        expect(decrypted.records.map((r) => r.id), ['scan-1', 'scan-2']);
        expect(decrypted.settings, isEmpty);
      },
    );
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

    test('collects and applies camera image adjustments', () async {
      SharedPreferences.setMockInitialValues({
        DeviceSyncService.prefBrightnessKey: 0.25,
        DeviceSyncService.prefContrastKey: 1.5,
        DeviceSyncService.prefInvertColorsKey: true,
      });
      final source = await SharedPreferences.getInstance();
      final collected = service.collectSettings(source);

      expect(collected[DeviceSyncService.prefBrightnessKey], 0.25);
      expect(collected[DeviceSyncService.prefContrastKey], 1.5);
      expect(collected[DeviceSyncService.prefInvertColorsKey], isTrue);

      SharedPreferences.setMockInitialValues({});
      final target = await SharedPreferences.getInstance();
      await service.applySettings(collected, target);
      expect(target.getDouble(DeviceSyncService.prefBrightnessKey), 0.25);
      expect(target.getDouble(DeviceSyncService.prefContrastKey), 1.5);
      expect(target.getBool(DeviceSyncService.prefInvertColorsKey), isTrue);
    });

    test('camera keys match the ones CameraSettingsProvider saves', () {
      expect(
        DeviceSyncService.prefBrightnessKey,
        CameraSettingsProvider.prefBrightnessKey,
      );
      expect(
        DeviceSyncService.prefContrastKey,
        CameraSettingsProvider.prefContrastKey,
      );
      expect(
        DeviceSyncService.prefInvertColorsKey,
        CameraSettingsProvider.prefInvertColorsKey,
      );
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
