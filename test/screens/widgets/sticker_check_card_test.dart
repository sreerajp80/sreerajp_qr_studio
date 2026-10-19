import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/screens/widgets/sticker_check_card.dart';

import '../../helpers/accessibility_checks.dart';
import '../../helpers/test_app.dart';

void main() {
  for (final locale in appTestLocales) {
    final lang = locale.languageCode;
    final l10n = l10nFor(locale);

    group('StickerCheckCard in $lang', () {
      Future<void> pumpCard(WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            home: const Scaffold(
              body: SingleChildScrollView(child: StickerCheckCard()),
            ),
          ),
        );
        await tester.pump();
      }

      testWidgets('starts closed and shows no score', (tester) async {
        await pumpCard(tester);

        expect(tester.takeException(), isNull);
        expect(find.text(l10n.titleQuishingGuard), findsOneWidget);
        expect(find.text(l10n.titleStickerCheck), findsOneWidget);
        expect(find.text(l10n.bodyStickerCheckIntro), findsNothing);
        expect(find.byType(LinearProgressIndicator), findsNothing);
        expectAllIconButtonsHaveTooltips(tester);
      });

      testWidgets('opens and closes with the button', (tester) async {
        await pumpCard(tester);

        await tester.tap(find.byTooltip(l10n.tooltipStickerCheckExpand));
        await tester.pump();
        expect(find.text(l10n.bodyStickerCheckIntro), findsOneWidget);
        expect(find.text(l10n.bodyStickerCheckEdges), findsOneWidget);
        expect(find.text(l10n.bodyStickerCheckPayee), findsOneWidget);
        expect(find.text(l10n.bodyStickerCheckAsk), findsOneWidget);
        expectAllIconButtonsHaveTooltips(tester);

        await tester.tap(find.byTooltip(l10n.tooltipStickerCheckCollapse));
        await tester.pump();
        expect(find.text(l10n.bodyStickerCheckIntro), findsNothing);
      });
    });
  }
}
