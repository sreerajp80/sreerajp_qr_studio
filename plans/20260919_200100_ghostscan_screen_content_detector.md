# Plan: GhostScan — Screen Content QR Detector

**Status:** completed

**Date:** 2026-09-19

---

## 1. Issue & Context

Users frequently receive QR codes inside messaging apps (WhatsApp, Telegram), social media feeds (Twitter, Instagram, LinkedIn), web pages, and documents on their phones. Currently, scanning these requires taking a manual screenshot, opening SreerajP QR Reader, browsing the photo gallery, picking the screenshot, and deleting the screenshot afterward.

Roadmap item 3.5 specifies:
> "GhostScan — Screen Content QR Detector
> Detects and decodes QR codes visible on the phone screen (inside messaging apps, social media feeds, web pages, documents) without requiring the user to take a manual screenshot, open the gallery, and crop.
> Play Store Policy Consideration: Using SYSTEM_ALERT_WINDOW or continuous MediaProjection triggers heavy Google Play security scrutiny.
> Recommended compliant approach: Integrate an Android Quick Settings tile / Quick Screenshot action that captures the current display on demand and feeds it into the existing image_picker / MobileScannerController.analyzeImage() pipeline."

---

## 2. Proposed Changes

### Android Native Layer
- `android/app/src/main/AndroidManifest.xml`:
  - Add permissions:
    - `<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />`
    - `<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PROJECTION" />`
  - Register `GhostScanTileService` (`android.service.quicksettings.TileService`) with permission `BIND_QUICK_SETTINGS_TILE`.
  - Register `GhostScanCaptureService` as a short-lived foreground service (`foregroundServiceType="mediaProjection"`).
  - Register `GhostScanActivity` with transparent theme (`Theme.GhostScanTransparent`).
- `android/app/src/main/res/values/styles.xml`:
  - Add `Theme.GhostScanTransparent` for seamless transparent prompt handling.
- `android/app/src/main/res/values/strings.xml`:
  - Add string resource for `ghost_scan_tile_label` ("GhostScan").
- `android/app/src/main/res/drawable/ic_ghost_scan_tile.xml`:
  - Add vector drawable icon for the Quick Settings tile and capture notifications.
- `android/app/src/main/kotlin/in/sreerajp/qr_reader/GhostScanTileService.kt`:
  - Native `TileService` that collapses the notification shade and launches `GhostScanActivity`.
- `android/app/src/main/kotlin/in/sreerajp/qr_reader/GhostScanActivity.kt`:
  - Transparent activity requesting one-time screen capture consent via `MediaProjectionManager.createScreenCaptureIntent()`.
  - On user consent, starts `GhostScanCaptureService` and finishes immediately.
- `android/app/src/main/kotlin/in/sreerajp/qr_reader/GhostScanCaptureService.kt`:
  - Short-lived foreground service (active for ~200ms) with `mediaProjection` type.
  - Takes a single screen frame from `VirtualDisplay` via `ImageReader`, saves it to `cacheDir`, shuts down projection immediately (zero background surveillance), and launches `MainActivity` with the captured image.
- `android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt`:
  - Add MethodChannel `in.sreeraj.qr_reader/ghost_scan`.
  - Handle `isSupported`, `isTileRequestSupported`, `requestAddTile` (`StatusBarManager.requestAddTileService` on Android 13+), `startGhostScan`, and `getInitialGhostScanImage`.
  - Handle incoming intent `in.sreeraj.qr_reader.ACTION_GHOST_SCAN`.

### Dart Services & Models
- `lib/services/ghost_scan_service.dart`:
  - Service interfacing with `in.sreeraj.qr_reader/ghost_scan` platform channel.
  - Exposes `onGhostScanImage` stream, `startGhostScan()`, `requestAddTile()`, `isTileRequestSupported()`, and `getInitialGhostScanImage()`.
  - Layer-compliant: no `BuildContext`, no UI strings.

### Localization
- `lib/l10n/app_en.arb`:
  - Add keys with `@key` translator descriptions:
    - `ghostScanTitle`: "GhostScan"
    - `ghostScanSubtitle`: "Screen Content QR Detector"
    - `ghostScanDescription`: "Detect and decode QR codes visible on your screen inside any app without taking manual screenshots."
    - `ghostScanTileLabel`: "GhostScan"
    - `ghostScanActionScanNow`: "Scan Screen Now"
    - `ghostScanActionAddTile`: "Add Quick Settings Tile"
    - `ghostScanTileAdded`: "Quick Settings tile request sent"
    - `ghostScanHowItWorksTitle`: "How to use GhostScan"
    - `ghostScanStep1`: "Pull down your Quick Settings notification shade from any app."
    - `ghostScanStep2`: "Tap the GhostScan tile to capture and decode the screen."
    - `ghostScanStep3`: "The code is decoded instantly without saving screenshots to your gallery."
    - `ghostScanAnalyzing`: "Analyzing screen content..."
    - `ghostScanNoCodeFound`: "No QR code or barcode detected on screen"
- `lib/l10n/app_ml.arb`:
  - Malayalam translations with full key parity.
- `lib/l10n/app_sa.arb`:
  - Sanskrit translations adhering to §8.5 (zero Hindi markers, authentic Sanskrit).

### UI Widgets & Screen Integration
- `lib/widgets/ghost_scan_sheet.dart`:
  - Material 3 bottom sheet presenting GhostScan features, step-by-step usage guide, "Scan Screen Now" button, and "Add Quick Settings Tile" button.
- `lib/screens/scanner_screen.dart`:
  - Add `GhostScanService` integration.
  - Listen to `onGhostScanImage` stream to analyze screen captures via `_scanImagePath()`.
  - Check `getInitialGhostScanImage()` on cold launch.
  - Add GhostScan action to the top AppBar overflow menu.
- `lib/screens/features_screen.dart`:
  - Add GhostScan feature card under Core Scanning or Smart Tools category.

### Documentation & Roadmap
- `docs/feature_improvements_and_roadmap.md`:
  - Update item 3.5 to mark GhostScan as completed.

### Testing
- `test/services/ghost_scan_service_test.dart`:
  - Unit tests for `GhostScanService` platform channel calls.
- `test/widgets/ghost_scan_sheet_test.dart`:
  - Widget tests for `GhostScanSheet` rendering and user interactions.
- `test/l10n/l10n_parity_test.dart`:
  - Tri-lingual parity and Hindi marker gate validation.

---

## 3. Verification

1. `flutter gen-l10n` to compile localization classes.
2. `flutter test test/services/ghost_scan_service_test.dart` to verify service logic.
3. `flutter test test/widgets/ghost_scan_sheet_test.dart` to verify bottom sheet UI.
4. `flutter test test/l10n/l10n_parity_test.dart` to ensure ARB parity and zero Hindi markers in Sanskrit.
5. `flutter test` to ensure all unit and widget tests pass.
6. `flutter analyze` to ensure 0 warnings.
7. `dart format .` for proper formatting.
