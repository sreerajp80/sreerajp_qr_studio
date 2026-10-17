import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;

import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/models/backup_exception.dart';
import 'package:sreerajp_qr_studio/models/history_report_labels.dart';
import 'package:sreerajp_qr_studio/services/history_export_service.dart';
import 'package:sreerajp_qr_studio/services/passphrase_cipher.dart';

void main() {
  const testLabels = HistoryReportLabels(
    reportHeading: 'SREERAJP QR STUDIO - SCAN HISTORY',
    reportTitle: 'Scan History Export',
    exportDateLabel: 'Export Date',
    totalScansLabel: 'Total Scans',
    scanNumberLabel: 'Scan #',
    idLabel: 'ID           ',
    timestampLabel: 'Timestamp    ',
    formatLabel: 'Format       ',
    categoryLabel: 'Category     ',
    safetyScoreLabel: 'Safety Score ',
    starredLabel: 'Starred      ',
    starredYes: '⭐ Yes',
    starredNo: 'No',
    locationLabel: 'Location     ',
    notesLabel: 'Notes        ',
    contentLabel: 'Content      ',
    columnDateTime: 'Date & Time',
    columnFormat: 'Format',
    columnCategory: 'Category',
    columnSafety: 'Safety',
    columnContent: 'Content Snippet',
    columnNotes: 'Notes',
  );

  group('HistoryExportService Tests', () {
    late HistoryExportService service;
    late List<ScanRecord> records;

    setUp(() {
      service = HistoryExportService();
      records = [
        ScanRecord(
          id: 'rec-1',
          timestamp: DateTime(2026, 7, 31, 8),
          rawContent: 'https://secure-site.com',
          barcodeFormat: 'qrCode',
          category: 'url',
          notes: 'Important link',
          locationTag: 'Work',
          isFavorite: true,
        ),
        ScanRecord(
          id: 'rec-2',
          timestamp: DateTime(2026, 7, 31, 9, 30),
          rawContent: 'WIFI:S:MyRouter;T:WPA;P:secret123;;',
          barcodeFormat: 'qrCode',
          category: 'wifi',
        ),
      ];
    });

    test('exportToCsv generates valid CSV with headers and records', () {
      final csv = service.exportToCsv(records);
      expect(csv, contains('ID,Timestamp,Barcode Format,Category'));
      expect(csv, contains('rec-1'));
      expect(csv, contains('https://secure-site.com'));
      expect(csv, contains('WIFI:S:MyRouter'));
    });

    test('exportToJson generates structured JSON with app metadata', () {
      final jsonStr = service.exportToJson(records);
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;

      expect(map['app'], 'SreerajP QR Studio');
      expect(map['totalRecords'], 2);
      expect((map['records'] as List).length, 2);
    });

    test('exportToFormattedTxt generates readable report', () {
      final txt = service.exportToFormattedTxt(records, testLabels);
      expect(txt, contains('SREERAJP QR STUDIO - SCAN HISTORY'));
      expect(txt, contains('Total Scans: 2'));
      expect(txt, contains('Category     : URL'));
      expect(txt, contains('Category     : WIFI'));
    });

    test('exportToPdf generates non-empty PDF byte array', () async {
      final pdfBytes = await service.exportToPdf(records, testLabels);
      expect(pdfBytes, isNotNull);
      expect(pdfBytes.length, greaterThan(100));
    });

    group('encrypted backup (.sreerajqr)', () {
      // Few iterations keep the tests fast; one test checks the real default.
      final fast = HistoryExportService(
        cipher: PassphraseCipher(iterations: 10000),
      );

      test('v2 round trip restores every record', () async {
        const passphrase = 'MySuperSecretPassword123!';
        final backupStr = await fast.createEncryptedBackup(records, passphrase);
        final container = jsonDecode(backupStr) as Map<String, dynamic>;
        expect(container['header'], HistoryExportService.backupHeaderV2);
        expect(container['kdf'], 'pbkdf2-hmac-sha256');
        expect(container['iterations'], 10000);
        expect(backupStr, isNot(contains('secure-site.com')));

        final restored = await fast.restoreEncryptedBackup(
          backupStr,
          passphrase,
        );
        expect(restored.length, 2);
        expect(restored[0].id, 'rec-1');
        expect(restored[0].rawContent, 'https://secure-site.com');
        expect(restored[1].id, 'rec-2');
      });

      test('new backups use 600,000 PBKDF2 iterations by default', () {
        expect(PassphraseCipher.defaultIterations, 600000);
      });

      test('the same passphrase twice gives different files', () async {
        final a = await fast.createEncryptedBackup(records, 'same');
        final b = await fast.createEncryptedBackup(records, 'same');
        final ca = jsonDecode(a) as Map<String, dynamic>;
        final cb = jsonDecode(b) as Map<String, dynamic>;
        expect(ca['salt'], isNot(cb['salt']));
        expect(ca['nonce'], isNot(cb['nonce']));
        expect(ca['data'], isNot(cb['data']));
      });

      test('a wrong passphrase is rejected', () async {
        final backupStr = await fast.createEncryptedBackup(records, 'Right');
        await expectLater(
          fast.restoreEncryptedBackup(backupStr, 'Wrong'),
          throwsA(isA<BackupException>()),
        );
      });

      test('a changed byte in the data is rejected', () async {
        final backupStr = await fast.createEncryptedBackup(records, 'pass');
        final container = jsonDecode(backupStr) as Map<String, dynamic>;
        final bytes = base64Url.decode(container['data'] as String);
        bytes[bytes.length - 1] ^= 0x01;
        container['data'] = base64Url.encode(bytes);
        await expectLater(
          fast.restoreEncryptedBackup(jsonEncode(container), 'pass'),
          throwsA(isA<BackupException>()),
        );
      });

      test('an unknown header or broken fields are rejected', () async {
        await expectLater(
          fast.restoreEncryptedBackup('{"header":"OTHER"}', 'pass'),
          throwsA(isA<BackupException>()),
        );
        await expectLater(
          fast.restoreEncryptedBackup('not json', 'pass'),
          throwsA(isA<BackupException>()),
        );
        final backupStr = await fast.createEncryptedBackup(records, 'pass');
        final container = jsonDecode(backupStr) as Map<String, dynamic>
          ..['iterations'] = 1;
        await expectLater(
          fast.restoreEncryptedBackup(jsonEncode(container), 'pass'),
          throwsA(isA<BackupException>()),
        );
      });

      test('an old v1 backup made with the old code still restores', () async {
        const passphrase = 'LegacyPassword99';
        final v1 = legacyV1Backup(fast.exportToJson(records), passphrase);
        final restored = await fast.restoreEncryptedBackup(v1, passphrase);
        expect(restored.map((r) => r.id), ['rec-1', 'rec-2']);
        await expectLater(
          fast.restoreEncryptedBackup(v1, 'wrong'),
          throwsA(isA<BackupException>()),
        );
      });
    });
  });
}

/// A `.sreerajqr` v1 backup built with the exact pre-v2 code.
String legacyV1Backup(String json, String passphrase) =>
    legacyV1Package('SREERAJ_QR_BACKUP_V1', json, passphrase);

/// A v1 container (backup or AirQR sync) built with the exact pre-v2 code:
/// key = SHA-256(passphrase), IV = first 16 key bytes, AES-CBC.
String legacyV1Package(String header, String json, String passphrase) {
  final digest = sha256.convert(utf8.encode(passphrase));
  final key = enc.Key(Uint8List.fromList(digest.bytes));
  final iv = enc.IV(Uint8List.fromList(digest.bytes.sublist(0, 16)));
  final encrypted = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc))
      .encrypt(json, iv: iv);
  return jsonEncode({'header': header, 'encryptedData': encrypted.base64});
}
