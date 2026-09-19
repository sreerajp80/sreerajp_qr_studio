import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sreeraj_qr_reader/providers/multi_code_selection_provider.dart';

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
      const capture = BarcodeCapture(
        barcodes: [
          Barcode(rawValue: 'code1', format: BarcodeFormat.qrCode),
          Barcode(rawValue: 'code2', format: BarcodeFormat.qrCode),
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

    test(
      'processCapture activates multi-code mode when multiple barcodes are detected',
      () {
        const capture = BarcodeCapture(
          barcodes: [
            Barcode(
              rawValue: 'https://example.com/1',
              format: BarcodeFormat.qrCode,
            ),
            Barcode(
              rawValue: 'https://example.com/2',
              format: BarcodeFormat.qrCode,
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
      },
    );

    test(
      'processCapture does not activate multi-code when single barcode is seen initially',
      () {
        const capture = BarcodeCapture(
          barcodes: [
            Barcode(rawValue: 'single_code', format: BarcodeFormat.qrCode),
          ],
        );

        provider.processCapture(
          capture: capture,
          screenSize: const Size(400, 800),
          frameSize: const Size(1080, 1920),
        );

        expect(provider.isMultiCodeActive, isFalse);
        expect(provider.visibleBarcodes, isEmpty);
      },
    );

    test('selectBarcode and dismiss work correctly', () {
      const capture = BarcodeCapture(
        barcodes: [
          Barcode(rawValue: 'codeA', format: BarcodeFormat.qrCode),
          Barcode(rawValue: 'codeB', format: BarcodeFormat.qrCode),
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
}
