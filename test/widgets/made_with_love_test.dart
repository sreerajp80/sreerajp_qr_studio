import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/widgets/made_with_love.dart';

void main() {
  testWidgets(
    'MadeWithLove renders vector heart icon and accessible semantics',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: MadeWithLove()),
        ),
      );
      await tester.pump();

      // Verify favorite heart icon is present with the exact red color
      final iconFinder = find.byIcon(Icons.favorite);
      expect(iconFinder, findsOneWidget);
      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, const Color(0xFFE53935));

      // Verify Semantics label
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label != null &&
            widget.properties.label!.contains('Made with love from India'),
      );
      expect(semanticsFinder, findsOneWidget);
    },
  );
}
