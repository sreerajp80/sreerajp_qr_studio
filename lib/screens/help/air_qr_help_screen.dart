import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class AirQrHelpScreen extends StatelessWidget {
  const AirQrHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpAirQr,
      intro: l10n.helpGuideAirQrIntro,
      sections: [
        HelpSection(
          icon: Icons.upload_outlined,
          title: l10n.helpGuideAirQrStreamingTitle,
          bullets: [
            l10n.helpGuideAirQrStreamingBullet1,
            l10n.helpGuideAirQrStreamingBullet2,
            l10n.helpGuideAirQrStreamingBullet3,
            l10n.helpGuideAirQrStreamingBullet4,
          ],
        ),
        HelpSection(
          icon: Icons.download_outlined,
          title: l10n.helpGuideAirQrControlsTitle,
          bullets: [
            l10n.helpGuideAirQrControlsBullet1,
            l10n.helpGuideAirQrControlsBullet2,
            l10n.helpGuideAirQrControlsBullet3,
            l10n.helpGuideAirQrControlsBullet4,
          ],
        ),
        HelpSection(
          icon: Icons.sync_lock,
          title: l10n.helpGuideAirQrSyncTitle,
          bullets: [
            l10n.helpGuideAirQrSyncBullet1,
            l10n.helpGuideAirQrSyncBullet2,
            l10n.helpGuideAirQrSyncBullet3,
            l10n.helpGuideAirQrSyncBullet4,
          ],
        ),
        HelpSection(
          icon: Icons.lock_outline,
          title: l10n.helpGuideAirQrSecurityTitle,
          bullets: [
            l10n.helpGuideAirQrSecurityBullet1,
            l10n.helpGuideAirQrSecurityBullet2,
            l10n.helpGuideAirQrSecurityBullet3,
          ],
        ),
      ],
      tip: l10n.helpGuideAirQrTip,
    );
  }
}
