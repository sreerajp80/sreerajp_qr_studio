import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class HiddenCodesHelpScreen extends StatelessWidget {
  const HiddenCodesHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpHiddenCodes,
      intro: l10n.helpGuideHiddenIntro,
      sections: [
        HelpSection(
          icon: Icons.enhanced_encryption_outlined,
          title: l10n.helpGuideHiddenStegoTitle,
          bullets: [
            l10n.helpGuideHiddenStegoBullet1,
            l10n.helpGuideHiddenStegoBullet2,
            l10n.helpGuideHiddenStegoBullet3,
            l10n.helpGuideHiddenStegoBullet4,
            l10n.helpGuideHiddenStegoBullet5,
          ],
        ),
        HelpSection(
          icon: Icons.lock_outline,
          title: l10n.helpGuideHiddenOtherTitle,
          bullets: [
            l10n.helpGuideHiddenOtherBullet1,
            l10n.helpGuideHiddenOtherBullet2,
            l10n.helpGuideHiddenOtherBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.info_outline,
          title: l10n.helpGuideHiddenSafetyTitle,
          bullets: [
            l10n.helpGuideHiddenSafetyBullet1,
            l10n.helpGuideHiddenSafetyBullet2,
            l10n.helpGuideHiddenSafetyBullet3,
          ],
        ),
      ],
      tip: l10n.helpGuideHiddenTip,
    );
  }
}
