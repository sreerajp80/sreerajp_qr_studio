# Interactive Onboarding Carousel Plan

**Status:** completed

## Problem
When a user launches SreerajP QR Reader for the very first time, the application opens directly into the camera scanner or main shell. New users are unaware of the application's unique features, such as the 6-layer URL safety engine, QuishingGuard physical tamper detection, and the 100% offline privacy model (zero analytics, zero cloud tracking). Item 2.6.1 in `docs/feature_improvements_and_roadmap.md` calls for a lightweight 3-slide introductory carousel on first launch to highlight these core capabilities and elevate the first impression.

## Proposed Fix
Implement an interactive 3-slide onboarding carousel displayed on first launch, with the ability to skip at any moment or replay anytime from the Settings and Help screens.

### 1. Domain Model
File: `lib/models/onboarding_slide.dart` (NEW)
- Define an immutable `OnboardingSlide` model with:
  - `icon`: IconData representing the feature.
  - `badgeKey`: Localized badge tag (e.g. "6-Layer Security", "Computer Vision", "Zero Cloud • Zero Tracking").
  - `titleKey`: Localized slide title.
  - `descriptionKey`: Localized explanatory paragraph.
  - `bullets`: List of localized bullet strings highlighting core aspects.
  - `accentColor`: Optional theme accent hint.

### 2. State Management & Persistence
File: `lib/providers/onboarding_provider.dart` (NEW)
- Key: `pref_has_seen_onboarding` stored in `SharedPreferences`.
- Exposes:
  - `bool get hasSeenOnboarding`
  - `bool get isInitialized`
  - `Future<void> completeOnboarding()` (saves `has_seen_onboarding = true`, notifies listeners)
  - `Future<void> resetOnboarding()` (resets flag, useful for replay/testing)
- Allows injecting `SharedPreferences? prefs` in constructor for fast, reliable unit testing.

### 3. Presentation Layer
File: `lib/screens/onboarding_screen.dart` (NEW)
- 3-slide interactive `PageView` carousel:
  - Slide 1: **6-Layer URL Safety Engine** (Protocol Guard, Homograph Shield, TLD Entropy, Port Traps, Safe Browsing).
  - Slide 2: **QuishingGuard™ Tamper Detection** (Physical sticker overlay detection, edge-cut and glare analysis before scanning).
  - Slide 3: **100% Offline Privacy Model** (Zero analytics, zero tracking, encrypted SQLite database, AirQR optical air-gap).
- UI controls:
  - Top "Skip" button to jump immediately to the scanner at any point.
  - Smooth animated dot indicator showing current page progress.
  - Bottom action button: "Next" on slides 1 and 2; "Start Scanning" on slide 3.
  - Gesture swipe support with page physics.
  - Full Material 3 design conforming to Light, Dark, and OLED pure black themes.
- Replay support:
  - Optional constructor flag `final bool isReplay` (default `false`).
  - If `isReplay` is true, completing or skipping simply pops the screen back to the previous screen.
  - If `isReplay` is false (first launch), completing marks the provider flag and replaces the route with `MainShellScreen`.

### 4. Integration into App Launch
File: `lib/main.dart` (MODIFY)
- Register `OnboardingProvider` in `MultiProvider`.
- Update `MaterialApp` `home`:
  - When `!onboardingProvider.isInitialized`: displays a theme-matched background while preferences load.
  - When `!onboardingProvider.hasSeenOnboarding`: displays `const OnboardingScreen()`.
  - When `onboardingProvider.hasSeenOnboarding`: displays `const MainShellScreen()`.
- Add route `'/onboarding': (context) => const OnboardingScreen(isReplay: true)` to enable navigation from Settings and Help.

### 5. Replay from Settings & Help
Files:
- `lib/screens/settings_screen.dart` (MODIFY): Add a "Welcome Tour" tile in the Help/About section.
- `lib/screens/help/help_home_screen.dart` (MODIFY): Add an "Interactive Feature Tour" card in the guide hub.

### 6. Tri-Lingual Localization
Files:
- `lib/l10n/app_en.arb` (MODIFY): Add onboarding keys with descriptive `@key` annotations.
- `lib/l10n/app_ml.arb` (MODIFY): Add corresponding Malayalam translations.
- `lib/l10n/app_sa.arb` (MODIFY): Add corresponding Sanskrit translations adhering to Sanskrit grammatical rules (passing the Hindi marker gate test).
- Run `flutter gen-l10n`.

### 7. Documentation & Roadmap
File: `docs/feature_improvements_and_roadmap.md` (MODIFY)
- Mark item 2.6.1 as `✅ Implemented`.

### 8. Testing Plan
- `test/providers/onboarding_provider_test.dart` (NEW): Test preference loading, completion flag persistence, and listener notifications.
- `test/screens/onboarding_screen_test.dart` (NEW): Test carousel rendering, page swiping, Next button, Skip button, and Get Started action in both first-launch and replay modes.
- `test/l10n/l10n_parity_test.dart`: Verify tri-lingual ARB key parity and Hindi marker gate.
- Run `flutter analyze` and `flutter test`.
