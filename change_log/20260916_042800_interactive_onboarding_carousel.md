# Interactive Onboarding Carousel Change Log

**Plan:** [plans/20260915_221200_interactive_onboarding_carousel.md](../plans/20260915_221200_interactive_onboarding_carousel.md)  
**Date:** 2026-09-16  
**Status:** Completed  

## Overview
Added a lightweight 3-slide interactive onboarding carousel that introduces new users to the core features on first launch:
1. **6-Layer URL Safety Engine** (Protocol Guard, Homograph Shield, TLD Entropy, Heuristic Port Traps, Safe Browsing).
2. **QuishingGuard™ Tamper Detection** (Physical sticker overlay detection, edge-cut and glare analysis before scanning).
3. **100% Offline Privacy Model** (Encrypted on-device SQLite storage, air-gapped AirQR optical transfer, zero analytics).

Users can also replay the tour at any time from the Settings screen or the Help Center.

## Changes Made

### 1. Domain Model
- Created `lib/models/onboarding_slide.dart` with an immutable `OnboardingSlide` model and a localized slide factory method.

### 2. State Management & Persistence
- Created `lib/providers/onboarding_provider.dart` using `ChangeNotifier` and `SharedPreferences` to manage and store `has_seen_onboarding`.
- Added methods `completeOnboarding()` and `resetOnboarding()`.

### 3. Presentation Layer
- Created `lib/screens/onboarding_screen.dart` with a Material 3 `PageView` carousel.
- Includes animated dot indicators, a "Skip" button, "Next" navigation, and a "Start Scanning" call to action.
- Added replay support (`isReplay: true`) with back navigation for opening from Settings and Help.

### 4. App Launch & Navigation
- Updated `lib/main.dart` to provide `OnboardingProvider` and display `OnboardingScreen` on first launch before loading `MainShellScreen`.
- Registered route `'/onboarding'` for direct navigation and replay.

### 5. Settings & Help Center Replay
- Updated `lib/screens/settings_screen.dart` to add a "Welcome Tour" card.
- Updated `lib/screens/help/help_home_screen.dart` to add an "Interactive Feature Tour" topic card.

### 6. Tri-Lingual Localization
- Updated `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, and `lib/l10n/app_sa.arb` with complete onboarding keys.
- Confirmed full key parity across English, Malayalam, and Sanskrit, passing the Hindi marker gate test.

### 7. Documentation
- Updated `docs/feature_improvements_and_roadmap.md` marking item 2.6.1 as `✅ Implemented`.

### 8. Testing & Validation
- Added `test/providers/onboarding_provider_test.dart` testing preference persistence and listeners.
- Added `test/screens/onboarding_screen_test.dart` testing slide rendering, navigation, skip action, and replay mode.
- Ran static analysis (`flutter analyze`) with 0 warnings.
- Ran test suite (`flutter test`) with all 262 tests passing.
