# Change Log: GhostScan — Screen Content QR Detector

**Date:** 2026-09-19

**Plan Reference:** `plans/20260919_200100_ghostscan_screen_content_detector.md`

---

## Summary of Changes

Implemented **3.5 🏆 GhostScan — Screen Content QR Detector**, which enables users to detect and decode QR codes visible on their mobile screen (in chat apps, social feeds, web pages, and documents) without taking manual screenshots or saving images to the gallery.

The implementation strictly complies with Google Play Store policies:
- User-initiated on-demand trigger via an Android Quick Settings Tile (`TileService`) or in-app action.
- Uses Android's `MediaProjection` API with the standard one-time system consent prompt.
- Executes through a short-lived foreground service (`FOREGROUND_SERVICE_MEDIA_PROJECTION`) for ~200ms to grab a single display frame, immediately releasing all projection and display resources.
- Zero persistent background surveillance, zero continuous recording, zero accessibility service abuse.

---

## Changed Files

### Native Android Layer
- `android/app/src/main/AndroidManifest.xml`:
  - Added permissions `FOREGROUND_SERVICE` and `FOREGROUND_SERVICE_MEDIA_PROJECTION`.
  - Registered `GhostScanTileService` with `android.permission.BIND_QUICK_SETTINGS_TILE`.
  - Registered `GhostScanCaptureService` as a foreground service with `foregroundServiceType="mediaProjection"`.
  - Declared `GhostScanActivity` with `Theme.GhostScanTransparent`.
- `android/app/src/main/res/values/styles.xml`:
  - Added `Theme.GhostScanTransparent` for translucent overlay during permission consent.
- `android/app/src/main/res/values/strings.xml`:
  - Defined `ghost_scan_tile_label` ("GhostScan").
- `android/app/src/main/res/drawable/ic_ghost_scan_tile.xml`:
  - Added vector drawable icon for the Quick Settings tile and capture notifications.
- `android/app/src/main/kotlin/in/sreerajp/qr_reader/GhostScanTileService.kt`:
  - Created native `TileService` handling Quick Settings shade taps, collapsing the shade, and launching `GhostScanActivity`.
- `android/app/src/main/kotlin/in/sreerajp/qr_reader/GhostScanActivity.kt`:
  - Transparent activity prompting for one-time screen capture consent via `MediaProjectionManager`.
- `android/app/src/main/kotlin/in/sreerajp/qr_reader/GhostScanCaptureService.kt`:
  - Short-lived foreground service capturing a single display frame to a temporary cache file and launching `MainActivity`.
- `android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt`:
  - Added `in.sreeraj.qr_reader/ghost_scan` MethodChannel supporting `isSupported`, `isTileRequestSupported`, `requestAddTile` (`StatusBarManager.requestAddTileService` on Android 13+), `startGhostScan`, and `getInitialGhostScanImage`.
  - Handled incoming `in.sreeraj.qr_reader.ACTION_GHOST_SCAN` intent and forwarded captured paths to Flutter.

### Dart Services & Models
- `lib/services/ghost_scan_service.dart`:
  - Platform channel bridge providing `onGhostScanImage` stream, `startGhostScan()`, `requestAddTile()`, `isTileRequestSupported()`, and `getInitialGhostScanImage()`.

### Localization
- `lib/l10n/app_en.arb`:
  - Added 13 GhostScan keys with `@key` translator descriptions.
- `lib/l10n/app_ml.arb`:
  - Added Malayalam translations with 100% key parity.
- `lib/l10n/app_sa.arb`:
  - Added Sanskrit translations passing the Hindi marker gate with zero violations.

### UI & Viewfinder Integration
- `lib/widgets/ghost_scan_sheet.dart`:
  - Material 3 bottom sheet providing step-by-step usage guide, "Scan Screen Now" button, and "Add Quick Settings Tile" action.
- `lib/screens/scanner_screen.dart`:
  - Integrated `GhostScanService` listener, lifecycle management, cold launch handling, and overflow menu item (`/ghost_scan`).
- `lib/screens/features_screen.dart`:
  - Added GhostScan feature card under Core Scanning category.

### Documentation & Roadmap
- `docs/feature_improvements_and_roadmap.md`:
  - Marked item 3.5 🏆 GhostScan — Screen Content QR Detector as implemented.

### Tests
- `test/services/ghost_scan_service_test.dart`:
  - Unit tests verifying platform channel invocation, error handling, and stream emission.
- `test/widgets/ghost_scan_sheet_test.dart`:
  - Widget tests verifying UI rendering, scan action trigger, and tile addition request.

---

## Verification

1. `flutter gen-l10n` executed cleanly with 0 errors.
2. `flutter test test/services/ghost_scan_service_test.dart test/widgets/ghost_scan_sheet_test.dart test/l10n/l10n_parity_test.dart` passed all 17 tests.
3. `flutter analyze` completed with 0 warnings and 0 errors.
4. `dart format .` formatted all changed files.
