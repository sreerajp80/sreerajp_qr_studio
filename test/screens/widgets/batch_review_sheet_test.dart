import 'package:material_ui/material_ui.dart';
import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/providers/batch_scan_provider.dart';
import 'package:sreerajp_qr_studio/screens/widgets/batch_review_sheet.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

Widget createTestWidget(BatchScanProvider provider) {
  return ChangeNotifierProvider<BatchScanProvider>.value(
    value: provider,
    child: const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en')],
      home: Scaffold(body: BatchReviewSheet()),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders empty state when batch has no items', (tester) async {
    final provider = BatchScanProvider();

    await tester.pumpWidget(createTestWidget(provider));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.inventory_2_outlined), findsOneWidget);
    expect(find.text('No codes in batch'), findsOneWidget);
    expect(find.text('Export Batch'), findsOneWidget);
  });

  testWidgets('renders item cards and deletes item when delete icon tapped', (
    tester,
  ) async {
    final provider = BatchScanProvider();
    await provider.addBarcode('PACKAGE-A-100', CodeContentType.product);
    await provider.addBarcode('PACKAGE-B-200', CodeContentType.product);

    await tester.pumpWidget(createTestWidget(provider));
    await tester.pumpAndSettle();

    expect(find.text('PACKAGE-A-100'), findsOneWidget);
    expect(find.text('PACKAGE-B-200'), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsNWidgets(2));

    // Tap delete on first item
    await tester.tap(find.byIcon(Icons.delete_outline).first);
    await tester.pumpAndSettle();

    expect(provider.count, equals(1));
    expect(find.text('PACKAGE-A-100'), findsOneWidget);
  });
}
