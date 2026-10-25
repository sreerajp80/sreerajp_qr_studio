import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

import '../../helpers/test_app.dart';

void main() {
  for (final locale in appTestLocales) {
    testWidgets('help page shows title, intro, sections and tip in '
        '${locale.languageCode}', (tester) async {
      final l10n = l10nFor(locale);
      await tester.pumpWidget(
        buildTestApp(
          locale: locale,
          home: HelpGuidePage(
            title: l10n.titleHelpSmartPayloads,
            intro: l10n.helpGuideSmartPayloadsIntro,
            sections: [
              HelpSection(
                icon: Icons.wifi,
                title: l10n.helpGuideSmartPayloadsWifiTitle,
                bullets: [
                  l10n.helpGuideSmartPayloadsWifiBullet1,
                  l10n.helpGuideSmartPayloadsWifiBullet2,
                ],
              ),
            ],
            tip: l10n.helpGuideSmartPayloadsTip,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(l10n.titleHelpSmartPayloads), findsOneWidget);
      expect(find.text(l10n.helpGuideSmartPayloadsIntro), findsOneWidget);
      expect(find.text(l10n.helpGuideSmartPayloadsWifiTitle), findsOneWidget);
      expect(find.text(l10n.helpGuideSmartPayloadsWifiBullet1), findsOneWidget);
      expect(find.text(l10n.helpGuideSmartPayloadsWifiBullet2), findsOneWidget);
      expect(find.byType(HelpBullet), findsNWidgets(2));
      expect(find.byType(HelpTip), findsOneWidget);
      expect(find.byIcon(Icons.wifi), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('building blocks render on their own', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        home: const Scaffold(
          body: Column(
            children: [
              HelpIntro('Intro'),
              HelpBullet('Bullet'),
              HelpTip('Tip'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Intro'), findsOneWidget);
    expect(find.text('Bullet'), findsOneWidget);
    expect(find.text('Tip'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
