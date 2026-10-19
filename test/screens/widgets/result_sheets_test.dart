import 'package:material_ui/material_ui.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/ar_code_target.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/dom_sandbox_result.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/providers/ar_codevision_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/screens/widgets/ar_action_sheet.dart';
import 'package:sreerajp_qr_studio/screens/widgets/dom_sandbox_preview_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/export_import_dialog.dart';
import 'package:sreerajp_qr_studio/screens/widgets/history_detail_sheet.dart';
import 'package:sreerajp_qr_studio/screens/widgets/multi_code_hint_banner.dart';
import 'package:sreerajp_qr_studio/screens/widgets/pdf_scan_results_sheet.dart';
import 'package:sreerajp_qr_studio/services/dom_sandbox_service.dart';
import 'package:sreerajp_qr_studio/services/history_database_service.dart';
import 'package:sreerajp_qr_studio/services/media_scan_service.dart';

import '../../helpers/accessibility_checks.dart';
import '../../helpers/test_app.dart';

/// In-memory history store that records what was saved.
class _FakeHistoryDatabaseService extends Fake
    implements HistoryDatabaseService {
  final List<ScanRecord> stored = [];

  @override
  Future<void> insertRecord(ScanRecord record) async => stored.add(record);

  @override
  Future<List<ScanRecord>> getRecords({
    String? category,
    bool? onlyFavorites,
    String? searchQuery,
  }) async => List.of(stored);
}

/// Opens [sheet] in a bottom sheet from a button, like the app does, so the
/// sheet's own `Navigator.pop` closes it.
Widget _sheetLauncher(Widget sheet) {
  return Scaffold(
    body: Builder(
      builder: (context) => Center(
        child: ElevatedButton(
          onPressed: () => showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (_) => sheet,
          ),
          child: const Text('open'),
        ),
      ),
    ),
  );
}

