import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class SmartPayloadsHelpScreen extends StatelessWidget {
  const SmartPayloadsHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
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
        HelpSection(
          icon: Icons.payments_outlined,
          title: l10n.helpGuideSmartPayloadsPaymentsTitle,
          bullets: [
            l10n.helpGuideSmartPayloadsPaymentsBullet1,
            l10n.helpGuideSmartPayloadsPaymentsBullet2,
            l10n.helpGuideSmartPayloadsPaymentsBullet3,
            l10n.helpGuideSmartPayloadsPaymentsBullet4,
          ],
        ),
        HelpSection(
          icon: Icons.password,
          title: l10n.helpGuideSmartPayloadsTotpTitle,
          bullets: [
            l10n.helpGuideSmartPayloadsTotpBullet1,
            l10n.helpGuideSmartPayloadsTotpBullet2,
            l10n.helpGuideSmartPayloadsTotpBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.contact_page_outlined,
          title: l10n.helpGuideSmartPayloadsContactsTitle,
          bullets: [
            l10n.helpGuideSmartPayloadsContactsBullet1,
            l10n.helpGuideSmartPayloadsContactsBullet2,
          ],
        ),
        HelpSection(
          icon: Icons.apps_outlined,
          title: l10n.helpGuideSmartPayloadsOtherTitle,
          bullets: [
            l10n.helpGuideSmartPayloadsOtherBullet1,
            l10n.helpGuideSmartPayloadsOtherBullet2,
            l10n.helpGuideSmartPayloadsOtherBullet3,
            l10n.helpGuideSmartPayloadsOtherBullet4,
            l10n.helpGuideSmartPayloadsOtherBullet5,
            l10n.helpGuideSmartPayloadsOtherBullet6,
          ],
        ),
      ],
      tip: l10n.helpGuideSmartPayloadsTip,
    );
  }
}
