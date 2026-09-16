import 'package:flutter/material.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';

/// Immutable domain model representing one slide in the onboarding carousel.
class OnboardingSlide {
  final IconData icon;
  final String badge;
  final String title;
  final String description;
  final List<String> bullets;
  final Color? accentColor;

  const OnboardingSlide({
    required this.icon,
    required this.badge,
    required this.title,
    required this.description,
    required this.bullets,
    this.accentColor,
  });

  /// Factory constructing the standard 3 onboarding slides using localized strings.
  static List<OnboardingSlide> buildSlides(AppLocalizations l10n) {
    return [
      OnboardingSlide(
        icon: Icons.shield_outlined,
        badge: l10n.onboardingSlide1Badge,
        title: l10n.onboardingSlide1Title,
        description: l10n.onboardingSlide1Description,
        bullets: [
          l10n.onboardingSlide1Bullet1,
          l10n.onboardingSlide1Bullet2,
          l10n.onboardingSlide1Bullet3,
        ],
      ),
      OnboardingSlide(
        icon: Icons.document_scanner_outlined,
        badge: l10n.onboardingSlide2Badge,
        title: l10n.onboardingSlide2Title,
        description: l10n.onboardingSlide2Description,
        bullets: [
          l10n.onboardingSlide2Bullet1,
          l10n.onboardingSlide2Bullet2,
          l10n.onboardingSlide2Bullet3,
        ],
      ),
      OnboardingSlide(
        icon: Icons.lock_outline,
        badge: l10n.onboardingSlide3Badge,
        title: l10n.onboardingSlide3Title,
        description: l10n.onboardingSlide3Description,
        bullets: [
          l10n.onboardingSlide3Bullet1,
          l10n.onboardingSlide3Bullet2,
          l10n.onboardingSlide3Bullet3,
        ],
      ),
    ];
  }
}
