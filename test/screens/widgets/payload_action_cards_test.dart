import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/parsed_payload.dart';
import 'package:sreerajp_qr_studio/screens/widgets/app_link_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/calendar_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/contact_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/email_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/geo_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/isbn_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/payment_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/phone_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/product_barcode_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/sms_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/totp_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/wifi_action_card.dart';
import 'package:sreerajp_qr_studio/services/payload_parser_service.dart';

import '../../helpers/accessibility_checks.dart';
import '../../helpers/test_app.dart';

/// One sample scan per smart-payload card, with the payload type the parser
/// must return for it.
const Map<String, Type> _samples = {
  'WIFI:T:WPA;S:HomeNet;P:secret123;;': WifiPayload,
  'BEGIN:VCARD\nVERSION:3.0\nFN:Asha Nair\nTEL:+919876543210\n'
          'EMAIL:asha@example.com\nEND:VCARD':
      ContactPayload,
  'geo:9.9312,76.2673': GeoPayload,
  'BEGIN:VEVENT\nSUMMARY:Team meeting\nDTSTART:20261020T100000\n'
          'DTEND:20261020T110000\nLOCATION:Kochi\nEND:VEVENT':
      CalendarPayload,
  'upi://pay?pa=shop@bank&pn=Corner Shop&cu=INR': PaymentPayload,
  'otpauth://totp/Example:asha@example.com?secret=JBSWY3DPEHPK3PXP'
          '&issuer=Example':
      TotpPayload,
  'mailto:asha@example.com?subject=Hello&body=Hi': EmailPayload,
  'tel:+919876543210': PhonePayload,
  'SMSTO:+919876543210:Hello there': SmsPayload,
  'market://details?id=com.example.app': AppLinkPayload,
  '9780306406157': IsbnPayload,
  '4006381333931': ProductBarcodePayload,
};

/// Builds the card the result screen shows for [payload].
Widget _cardFor(ParsedPayload payload) {
  return switch (payload) {
    WifiPayload() => WifiActionCard(payload: payload),
    ContactPayload() => ContactActionCard(payload: payload),
    GeoPayload() => GeoActionCard(payload: payload),
    CalendarPayload() => CalendarActionCard(payload: payload),
    PaymentPayload() => PaymentActionCard(payload: payload),
    TotpPayload() => TotpActionCard(payload: payload),
    EmailPayload() => EmailActionCard(payload: payload),
    PhonePayload() => PhoneActionCard(payload: payload),
    SmsPayload() => SmsActionCard(payload: payload),
    AppLinkPayload() => AppLinkActionCard(payload: payload),
    IsbnPayload() => IsbnActionCard(payload: payload),
    ProductBarcodePayload() => ProductBarcodeActionCard(payload: payload),
    _ => throw ArgumentError('No card for ${payload.runtimeType}'),
  };
}

void main() {
  final parser = PayloadParserService();

  for (final entry in _samples.entries) {
    final payload = parser.parse(entry.key);

    test('sample parses as ${entry.value}', () {
      expect(payload.runtimeType, entry.value);
    });

    for (final locale in appTestLocales) {
      testWidgets(
        '${entry.value} card renders with actions in ${locale.languageCode}',
        (tester) async {
          final card = _cardFor(payload);
          await tester.pumpWidget(
            buildTestApp(
              locale: locale,
              home: Scaffold(body: SingleChildScrollView(child: card)),
            ),
          );
          await tester.pump();

          expect(find.byWidget(card), findsOneWidget);
          expect(tester.takeException(), isNull);
          // Every card offers at least one action the user can tap.
          final buttons = find.byWidgetPredicate(
            (w) => w is ButtonStyleButton || w is IconButton,
          );
          expect(buttons, findsWidgets);
          expectAllIconButtonsHaveTooltips(tester);

          // Stop the TOTP card's countdown timer before the test ends.
          await tester.pumpWidget(const SizedBox());
        },
      );
    }
  }
}
