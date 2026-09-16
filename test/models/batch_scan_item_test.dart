import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sreeraj_qr_reader/models/batch_scan_item.dart';
import 'package:sreeraj_qr_reader/models/parsed_payload.dart';

void main() {
  group('BatchScanItem Tests', () {
    test('instantiates correctly with defaults', () {
      final now = DateTime.now();
      final item = BatchScanItem(
        id: '123',
        timestamp: now,
        rawValue: 'https://example.com',
        format: BarcodeType.url,
        isUrl: true,
      );

      expect(item.id, equals('123'));
      expect(item.timestamp, equals(now));
      expect(item.rawValue, equals('https://example.com'));
      expect(item.format, equals(BarcodeType.url));
      expect(item.isUrl, isTrue);
      expect(item.isSafeUrl, isNull);
      expect(item.safetyScore, equals(100));
      expect(item.safetyChecks, isEmpty);
      expect(item.isAnalyzing, isFalse);
    });

    test('copyWith updates specified fields immutably', () {
      final item = BatchScanItem(
        id: '123',
        timestamp: DateTime.now(),
        rawValue: 'https://example.com',
        format: BarcodeType.url,
        isUrl: true,
      );

      final updated = item.copyWith(
        isSafeUrl: true,
        safetyScore: 90,
        isAnalyzing: false,
      );

      expect(updated.id, equals(item.id));
      expect(updated.isSafeUrl, isTrue);
      expect(updated.safetyScore, equals(90));
      expect(updated.isAnalyzing, isFalse);
      expect(item.isSafeUrl, isNull); // original unmodified
    });

    test('toScanRecord maps fields properly for a URL', () {
      final now = DateTime.now();
      final item = BatchScanItem(
        id: 'item_1',
        timestamp: now,
        rawValue: 'https://safe-domain.org',
        format: BarcodeType.url,
        isUrl: true,
        isSafeUrl: true,
      );

      final record = item.toScanRecord();
      expect(record.id, equals('item_1'));
      expect(record.timestamp, equals(now));
      expect(record.rawContent, equals('https://safe-domain.org'));
      expect(record.category, equals('url'));
      expect(record.safetyScore, equals(100));
      expect(record.metadata?['isBatch'], isTrue);
      expect(record.metadata?['isSafeUrl'], isTrue);
    });

    test('toScanRecord maps parsed smart payload categories properly', () {
      final item = BatchScanItem(
        id: 'item_wifi',
        timestamp: DateTime.now(),
        rawValue: 'WIFI:S:MyWifi;T:WPA;P:secret;;',
        format: BarcodeType.wifi,
        parsedPayload: const WifiPayload(
          rawContent: 'WIFI:S:MyWifi;T:WPA;P:secret;;',
          ssid: 'MyWifi',
          password: 'secret',
        ),
      );

      final record = item.toScanRecord();
      expect(record.category, equals('wifi'));
      expect(record.metadata?['payloadType'], equals('wifi'));
    });
  });
}
