import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class CodeForgeHelpScreen extends StatelessWidget {
  const CodeForgeHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpCodeForge,
      intro: l10n.helpGuideCodeForgeIntro,
      sections: [
        HelpSection(
          icon: Icons.edit_note,
          title: l10n.helpGuideCodeForgeTypeTitle,
          bullets: [
            l10n.helpGuideCodeForgeTypeBullet1,
            l10n.helpGuideCodeForgeTypeBullet2,
            l10n.helpGuideCodeForgeTypeBullet3,
            l10n.helpGuideCodeForgeTypeBullet4,
            l10n.helpGuideCodeForgeTypeBullet5,
            l10n.helpGuideCodeForgeTypeBullet6,
          ],
        ),
        HelpSection(
          icon: Icons.palette_outlined,
          title: l10n.helpGuideCodeForgeStyleTitle,
          bullets: [
            l10n.helpGuideCodeForgeStyleBullet1,
            l10n.helpGuideCodeForgeStyleBullet2,
            l10n.helpGuideCodeForgeStyleBullet3,
            l10n.helpGuideCodeForgeStyleBullet4,
            l10n.helpGuideCodeForgeStyleBullet5,
            l10n.helpGuideCodeForgeStyleBullet6,
          ],
        ),
        HelpSection(
          icon: Icons.share_outlined,
          title: l10n.helpGuideCodeForgeShareTitle,
          bullets: [
            l10n.helpGuideCodeForgeShareBullet1,
            l10n.helpGuideCodeForgeShareBullet2,
            l10n.helpGuideCodeForgeShareBullet3,
          ],
        ),
      ],
      tip: l10n.helpGuideCodeForgeTip,
    );
  }
}