Future<void> _open(WidgetTester tester) async {
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

ScanRecord _record() => ScanRecord(
  id: 'r1',
  timestamp: DateTime(2026, 10, 1, 12),
  rawContent: 'https://example.com/menu',
  barcodeFormat: 'qrCode',
  category: 'url',
  notes: 'Cafe menu',
);

const _pdfBarcodes = [
  PdfPageBarcode(
    pageNumber: 1,
    rawValue: 'https://example.com/a',
    format: CodeContentType.url,
  ),
  PdfPageBarcode(
    pageNumber: 3,
    rawValue: 'Plain text code',
    format: CodeContentType.text,
  ),
];

ArCodeTarget _arTarget({required bool isUrl}) => ArCodeTarget(
  id: 't1',
  rawValue: isUrl ? 'https://example.com' : 'Shelf 4B',
  type: isUrl ? CodeContentType.url : CodeContentType.text,
  corners: const [Offset(0, 0), Offset(10, 0), Offset(10, 10), Offset(0, 10)],
  boundingBox: const Rect.fromLTWH(0, 0, 10, 10),
  isUrl: isUrl,
  safetyStatus: TargetSafetyStatus.safe,
  priceTag: '',
  formatName: const AppMessage(AppMessageKey.formatQrCode),
  isSelected: false,
  lastSeen: DateTime(2026, 10, 2),
);

/// A page preview made by the real service, with the network faked.
Future<DomSandboxResult> _domResult() {
  final client = MockClient((request) async {
    if (request.url.host == 'rdap.org') return http.Response('', 404);
    return http.Response(
      '<html><head><title>Cafe Menu</title>'
      '<meta name="description" content="Daily specials"></head>'
      '<body><h1>Menu</h1><p>Tea and coffee.</p>'
      '<script>alert(1)</script></body></html>',
      200,
      headers: {'content-type': 'text/html; charset=utf-8'},
    );
  });
  return DomSandboxService(httpClient: client)
      .analyzeAndRender('https://example.com/menu', activeProbing: true);
}

/// The AR action sheet over an empty camera view.
Widget _arApp(Locale locale, VoidCallback onClose, {required bool isUrl}) {
  return buildTestApp(
    locale: locale,
    providers: [ChangeNotifierProvider(create: (_) => ArCodevisionProvider())],
    home: Scaffold(
      body: Stack(
        children: [
          ArActionSheet(
            target: _arTarget(isUrl: isUrl),
            onClose: onClose,
          ),
        ],
      ),
    ),
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  for (final locale in appTestLocales) {
    final lang = locale.languageCode;
    final l10n = l10nFor(locale);

    group('in $lang', () {
      testWidgets('MultiCodeHintBanner shows the hint and dismisses', (
        tester,
      ) async {
        var dismissed = false;
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            home: Scaffold(
              body: Stack(
                children: [
                  MultiCodeHintBanner(onDismiss: () => dismissed = true),
                ],
              ),
            ),
          ),
        );

        expect(find.text(l10n.bodyMultiCodeDetected), findsOneWidget);
        expectAllIconButtonsHaveTooltips(tester);
        await tester.tap(find.byTooltip(l10n.tooltipMultiCodeDismiss));
        expect(dismissed, isTrue);
      });

      testWidgets('DomSandboxPreviewCard shows the page and opens inspect', (
        tester,
      ) async {
        final result = await tester.runAsync(_domResult);
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            home: Scaffold(
              body: SingleChildScrollView(
                child: DomSandboxPreviewCard(result: result!),
              ),
            ),
          ),
        );
        await tester.pump();

        expect(tester.takeException(), isNull);
        expect(result.fetchFailed, isFalse);
        expectAllIconButtonsHaveTooltips(tester);

        // A safe page starts folded; tap the address bar to unfold it.
        final unfold = find.byTooltip(l10n.tooltipSandboxShowPreview);
        if (unfold.evaluate().isNotEmpty) {
          await tester.tap(unfold);
          await tester.pumpAndSettle();
        }
        expect(find.textContaining('Cafe Menu'), findsWidgets);

        final inspect = find.text(l10n.actionDomInspect);
        await tester.ensureVisible(inspect);
        await tester.tap(inspect);
        await tester.pumpAndSettle();
        expect(find.text(l10n.titleDomInspect), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('HistoryDetailSheet saves edited notes and location', (
        tester,
      ) async {
        String? savedNotes;
        String? savedLocation;
        var saveCalls = 0;
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            home: _sheetLauncher(
              HistoryDetailSheet(
                record: _record(),
                onSave: (notes, location) {
                  saveCalls++;
                  savedNotes = notes;
                  savedLocation = location;
                },
              ),
            ),
          ),
        );
        await _open(tester);

        expect(find.text(l10n.titleHistoryDetail), findsOneWidget);
        expect(find.text('Cafe Menu'), findsNothing);
        expectAllIconButtonsHaveTooltips(tester);

        final fields = find.byType(TextField);
        await tester.enterText(fields.at(0), '  New note  ');
        await tester.enterText(fields.at(1), '');
        final save = find.text(l10n.actionHistorySaveChanges);
        await tester.ensureVisible(save);
        await tester.tap(save);
        await tester.pumpAndSettle();

        expect(saveCalls, 1);
        expect(savedNotes, 'New note');
        expect(savedLocation, isNull);
        expect(find.byType(HistoryDetailSheet), findsNothing);
      });

      testWidgets('PdfScanResultsSheet lists codes and selects one', (
        tester,
      ) async {
        PdfPageBarcode? selected;
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            providers: [
              ChangeNotifierProvider(
                create: (_) =>
                    HistoryProvider(dbService: _FakeHistoryDatabaseService()),
              ),
            ],
            home: _sheetLauncher(
              PdfScanResultsSheet(
                pdfBarcodes: _pdfBarcodes,
                onSelect: (item) => selected = item,
              ),
            ),
          ),
        );
        await _open(tester);

        expect(find.text(l10n.titlePdfResults(2)), findsOneWidget);
        expect(find.text('Plain text code'), findsOneWidget);
        expectAllIconButtonsHaveTooltips(tester);

        await tester.tap(find.text('Plain text code'));
        await tester.pumpAndSettle();
        expect(selected?.pageNumber, 3);
        expect(find.byType(PdfScanResultsSheet), findsNothing);
      });

      testWidgets('PdfScanResultsSheet saves all codes to history', (
        tester,
      ) async {
        final db = _FakeHistoryDatabaseService();
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            providers: [
              ChangeNotifierProvider(
                create: (_) => HistoryProvider(dbService: db),
              ),
            ],
            home: _sheetLauncher(
              PdfScanResultsSheet(pdfBarcodes: _pdfBarcodes, onSelect: (_) {}),
            ),
          ),
        );
        await _open(tester);

        await tester.tap(find.text(l10n.actionPdfSaveAll(2)));
        await tester.pumpAndSettle();
        expect(db.stored.map((r) => r.rawContent), [
          'https://example.com/a',
          'Plain text code',
        ]);
        expect(find.text(l10n.bodyPdfSavedToHistory(2)), findsOneWidget);
      });

      testWidgets('ExportImportDialog asks for missing input', (tester) async {
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            providers: [
              ChangeNotifierProvider(
                create: (_) =>
                    HistoryProvider(dbService: _FakeHistoryDatabaseService()),
              ),
            ],
            home: Scaffold(
              body: Builder(
                builder: (context) => Center(
                  child: ElevatedButton(
                    onPressed: () => showDialog<void>(
                      context: context,
                      builder: (_) => const ExportImportDialog(),
                    ),
                    child: const Text('open'),
                  ),
                ),
              ),
            ),
          ),
        );
        await _open(tester);

        expect(find.text(l10n.titleExportDialog), findsOneWidget);
        expect(tester.takeException(), isNull);
        expectAllIconButtonsHaveTooltips(tester);

        // Backup with no passphrase.
        final backup = find.text(l10n.actionExportCreateBackup);
        await tester.ensureVisible(backup);
        await tester.tap(backup);
        await tester.pump();
        expect(find.text(l10n.errorExportPassphraseRequired), findsOneWidget);
        // Clear that message, so the next one can show.
        ScaffoldMessenger.of(tester.element(find.byType(ExportImportDialog)))
            .removeCurrentSnackBar();
        await tester.pumpAndSettle();

        // Restore with empty fields.
        final restoreTab = find.text(l10n.tabRestoreBackup);
        await tester.ensureVisible(restoreTab);
        await tester.pumpAndSettle();
        await tester.tap(restoreTab);
        await tester.pumpAndSettle();
        expect(find.text(l10n.titleRestoreDialog), findsOneWidget);
        expectAllIconButtonsHaveTooltips(tester);
        final restore = find.text(l10n.actionRestore);
        await tester.ensureVisible(restore);
        await tester.tap(restore);
        await tester.pump();
        expect(find.text(l10n.errorRestoreFieldsRequired), findsOneWidget);

        // Close.
        final close = find.text(l10n.actionClose);
        await tester.tap(close);
        await tester.pumpAndSettle();
        expect(find.byType(ExportImportDialog), findsNothing);
      });

      testWidgets('ArActionSheet offers Open for a link', (tester) async {
        var closed = false;
        await tester.pumpWidget(
          _arApp(locale, () => closed = true, isUrl: true),
        );

        expect(tester.takeException(), isNull);
        expect(find.text(l10n.actionArCopy), findsOneWidget);
        expect(find.text(l10n.actionArOpenUrl), findsOneWidget);
        expect(find.text(l10n.actionArSelect), findsNothing);
        expectAllIconButtonsHaveTooltips(tester);

        await tester.tap(find.byTooltip(l10n.tooltipArCloseSheet));
        expect(closed, isTrue);
      });

      testWidgets('ArActionSheet selects a non-link target and closes', (
        tester,
      ) async {
        var closed = false;
        await tester.pumpWidget(
          _arApp(locale, () => closed = true, isUrl: false),
        );

        expect(find.text(l10n.actionArOpenUrl), findsNothing);
        await tester.tap(find.text(l10n.actionArSelect));
        await tester.pump();
        expect(closed, isTrue);
      });
    });
  }
}
