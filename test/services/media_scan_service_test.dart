import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/services/media_scan_service.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

void main() {
  group('PdfPageBarcode', () {
    test('instantiates correctly with page number and raw value', () {
      const pageBarcode = PdfPageBarcode(
        pageNumber: 3,
        rawValue: 'https://example.com/qr',
        format: CodeContentType.url,
      );

      expect(pageBarcode.pageNumber, equals(3));
      expect(pageBarcode.rawValue, equals('https://example.com/qr'));
      expect(pageBarcode.format, equals(CodeContentType.url));
    });
  });

  group('MediaScanResult', () {
    test('hasBarcodes returns false when empty', () {
      const result = MediaScanResult();
      expect(result.hasBarcodes, isFalse);
      expect(result.isPdf, isFalse);
      expect(result.errorMessage, isNull);
    });

    test('hasBarcodes returns true when pdfBarcodes is not empty', () {
      const result = MediaScanResult(
        isPdf: true,
        pdfBarcodes: [
          PdfPageBarcode(
            pageNumber: 1,
            rawValue: 'CODE128_TEST',
            format: CodeContentType.text,
          ),
        ],
      );

      expect(result.hasBarcodes, isTrue);
      expect(result.isPdf, isTrue);
      expect(result.pdfBarcodes.length, equals(1));
    });

    test('carries error message when parsing fails', () {
      const result = MediaScanResult(
        isPdf: true,
        errorMessage: AppMessage(
          AppMessageKey.mediaPdfPickFailed,
          args: {'error': 'Failed to parse PDF file.'},
        ),
      );

      expect(result.hasBarcodes, isFalse);
      expect(result.errorMessage?.key, AppMessageKey.mediaPdfPickFailed);
      expect(
        result.errorMessage?.args['error'],
        equals('Failed to parse PDF file.'),
      );
    });
  });
}
