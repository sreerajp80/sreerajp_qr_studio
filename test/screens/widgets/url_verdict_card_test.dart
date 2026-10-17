import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/widgets/url_verdict_card.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      ...GlobalMaterialLocalizations.delegates,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );

  testWidgets('Loading state shows the checking text only', (tester) async {
    await tester.pumpWidget(
      wrap(
        const UrlVerdictCard(
          isLoading: true,
          failedCount: 0,
          passedCount: 0,
          ranCount: 0,
          activeProbing: false,
        ),
      ),
    );

    expect(find.text('Checking link safety…'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('See details'), findsNothing);
  });

  testWidgets('No issues state', (tester) async {
    await tester.pumpWidget(
      wrap(
        const UrlVerdictCard(
          isLoading: false,
          failedCount: 0,
          passedCount: 4,
          ranCount: 4,
          activeProbing: false,
        ),
      ),
    );

    expect(find.text('No issues found'), findsOneWidget);
    expect(find.text('4 of 4 checks passed · Private mode'), findsOneWidget);
  });

  testWidgets('Issues state names the first failed check', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrap(
        UrlVerdictCard(
          isLoading: false,
          failedCount: 2,
          passedCount: 2,
          ranCount: 4,
          firstFailedName: 'URL Shortener Check',
          activeProbing: true,
          onSeeDetails: () => tapped = true,
        ),
      ),
    );

    expect(find.text('2 issues found'), findsOneWidget);
    expect(find.text('URL Shortener Check'), findsOneWidget);
    expect(find.text('2 of 4 checks passed · Active probing'), findsOneWidget);

    await tester.tap(find.text('See details'));
    expect(tapped, isTrue);
  });
}
