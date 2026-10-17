import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/onboarding_slide.dart';
import 'package:sreerajp_qr_studio/providers/onboarding_provider.dart';
import 'package:sreerajp_qr_studio/screens/main_shell_screen.dart';

/// Lightweight 3-slide introductory carousel explaining:
/// 1. 6-Layer URL Safety Engine
/// 2. QuishingGuard™ Physical Tamper Detection
/// 3. 100% Offline Privacy Model
class OnboardingScreen extends StatefulWidget {
  final bool isReplay;
  final VoidCallback? onCompleted;

  const OnboardingScreen({super.key, this.isReplay = false, this.onCompleted});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> _finishOnboarding() async {
    if (widget.onCompleted != null) {
      widget.onCompleted!();
      return;
    }

    if (widget.isReplay) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      return;
    }

    final provider = context.read<OnboardingProvider>();
    await provider.completeOnboarding();

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShellScreen()),
    );
  }

  void _nextPage(int totalPages) {
    if (_currentPage < totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final slides = _buildOnboardingSlides(l10n);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar / Skip Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.isReplay)
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      tooltip: l10n.tooltipBack,
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  else
                    const SizedBox(width: 48),

                  // Skip Button
                  TextButton(
                    onPressed: _finishOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.onSurfaceVariant,
                    ),
                    child: Text(
                      l10n.actionOnboardingSkip,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            // Carousel Slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  return _SlideView(slide: slides[index]);
                },
              ),
            ),

            // Bottom Navigation Controls
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicators
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(slides.length, (index) {
                      final isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  // Action Button: "Next" or "Start Scanning"
                  FilledButton.icon(
                    key: const Key('onboarding_action_button'),
                    onPressed: () => _nextPage(slides.length),
                    icon: Icon(
                      _currentPage == slides.length - 1
                          ? Icons.qr_code_scanner
                          : Icons.arrow_forward,
                      size: 20,
                    ),
                    label: Text(
                      _currentPage == slides.length - 1
                          ? l10n.actionOnboardingGetStarted
                          : l10n.actionOnboardingNext,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideView extends StatelessWidget {
  final OnboardingSlide slide;

  const _SlideView({required this.slide});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          const SizedBox(height: 12),

          // Hero Icon Container
          Container(
            width: 104,
            height: 104,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.25),
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                slide.icon,
                size: 52,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Badge Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              slide.badge,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 24),

          // Feature Highlight Bullets Card
          Card(
            elevation: 0,
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: slide.bullets.map((bullet) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            bullet,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// Builds the three onboarding slides from localized strings.
List<OnboardingSlide> _buildOnboardingSlides(AppLocalizations l10n) {
  return [
    OnboardingSlide(
      icon: Icons.shield_outlined,
      badge: l10n.labelOnboardingSlide1Badge,
      title: l10n.titleOnboardingSlide1,
      description: l10n.bodyOnboardingSlide1,
      bullets: [
        l10n.bodyOnboardingSlide1Bullet1,
        l10n.bodyOnboardingSlide1Bullet2,
        l10n.bodyOnboardingSlide1Bullet3,
      ],
    ),
    OnboardingSlide(
      icon: Icons.document_scanner_outlined,
      badge: l10n.labelOnboardingSlide2Badge,
      title: l10n.titleOnboardingSlide2,
      description: l10n.bodyOnboardingSlide2,
      bullets: [
        l10n.bodyOnboardingSlide2Bullet1,
        l10n.bodyOnboardingSlide2Bullet2,
        l10n.bodyOnboardingSlide2Bullet3,
      ],
    ),
    OnboardingSlide(
      icon: Icons.lock_outline,
      badge: l10n.labelOnboardingSlide3Badge,
      title: l10n.titleOnboardingSlide3,
      description: l10n.bodyOnboardingSlide3,
      bullets: [
        l10n.bodyOnboardingSlide3Bullet1,
        l10n.bodyOnboardingSlide3Bullet2,
        l10n.bodyOnboardingSlide3Bullet3,
      ],
    ),
  ];
}
