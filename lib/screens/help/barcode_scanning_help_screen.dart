import 'package:flutter/material.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';

class BarcodeScanningHelpScreen extends StatelessWidget {
  const BarcodeScanningHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.titleHelpBarcode)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          children: [
            _Intro(l10n.helpGuideBarcodeIntro),
            const SizedBox(height: 24),
            _Section(
              icon: Icons.qr_code_scanner,
              title: l10n.helpGuideBarcodeCameraTitle,
              children: [
                _Bullet(l10n.helpGuideBarcodeCameraBullet1),
                _Bullet(l10n.helpGuideBarcodeCameraBullet2),
                _Bullet(l10n.helpGuideBarcodeCameraBullet3),
              ],
            ),
            _Section(
              icon: Icons.photo_library_outlined,
              title: l10n.helpGuideBarcodeGalleryTitle,
              children: [
                _Bullet(l10n.helpGuideBarcodeGalleryBullet1),
                _Bullet(l10n.helpGuideBarcodeGalleryBullet2),
                _Bullet(l10n.helpGuideBarcodeGalleryBullet3),
              ],
            ),
            _Section(
              icon: Icons.picture_as_pdf_outlined,
              title: l10n.helpGuideBarcodePdfTitle,
              children: [
                _Bullet(l10n.helpGuideBarcodePdfBullet1),
                _Bullet(l10n.helpGuideBarcodePdfBullet2),
                _Bullet(l10n.helpGuideBarcodePdfBullet3),
              ],
            ),
            const SizedBox(height: 8),
            _Footer(l10n.helpGuideBarcodeTip),
          ],
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  final String text;
  const _Intro(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        height: 1.5,
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;

  const _Section({
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7, right: 10),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.5,
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final String text;
  const _Footer(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: accent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: accent,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
