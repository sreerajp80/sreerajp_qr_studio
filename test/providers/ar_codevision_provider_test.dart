import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/providers/ar_codevision_provider.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/models/scan_frame_result.dart';

void main() {
  group('ArCodevisionProvider Unit Tests', () {
    late ArCodevisionProvider provider;

    setUp(() {
      provider = ArCodevisionProvider();
    });

    test('Initial mode defaults to Warehouse mode', () {
      expect(provider.hudMode, equals(ArHudMode.warehouse));
      expect(provider.targets, isEmpty);
      expect(provider.selectedCount, equals(0));
    });

    test('setHudMode updates active HUD mode', () {
      provider.setHudMode(ArHudMode.safety);
      expect(provider.hudMode, equals(ArHudMode.safety));
    });

    test('changing mode clears the selection', () {
      const capture = ScanFrameResult(
        barcodes: [ScannedCode(rawValue: 'item_1', type: CodeContentType.text)],
      );
      provider.processBarcodeCapture(capture);
      provider.toggleTargetSelection(provider.targets.first.id);
      expect(provider.selectedCount, 1);

      provider.setHudMode(ArHudMode.safety);

      expect(provider.hudMode, ArHudMode.safety);
      expect(provider.selectedCount, 0);
    });

    test('setting the same mode again changes nothing', () {
      const capture = ScanFrameResult(
        barcodes: [ScannedCode(rawValue: 'item_1', type: CodeContentType.text)],
      );
      provider.processBarcodeCapture(capture);
      provider.toggleTargetSelection(provider.targets.first.id);
      var notified = 0;
      provider.addListener(() => notified++);

      provider.setHudMode(ArHudMode.warehouse);

      expect(notified, 0);
      expect(provider.selectedCount, 1);
    });

    test('processBarcodeCapture tracks incoming barcodes', () {
      const capture = ScanFrameResult(
        barcodes: [
          ScannedCode(
            rawValue: 'https://example.com/test',
            type: CodeContentType.url,
          ),
          ScannedCode(rawValue: '8901234567890', type: CodeContentType.product),
        ],
      );

      provider.processBarcodeCapture(capture);

      expect(provider.targets.length, equals(2));
      expect(
        provider.targets.any((t) => t.rawValue == 'https://example.com/test'),
        isTrue,
      );
    });

    test('toggleTargetSelection and batch selection operations', () {
      const capture = ScanFrameResult(
        barcodes: [
          ScannedCode(rawValue: 'item_1', type: CodeContentType.text),
          ScannedCode(rawValue: 'item_2', type: CodeContentType.text),
        ],
      );

      provider.processBarcodeCapture(capture);
      expect(provider.targets.length, equals(2));

      final target1Id = provider.targets[0].id;
      provider.toggleTargetSelection(target1Id);

      expect(provider.selectedCount, equals(1));
      expect(provider.selectedTargetIds.contains(target1Id), isTrue);

      provider.selectAll();
      expect(provider.selectedCount, equals(2));

      provider.clearSelection();
      expect(provider.selectedCount, equals(0));
    });
  });
}
