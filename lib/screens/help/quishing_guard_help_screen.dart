import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class QuishingGuardHelpScreen extends StatelessWidget {
  const QuishingGuardHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpQuishing,
      intro: l10n.helpGuideQuishingIntro,
      sections: [
        HelpSection(
          icon: Icons.policy_outlined,
          title: l10n.helpGuideQuishingCvTitle,
          bullets: [
            l10n.helpGuideQuishingCvBullet1,
            l10n.helpGuideQuishingCvBullet2,
            l10n.helpGuideQuishingCvBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.back_hand_outlined,
          title: l10n.helpGuideQuishingForensicTitle,
          bullets: [
            l10n.helpGuideQuishingForensicBullet1,
            l10n.helpGuideQuishingForensicBullet2,
            l10n.helpGuideQuishingForensicBullet3,
          ],
        ),
      ],
      tip: l10n.helpGuideQuishingTip,
    );
  }
}
