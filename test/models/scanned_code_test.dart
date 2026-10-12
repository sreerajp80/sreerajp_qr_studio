import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/scan_frame_result.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';

void main() {
  group('ScannedCode', () {
    test('defaults', () {
      const code = ScannedCode(rawValue: 'x');
      expect(code.format, CodeFormat.unknown);
      expect(code.type, CodeContentType.unknown);
      expect(code.corners, isEmpty);
      expect(code.displayValue, 'x');
    });

    test('equality and copyWith', () {
      const a = ScannedCode(
        rawValue: 'x',
        format: CodeFormat.qrCode,
        type: CodeContentType.text,
        corners: [Offset(1, 2), Offset(3, 4)],
      );
      const b = ScannedCode(
        rawValue: 'x',
        format: CodeFormat.qrCode,
        type: CodeContentType.text,
        corners: [Offset(1, 2), Offset(3, 4)],
      );
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      final moved = a.copyWith(corners: const [Offset(5, 6)]);
      expect(moved, isNot(a));
      expect(moved.rawValue, 'x');
    });

    test('toString does not reveal decoded content', () {
      const code = ScannedCode(
        rawValue: 'secret-token',
        format: CodeFormat.qrCode,
      );
      expect(code.toString(), isNot(contains('secret-token')));
    });
  });

  group('ScanFrameResult', () {
    test('equality', () {
      const a = ScanFrameResult(
        barcodes: [ScannedCode(rawValue: 'x')],
        size: Size(720, 1280),
      );
      const b = ScanFrameResult(
        barcodes: [ScannedCode(rawValue: 'x')],
        size: Size(720, 1280),
      );
      expect(a, b);
      expect(const ScanFrameResult().size, Size.zero);
    });
  });
}
