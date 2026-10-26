import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/providers/multi_code_selection_provider.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/models/scan_frame_result.dart';

void main() {
  group('MultiCodeSelectionProvider Unit Tests', () {
    late MultiCodeSelectionProvider provider;

    setUp(() {
      provider = MultiCodeSelectionProvider();
    });

    test('initial state is correct', () {
      expect(provider.enabled, isTrue);
      expect(provider.isMultiCodeActive, isFalse);
      expect(provider.visibleBarcodes, isEmpty);
      expect(provider.selectedBarcodeId, isNull);
      expect(provider.visibleCount, 0);
    });

    test('setEnabled toggles state and resets on disable', () {
      const capture = ScanFrameResult(
        barcodes: [
          ScannedCode(rawValue: 'code1', format: CodeFormat.qrCode),
          ScannedCode(rawValue: 'code2', format: CodeFormat.qrCode),
        ],
      );

      provider.processCapture(
        capture: capture,
        screenSize: const Size(400, 800),
        frameSize: const Size(1080, 1920),
      );

      expect(provider.isMultiCodeActive, isTrue);

      provider.setEnabled(false);
      expect(provider.enabled, isFalse);
      expect(provider.isMultiCodeActive, isFalse);
      expect(provider.visibleBarcodes, isEmpty);
    });

    test('processCapture activates multi-code mode when multiple barcodes are detected', () {
      const capture = ScanFrameResult(
        barcodes: [
          ScannedCode(
            rawValue: 'https://example.com/1',
            format: CodeFormat.qrCode,
          ),
          ScannedCode(
            rawValue: 'https://example.com/2',
            format: CodeFormat.qrCode,
          ),
        ],
      );

      provider.processCapture(
        capture: capture,
        screenSize: const Size(400, 800),
        frameSize: const Size(1080, 1920),
      );

      expect(provider.isMultiCodeActive, isTrue);
      expect(provider.visibleCount, 2);
      expect(provider.visibleBarcodes[0].rawValue, 'https://example.com/1');
      expect(provider.visibleBarcodes[1].rawValue, 'https://example.com/2');
    });

    test('processCapture does not activate multi-code when single barcode is seen initially', () {
      const capture = ScanFrameResult(
        barcodes: [
          ScannedCode(rawValue: 'single_code', format: CodeFormat.qrCode),
        ],
      );

      provider.processCapture(
        capture: capture,
        screenSize: const Size(400, 800),
        frameSize: const Size(1080, 1920),
      );

      expect(provider.isMultiCodeActive, isFalse);
      expect(provider.visibleBarcodes, isEmpty);
    });

    test('selectBarcode and dismiss work correctly', () {
      const capture = ScanFrameResult(
        barcodes: [
          ScannedCode(rawValue: 'codeA', format: CodeFormat.qrCode),
          ScannedCode(rawValue: 'codeB', format: CodeFormat.qrCode),
        ],
      );

      provider.processCapture(
        capture: capture,
        screenSize: const Size(400, 800),
        frameSize: const Size(1080, 1920),
      );

      final firstId = provider.visibleBarcodes.first.id;
      provider.selectBarcode(firstId);
      expect(provider.selectedBarcodeId, firstId);

      provider.dismiss();
      expect(provider.isMultiCodeActive, isFalse);
      expect(provider.visibleBarcodes, isEmpty);
      expect(provider.selectedBarcodeId, isNull);
    });
  });

  group('MultiCodeSelectionProvider stale box cleanup', () {
    const twoCodes = ScanFrameResult(
      barcodes: [
        ScannedCode(rawValue: 'codeA', format: CodeFormat.qrCode),
        ScannedCode(rawValue: 'codeB', format: CodeFormat.qrCode),
      ],
    );

    late MultiCodeSelectionProvider provider;

    setUp(() {
      provider = MultiCodeSelectionProvider(
        staleAfter: const Duration(milliseconds: 60),
        cleanupInterval: const Duration(milliseconds: 10),
      );
    });

    tearDown(() => provider.dispose());

    void showTwoCodes() {
      provider.processCapture(
        capture: twoCodes,
        screenSize: const Size(400, 800),
        frameSize: const Size(1080, 1920),
      );
    }

    test('boxes clear on their own after the codes stop arriving', () async {
      showTwoCodes();
      expect(provider.isMultiCodeActive, isTrue);
      expect(provider.visibleCount, 2);

      // No more frames arrive, as when the camera points away from the codes.
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(provider.isMultiCodeActive, isFalse);
      expect(provider.visibleBarcodes, isEmpty);
    });

    test('boxes stay while the codes keep arriving', () async {
      for (var i = 0; i < 6; i++) {
        showTwoCodes();
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }

      expect(provider.isMultiCodeActive, isTrue);
      expect(provider.visibleCount, 2);
    });

    test('cleanup notifies listeners only when something changes', () async {
      showTwoCodes();
      var notifications = 0;
      provider.addListener(() => notifications++);

      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(notifications, 1);
    });

    test('reset stops the cleanup timer', () async {
      showTwoCodes();
      provider.reset();
      var notifications = 0;
      provider.addListener(() => notifications++);

      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(notifications, 0);
    });

    test('dismiss stops the cleanup timer', () async {
      showTwoCodes();
      provider.dismiss();
      var notifications = 0;
      provider.addListener(() => notifications++);

      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(notifications, 0);
    });
  });
}
