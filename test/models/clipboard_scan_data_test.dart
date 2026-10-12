import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/clipboard_scan_data.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

void main() {
  group('ClipboardScanData', () {
    test('constructs with valid properties', () {
      const data = ClipboardScanData(
        type: ClipboardContentType.url,
        content: 'https://example.com',
        barcodeType: CodeContentType.url,
        preview: 'https://example.com',
      );

      expect(data.type, equals(ClipboardContentType.url));
      expect(data.content, equals('https://example.com'));
      expect(data.barcodeType, equals(CodeContentType.url));
      expect(data.preview, equals('https://example.com'));
    });

    test('implements value equality and hashCode', () {
      const data1 = ClipboardScanData(
        type: ClipboardContentType.barcodePayload,
        content: 'WIFI:S:Home;T:WPA;P:secret;;',
        barcodeType: CodeContentType.wifi,
        preview: 'WIFI:S:Home...',
      );

      const data2 = ClipboardScanData(
        type: ClipboardContentType.barcodePayload,
        content: 'WIFI:S:Home;T:WPA;P:secret;;',
        barcodeType: CodeContentType.wifi,
        preview: 'WIFI:S:Home...',
      );

      const data3 = ClipboardScanData(
        type: ClipboardContentType.image,
        content: '/path/to/image.png',
        barcodeType: CodeContentType.unknown,
        preview: 'Image',
      );

      expect(data1, equals(data2));
      expect(data1.hashCode, equals(data2.hashCode));
      expect(data1, isNot(equals(data3)));
    });

    test('toString includes key attributes', () {
      const data = ClipboardScanData(
        type: ClipboardContentType.text,
        content: 'Hello World',
        barcodeType: CodeContentType.text,
        preview: 'Hello World',
      );

      expect(data.toString(), contains('type: ClipboardContentType.text'));
      expect(data.toString(), contains('preview: Hello World'));
    });

    test('ClipboardContentType enum contains all expected variants', () {
      expect(ClipboardContentType.values, contains(ClipboardContentType.url));
      expect(
        ClipboardContentType.values,
        contains(ClipboardContentType.barcodePayload),
      );
      expect(ClipboardContentType.values, contains(ClipboardContentType.image));
      expect(ClipboardContentType.values, contains(ClipboardContentType.text));
    });
  });
}
