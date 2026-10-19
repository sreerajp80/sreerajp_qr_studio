import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class BarcodeScanningHelpScreen extends StatelessWidget {
  const BarcodeScanningHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpBarcode,
      intro: l10n.helpGuideBarcodeIntro,
      sections: [
        HelpSection(
          icon: Icons.qr_code_scanner,
          title: l10n.helpGuideBarcodeCameraTitle,
          bullets: [
            l10n.helpGuideBarcodeCameraBullet1,
            l10n.helpGuideBarcodeCameraBullet2,
            l10n.helpGuideBarcodeCameraBullet3,
            l10n.helpGuideBarcodeCameraBullet4,
            l10n.helpGuideBarcodeCameraBullet5,
            l10n.helpGuideBarcodeCameraBullet6,
          ],
        ),
        HelpSection(
          icon: Icons.photo_library_outlined,
          title: l10n.helpGuideBarcodeGalleryTitle,
          bullets: [
            l10n.helpGuideBarcodeGalleryBullet1,
            l10n.helpGuideBarcodeGalleryBullet2,
            l10n.helpGuideBarcodeGalleryBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.picture_as_pdf_outlined,
          title: l10n.helpGuideBarcodePdfTitle,
          bullets: [
            l10n.helpGuideBarcodePdfBullet1,
            l10n.helpGuideBarcodePdfBullet2,
            l10n.helpGuideBarcodePdfBullet3,
            l10n.helpGuideBarcodePdfBullet4,
          ],
        ),
        HelpSection(
          icon: Icons.content_paste_go,
          title: l10n.helpGuideBarcodeClipboardTitle,
          bullets: [
            l10n.helpGuideBarcodeClipboardBullet1,
            l10n.helpGuideBarcodeClipboardBullet2,
            l10n.helpGuideBarcodeClipboardBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.inventory_2_outlined,
          title: l10n.helpGuideBarcodeBatchTitle,
          bullets: [
            l10n.helpGuideBarcodeBatchBullet1,
            l10n.helpGuideBarcodeBatchBullet2,
            l10n.helpGuideBarcodeBatchBullet3,
            l10n.helpGuideBarcodeBatchBullet4,
          ],
        ),
        HelpSection(
          icon: Icons.tune,
          title: l10n.helpGuideBarcodeTuneTitle,
          bullets: [
            l10n.helpGuideBarcodeTuneBullet1,
            l10n.helpGuideBarcodeTuneBullet2,
            l10n.helpGuideBarcodeTuneBullet3,
            l10n.helpGuideBarcodeTuneBullet4,
            l10n.helpGuideBarcodeTuneBullet5,
            l10n.helpGuideBarcodeTuneBullet6,
            l10n.helpGuideBarcodeTuneBullet7,
          ],
        ),
      ],
      tip: l10n.helpGuideBarcodeTip,
    );
  }
}
