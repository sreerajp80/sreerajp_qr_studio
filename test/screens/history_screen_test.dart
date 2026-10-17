import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/models/app_exception.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/screens/history_screen.dart';
import 'package:sreerajp_qr_studio/screens/widgets/history_card.dart';
import 'package:sreerajp_qr_studio/services/history_database_service.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/test_app.dart';

/// In-memory stand-in for the encrypted SQLite history database.
class _FakeHistoryDatabaseService extends Fake
    implements HistoryDatabaseService {
  final List<ScanRecord> stored;

  _FakeHistoryDatabaseService(this.stored);

  @override
  Future<List<ScanRecord>> getRecords({
    String? category,
    bool? onlyFavorites,
    String? searchQuery,
  }) async {
    return stored.where((r) {
      if (category == 'favorites' && !r.isFavorite) return false;
      if (category != null &&
          category != 'all' &&
          category != 'favorites' &&
          r.category.toLowerCase() != category) {
        return false;
      }
      if (onlyFavorites == true && !r.isFavorite) return false;
      final query = searchQuery?.toLowerCase() ?? '';
      if (query.isNotEmpty && !r.rawContent.toLowerCase().contains(query)) {
        return false;
      }
      return true;
    }).toList();
  }
}

/// Fails the first load (as when the history key cannot be read), then works.
class _FailingThenWorkingHistoryDatabaseService
    extends _FakeHistoryDatabaseService {
  _FailingThenWorkingHistoryDatabaseService(super.stored);

  int calls = 0;

  @override
  Future<List<ScanRecord>> getRecords({
    String? category,
    bool? onlyFavorites,
    String? searchQuery,
  }) {
    calls++;
    if (calls == 1) {
      throw const StorageException('history key unavailable');
    }
    return super.getRecords(
      category: category,
      onlyFavorites: onlyFavorites,
      searchQuery: searchQuery,
    );
  }
}

ScanRecord _record(
  String id,
  String content,
  String category, {
  bool favorite = false,
}) => ScanRecord(
  id: id,
  timestamp: DateTime(2026, 10, 1, 12),
  rawContent: content,
  barcodeFormat: 'qrCode',
  category: category,
  isFavorite: favorite,
);

void main() {
  final sampleRecords = [
    _record('1', 'https://example.com', 'url', favorite: true),
    _record('2', 'WIFI:S:HomeNet;T:WPA;P:secret;;', 'wifi'),
    _record('3', 'Plain note text', 'text'),
  ];

  Widget app(List<ScanRecord> records, {Locale locale = const Locale('en')}) {
    return buildTestApp(
      locale: locale,
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              HistoryProvider(dbService: _FakeHistoryDatabaseService(records)),
        ),
      ],
      home: const HistoryScreen(),
    );
  }

  testWidgets('shows the empty state when there is no history', (tester) async {
    final l10n = l10nFor(const Locale('en'));
    await tester.pumpWidget(app(const []));
    await tester.pumpAndSettle();

    expect(find.text(l10n.emptyHistoryTitle), findsOneWidget);
    expect(find.byType(HistoryCard), findsNothing);
  });

  for (final locale in appTestLocales) {
    testWidgets(
      'lists records with a localized count in ${locale.languageCode}',
      (tester) async {
        final l10n = l10nFor(locale);
        await tester.pumpWidget(app(sampleRecords, locale: locale));
        await tester.pumpAndSettle();

        expect(find.byType(HistoryCard), findsNWidgets(3));
        expect(find.text(l10n.bodyHistoryRecordCount(3)), findsOneWidget);
        expect(tester.takeException(), isNull);
        expectAllIconButtonsHaveTooltips(tester);
      },
    );
  }

  testWidgets('search box filters the list', (tester) async {
    final l10n = l10nFor(const Locale('en'));
    await tester.pumpWidget(app(sampleRecords));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'example');
    await tester.pumpAndSettle();

    expect(find.byType(HistoryCard), findsOneWidget);
    expect(find.text(l10n.bodyHistoryRecordCount(1)), findsOneWidget);
  });

  testWidgets('category chips change the filter', (tester) async {
    final l10n = l10nFor(const Locale('en'));
    await tester.pumpWidget(app(sampleRecords));
    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(FilterChip, l10n.labelHistoryFilterWifi),
    );
    await tester.pumpAndSettle();
    expect(find.byType(HistoryCard), findsOneWidget);

    await tester.tap(
      find.widgetWithText(FilterChip, l10n.labelHistoryFilterStarred),
    );
    await tester.pumpAndSettle();
    expect(find.byType(HistoryCard), findsOneWidget);

    await tester.tap(
      find.widgetWithText(FilterChip, l10n.labelHistoryFilterAll),
    );
    await tester.pumpAndSettle();
    expect(find.byType(HistoryCard), findsNWidgets(3));
  });

  testWidgets('a search with no match shows the no-matches message', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('en'));
    await tester.pumpWidget(app(sampleRecords));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'zzz-nothing');
    await tester.pumpAndSettle();

    expect(find.byType(HistoryCard), findsNothing);
    expect(
      find.text(l10n.emptyHistoryNoMatches('zzz-nothing')),
      findsOneWidget,
    );
  });

  for (final locale in appTestLocales) {
    testWidgets(
      'a load error shows a message and Try again in ${locale.languageCode}',
      (tester) async {
        final l10n = l10nFor(locale);
        final db = _FailingThenWorkingHistoryDatabaseService(sampleRecords);
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            providers: [
              ChangeNotifierProvider(
                create: (_) => HistoryProvider(dbService: db),
              ),
            ],
            home: const HistoryScreen(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text(l10n.errorHistoryLoadFailed), findsOneWidget);
        expect(find.text(l10n.emptyHistoryTitle), findsNothing);
        expect(tester.takeException(), isNull);

        await tester.tap(find.text(l10n.actionTryAgain));
        await tester.pumpAndSettle();
        expect(find.text(l10n.errorHistoryLoadFailed), findsNothing);
        expect(find.byType(HistoryCard), findsNWidgets(3));
      },
    );
  }
}
