import 'package:material_ui/material_ui.dart';

/// Immutable data for one slide in the onboarding carousel.
///
/// The onboarding screen fills it with localized text; this model holds no
/// text of its own.
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
}
