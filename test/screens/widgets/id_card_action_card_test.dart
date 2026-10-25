import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/models/parsed_payload.dart';
import 'package:sreerajp_qr_studio/screens/widgets/id_card_action_card.dart';
import 'package:sreerajp_qr_studio/services/payload_parser_service.dart';

import '../../helpers/accessibility_checks.dart';
import '../../helpers/id_card_samples.dart';
import '../../helpers/test_app.dart';

void main() {
  final payload =
      PayloadParserService().parse(kSampleUsIdCard) as IdCardPayload;

  test('maskNumber keeps only the last 4 characters', () {
    expect(IdCardActionCard.maskNumber('D1234562'), '••••4562');
    expect(IdCardActionCard.maskNumber('123'), '•••');
    expect(IdCardActionCard.maskNumber(''), '');
  });

  for (final locale in appTestLocales) {
    testWidgets('shows the fields and masks the number in '
        '${locale.languageCode}', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          locale: locale,
          home: Scaffold(
            body: SingleChildScrollView(
              child: IdCardActionCard(payload: payload),
            ),
          ),
        ),
      );
      await tester.pump();
      final l10n = l10nFor(locale);

      expect(find.text(l10n.titleIdCard), findsOneWidget);
      expect(find.text('JANE Q SAMPLE'), findsOneWidget);
      expect(find.text(l10n.bodyIdCardNotSaved), findsOneWidget);
      expect(find.text('••••4562'), findsOneWidget);
      expect(find.text('D1234562'), findsNothing);
      expectAllIconButtonsHaveTooltips(tester);

      await tester.tap(find.text(l10n.actionIdCardShowNumber));
      await tester.pump();
      expect(find.text('D1234562'), findsOneWidget);
      expect(find.text(l10n.actionIdCardHideNumber), findsOneWidget);

      await tester.tap(find.text(l10n.actionIdCardHideNumber));
      await tester.pump();
      expect(find.text('••••4562'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('a card with no number has no Show button', (tester) async {
    const empty = IdCardPayload(rawContent: '@', lastName: 'ONLY');
    await tester.pumpWidget(
      buildTestApp(
        home: const Scaffold(body: IdCardActionCard(payload: empty)),
      ),
    );
    await tester.pump();
    final l10n = l10nFor(const Locale('en'));

    expect(find.text('ONLY'), findsOneWidget);
    expect(find.text(l10n.actionIdCardShowNumber), findsNothing);
  });
}
