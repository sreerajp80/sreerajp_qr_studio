import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/history_report_labels.dart';
import 'package:sreerajp_qr_studio/models/safety_check_result.dart';
import 'package:sreerajp_qr_studio/providers/batch_scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/services/url_safety_service.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

class MockUrlSafetyService extends UrlSafetyService {
  final bool returnSafe;
  MockUrlSafetyService({this.returnSafe = true});

  @override
  Future<List<SafetyCheckResult>> runAllChecks(String url) async {
    return [
      SafetyCheckResult(
        checkName: const AppMessage(AppMessageKey.checkNameHttps),
        passed: returnSafe,
        message: const AppMessage(AppMessageKey.sslValid),
      ),
    ];
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const labels = HistoryReportLabels(
    reportHeading: 'Test Report',
    reportTitle: 'Scan Report',
    exportDateLabel: 'Date',
    totalScansLabel: 'Total',
    scanNumberLabel: 'No.',
    idLabel: 'ID',
    timestampLabel: 'Time',
    formatLabel: 'Format',
    categoryLabel: 'Category',
    safetyScoreLabel: 'Score',
    starredLabel: 'Favorite',
    starredYes: 'Yes',
    starredNo: 'No',
    locationLabel: 'Location',
    notesLabel: 'Notes',
    contentLabel: 'Content',
    columnDateTime: 'Date/Time',
    columnFormat: 'Format',
    columnCategory: 'Category',
    columnSafety: 'Safety',
    columnContent: 'Content',
    columnNotes: 'Notes',
  );

  group('BatchScanProvider Tests', () {
    test('toggles batch mode state correctly', () {
      final provider = BatchScanProvider();
      expect(provider.isBatchMode, isFalse);

      provider.toggleBatchMode();
      expect(provider.isBatchMode, isTrue);

      provider.toggleBatchMode(false);
      expect(provider.isBatchMode, isFalse);
    });

    test('adds non-URL barcode into batch queue', () async {
      final provider = BatchScanProvider();

      final item = await provider.addBarcode(
        'ITEM-001',
        CodeContentType.product,
      );
      expect(item, isNotNull);
      expect(provider.count, equals(1));
      expect(provider.items.first.rawValue, equals('ITEM-001'));
      expect(provider.items.first.isUrl, isFalse);
    });

    test('enforces duplicate prevention when enabled', () async {
      final provider = BatchScanProvider();
      provider.setPreventDuplicates(true);

      final first = await provider.addBarcode('ITEM-999', CodeContentType.text);
      expect(first, isNotNull);
      expect(provider.count, equals(1));

      // Attempt immediate duplicate
      final second = await provider.addBarcode(
        'ITEM-999',
        CodeContentType.text,
      );
      expect(second, isNull);
      expect(provider.count, equals(1));
    });

    test(
      'executes background 6-layer URL safety and updates item state',
      () async {
        final mockSafety = MockUrlSafetyService();
        final provider = BatchScanProvider(urlSafetyService: mockSafety);

        final item = await provider.addBarcode(
          'https://safe-link.com',
          CodeContentType.url,
        );
        expect(item, isNotNull);
        expect(item!.isUrl, isTrue);

        // Wait a short tick for async URL safety check to finish
        await Future.delayed(const Duration(milliseconds: 50));

        expect(provider.items.first.isAnalyzing, isFalse);
        expect(provider.items.first.isSafeUrl, isTrue);
        expect(provider.items.first.safetyScore, equals(100));
        expect(provider.totalUrls, equals(1));
        expect(provider.safeUrlsCount, equals(1));
        expect(provider.suspiciousUrlsCount, equals(0));
      },
    );

    test('removes individual item and clears batch', () async {
      final provider = BatchScanProvider();
      await provider.addBarcode('A', CodeContentType.text);
      await provider.addBarcode('B', CodeContentType.text);
      expect(provider.count, equals(2));

      final firstId = provider.items.first.id;
      provider.removeItem(firstId);
      expect(provider.count, equals(1));
      expect(provider.items.first.rawValue, equals('A'));

      provider.clearBatch();
      expect(provider.count, equals(0));
      expect(provider.items, isEmpty);
    });

    test('exports batch records to CSV and JSON formats', () async {
      final provider = BatchScanProvider();
      await provider.addBarcode('BOX-123', CodeContentType.product);
      await provider.addBarcode('BOX-456', CodeContentType.product);

      final csvResult = await provider.exportBatch(ExportFormat.csv, labels);
      expect(csvResult, isA<String>());
      expect(csvResult, contains('BOX-123'));
      expect(csvResult, contains('BOX-456'));

      final jsonResult = await provider.exportBatch(ExportFormat.json, labels);
      expect(jsonResult, isA<String>());
      expect(jsonResult, contains('"totalRecords": 2'));
    });
  });
}
