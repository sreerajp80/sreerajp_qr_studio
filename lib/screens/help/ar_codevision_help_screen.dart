import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class ArCodeVisionHelpScreen extends StatelessWidget {
  const ArCodeVisionHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpArCodeVision,
      intro: l10n.helpGuideArCodeVisionIntro,
      sections: [
        HelpSection(
          icon: Icons.view_in_ar,
          title: l10n.helpGuideArCodeVisionOpenTitle,
          bullets: [
            l10n.helpGuideArCodeVisionOpenBullet1,
            l10n.helpGuideArCodeVisionOpenBullet2,
          ],
        ),
        HelpSection(
          icon: Icons.layers_outlined,
          title: l10n.helpGuideArCodeVisionTrackingTitle,
          bullets: [
            l10n.helpGuideArCodeVisionTrackingBullet1,
            l10n.helpGuideArCodeVisionTrackingBullet2,
          ],
        ),
        HelpSection(
          icon: Icons.touch_app_outlined,
          title: l10n.helpGuideArCodeVisionBatchTitle,
          bullets: [
            l10n.helpGuideArCodeVisionBatchBullet1,
            l10n.helpGuideArCodeVisionBatchBullet2,
            l10n.helpGuideArCodeVisionBatchBullet3,
          ],
        ),
      ],
      tip: l10n.helpGuideArCodeVisionTip,
    );
  }
}
