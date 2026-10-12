import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ScanProvider', () {
    late ScanProvider provider;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      provider = ScanProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('initial state', () {
      test('scanResult is null', () {
        expect(provider.scanResult, isNull);
      });

      test('scanType is null', () {
        expect(provider.scanType, isNull);
      });

      test('isUrl is false', () {
        expect(provider.isUrl, false);
      });

      test('isSafeUrl is true', () {
        expect(provider.isSafeUrl, true);
      });

      test('isLoading is false', () {
        expect(provider.isLoading, false);
      });

      test('safetyChecks is empty', () {
        expect(provider.safetyChecks, isEmpty);
      });

      test('hasNetworkError is false', () {
        expect(provider.hasNetworkError, false);
      });

      test('activeProbingEnabled defaults to false', () {
        expect(provider.activeProbingEnabled, false);
      });
    });

    group('setScanResult – URL detection', () {
      test('stores result and type', () {
        provider.setScanResult('Hello', CodeContentType.text);
        expect(provider.scanResult, 'Hello');
        expect(provider.scanType, CodeContentType.text);
      });

      test('detects https URL', () {
        provider.setScanResult('https://example.com', CodeContentType.url);
        expect(provider.isUrl, true);
      });

      test('detects http URL', () {
        provider.setScanResult('http://example.com/path', CodeContentType.url);
        expect(provider.isUrl, true);
      });

      test('detects URL with query string', () {
        provider.setScanResult(
          'https://example.com/page?q=1&lang=en',
          CodeContentType.url,
        );
        expect(provider.isUrl, true);
      });

      test('detects URL with path and fragment', () {
        provider.setScanResult(
          'https://example.com/docs#section',
          CodeContentType.url,
        );
        expect(provider.isUrl, true);
      });

      test('does not flag plain text as URL', () {
        provider.setScanResult('Just some text', CodeContentType.text);
        expect(provider.isUrl, false);
      });

      test('does not flag bare domain without scheme as URL', () {
        provider.setScanResult('example.com', CodeContentType.text);
        expect(provider.isUrl, false);
      });

      test('does not flag email address as URL', () {
        provider.setScanResult('user@example.com', CodeContentType.email);
        expect(provider.isUrl, false);
      });

      test('does not flag WiFi credential string as URL', () {
        provider.setScanResult(
          'WIFI:T:WPA;S:MyNetwork;P:password;;',
          CodeContentType.wifi,
        );
        expect(provider.isUrl, false);
      });

      test('notifies listeners on change', () {
        var notified = false;
        provider.addListener(() => notified = true);
        provider.setScanResult('test', CodeContentType.text);
        expect(notified, true);
      });
    });

    group('clearScan', () {
      setUp(() {
        provider.setScanResult('https://example.com', CodeContentType.url);
      });

      test('clears scanResult', () {
        provider.clearScan();
        expect(provider.scanResult, isNull);
      });

      test('clears scanType', () {
        provider.clearScan();
        expect(provider.scanType, isNull);
      });

      test('resets isUrl to false', () {
        provider.clearScan();
        expect(provider.isUrl, false);
      });

      test('resets isSafeUrl to true', () {
        provider.clearScan();
        expect(provider.isSafeUrl, true);
      });

      test('resets isLoading to false', () {
        provider.clearScan();
        expect(provider.isLoading, false);
      });

      test('clears safetyChecks', () {
        provider.clearScan();
        expect(provider.safetyChecks, isEmpty);
      });

      test('notifies listeners', () {
        var notified = false;
        provider.addListener(() => notified = true);
        provider.clearScan();
        expect(notified, true);
      });
    });

    group('feedback settings', () {
      test('defaults to enabled for vibration, sound, and animation', () {
        expect(provider.isVibrationEnabled, true);
        expect(provider.isSoundEnabled, true);
        expect(provider.isAnimationEnabled, true);
      });

      test(
        'setAnimationEnabled updates value and notifies listeners',
        () async {
          var notified = false;
          provider.addListener(() => notified = true);

          await provider.setAnimationEnabled(false);
          expect(provider.isAnimationEnabled, false);
          expect(notified, true);

          await provider.setAnimationEnabled(true);
          expect(provider.isAnimationEnabled, true);
        },
      );

      test(
        'setVibrationEnabled updates value and notifies listeners',
        () async {
          var notified = false;
          provider.addListener(() => notified = true);

          await provider.setVibrationEnabled(false);
          expect(provider.isVibrationEnabled, false);
          expect(notified, true);
        },
      );

      test('setSoundEnabled updates value and notifies listeners', () async {
        var notified = false;
        provider.addListener(() => notified = true);

        await provider.setSoundEnabled(false);
        expect(provider.isSoundEnabled, false);
        expect(notified, true);
      });
    });

    group('createScanRecord source', () {
      test('adds the screen bubble source to metadata', () {
        provider.setScanResult('Hello', CodeContentType.text);
        final record = provider.createScanRecord(
          source: ScanRecord.sourceScreenBubble,
        );
        expect(record, isNotNull);
        expect(record!.metadata?['source'], ScanRecord.sourceScreenBubble);
        expect(record.isFromScreen, isTrue);
      });

      test('leaves source out for camera scans', () {
        provider.setScanResult('Hello', CodeContentType.text);
        final record = provider.createScanRecord();
        expect(record!.metadata?.containsKey('source'), isFalse);
        expect(record.isFromScreen, isFalse);
      });
    });
  });
}
