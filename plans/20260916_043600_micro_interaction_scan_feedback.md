# Micro-Interaction Scan Feedback Plan

**Status:** Approved

## Problem
In `docs/feature_improvements_and_roadmap.md` item 2.6.3, the scanner transition lacks micro-interaction polish. Currently, when the camera scans a barcode, `lib/screens/scanner_screen.dart` immediately stops the camera and pushes `/result`. While haptic feedback and click sounds play, there is no visual confirmation animation on the viewfinder reticle. This abrupt transition lacks visual satisfaction and tactile harmony.

## Proposed Fix
Implement a smooth, hardware-accelerated micro-interaction scan feedback experience:
1. **Subtle Reticle Pulse**:
   - In `lib/screens/widgets/scan_overlay_widget.dart`, add success state awareness (`isSuccess`).
   - When triggered, animate a subtle reticle compression and spring bounce (scale 1.0 -> 0.95 -> 1.05 -> 1.0) with an energetic glowing accent shift to vibrant emerald green.
2. **Checkmark Morph & Ripple**:
   - In the center of the reticle / detected barcode area, morph in an animated circular disc badge.
   - Animate the drawing of a checkmark path from start to elbow to tip.
   - Expand a soft translucent ripple shockwave outward from the checkmark badge.
3. **Synchronized Tactile & Audio Feedback**:
   - Emit crisp haptic and sound feedback synchronized with the animation.
   - Run the micro-animation for ~380ms before pushing the result screen route.
   - When returning from the result screen, seamlessly reset the animation state and re-enable scanning.
4. **User Preference in Settings**:
   - Add `isAnimationEnabled` (persisted under `scan_feedback_animation`, default `true`) in `lib/providers/scan_provider.dart`.
   - Add a switch toggle in `ScanFeedbackSettingsScreen` (`lib/screens/settings_screen.dart`) so users who prefer instant transitions can toggle it off.
5. **Tri-Lingual Localization**:
   - Add `feedbackAnimationTitle` and `feedbackAnimationSubtitle` keys to `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, and `lib/l10n/app_sa.arb` (strictly adhering to Sanskrit grammar without Hindi markers).
   - Run `flutter gen-l10n`.
6. **Roadmap Tracking**:
   - Mark item 2.6.3 as `✅ Implemented` in `docs/feature_improvements_and_roadmap.md`.

## Files to Change
- `lib/providers/scan_provider.dart` (MODIFY)
- `lib/screens/widgets/scan_overlay_widget.dart` (MODIFY)
- `lib/screens/scanner_screen.dart` (MODIFY)
- `lib/screens/settings_screen.dart` (MODIFY)
- `lib/l10n/app_en.arb` (MODIFY)
- `lib/l10n/app_ml.arb` (MODIFY)
- `lib/l10n/app_sa.arb` (MODIFY)
- `docs/feature_improvements_and_roadmap.md` (MODIFY)
- `test/providers/scan_provider_test.dart` (MODIFY)
- `test/screens/widgets/scan_overlay_widget_test.dart` (NEW)

## Verification Plan
1. `flutter gen-l10n` to rebuild localizations.
2. `flutter test` to ensure all unit, widget, and ARB parity tests pass.
3. `flutter analyze` to ensure 0 warnings and clean static analysis.
