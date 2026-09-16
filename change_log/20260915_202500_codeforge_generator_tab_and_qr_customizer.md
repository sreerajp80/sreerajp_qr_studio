# CodeForge Standalone QR & Barcode Generator Change Log

**Plan Reference:** `plans/20260915_202500_codeforge_generator_tab_and_qr_customizer.md`

## Summary of Changes
Implemented feature 3.4 from `docs/feature_improvements_and_roadmap.md`: **CodeForge — Standalone QR & Barcode Generator**. This transforms the app into a complete two-way utility by introducing a dedicated root navigation tab alongside Scan and History, with complete visual structure customization for QR codes (eye design, corner design, pattern dots, color studio, gradients, and center badges) and 1D retail barcode generation.

### 1. Root Tab Navigation Shell
- Added `lib/screens/main_shell_screen.dart` featuring a Material 3 `NavigationBar` with 3 primary tabs:
  - Tab 0: **Scan** (`ScannerScreen`)
  - Tab 1: **CodeForge** (`CodeForgeScreen`)
  - Tab 2: **History** (`HistoryScreen`)
- Uses `IndexedStack` to preserve generator state and inputs across tab switches.
- Added camera lifecycle handling to `ScannerScreen` via `isActive`: automatically pauses the camera feed when switching away from the Scan tab to release hardware and conserve battery, and resumes when switching back.
- Updated `lib/main.dart` with `home: const MainShellScreen()` and added `/code_forge` and `/scanner` routes.

### 2. Dependencies
- Added `barcode: ^2.2.9` and direct dependency `qr: ^3.0.2` in `pubspec.yaml` (both pure Dart, Apache 2.0 / BSD-3-Clause, offline-first).
- Updated `docs/dependencies.md`.

### 3. Domain Model
- Created `lib/models/code_forge_config.dart`:
  - `CodeForgeBarcodeType`: `qrCode`, `code128`, `ean13`, `ean8`, `upcA`, `code39`, `pdf417`, `dataMatrix`.
  - `CodeForgePayloadType`: `text`, `url`, `wifi`, `contactVCard`, `upiPayment`, `sms`, `email`, `geo`.
  - `QrPatternShape`: `square`, `dots`, `rounded`, `classy`, `diamond`.
  - `QrEyeShape`: `square`, `rounded`, `circle`, `leaf`.
  - `QrEyeBallShape`: `square`, `rounded`, `circle`, `diamond`.
  - `QrCenterBadge`: `none`, `payloadIcon`, `shieldVerified`.
  - `QrGradientTheme`: `none`, `sunset`, `ocean`, `neon`, `royalGold`.
  - Immutable configuration model `CodeForgeConfig`.

### 4. Service Layer
- Created `lib/services/code_forge_service.dart`:
  - Formats payloads (Wi-Fi ZXing escaping, standard vCard 3.0, UPI payment URI with parameters, SMS, Email, Geo).
  - Validates payload syntax and checksums (e.g. EAN-13, UPC-A, Wi-Fi SSID requirements).
  - Generates 1D/2D barcodes using `Barcode`.
  - Computes QR matrix using `QrCode` and `QrImage`.
  - Exports vector SVG strings for both styled QR codes and 1D barcodes.
  - Renders high-resolution PNG image bytes directly in memory.
  - Shares images and vector SVG files using `SharePlus`.
  - Connects URL payloads to `UrlSafetyService` for pre-flight link safety verification.

### 5. Custom Painters & Widgets
- Created `lib/widgets/code_forge_qr_painter.dart`:
  - Custom canvas painter rendering tailored outer corner frames (square, rounded rect, circle, leaf), inner pupils (square, rounded rect, circle, diamond), pattern dot modules (square, dots, rounded, classy, diamond), solid/gradient shaders, and center emblem cutouts with quiet zone protection.
- Created `lib/widgets/code_forge_barcode_widget.dart`:
  - Canvas painter for 1D and 2D barcodes with optional text label under the bars.

### 6. Provider Layer
- Created `lib/providers/code_forge_provider.dart`:
  - Manages active config, form state, QR matrix caching, pre-flight safety check results, and export status.
  - Registered in `MultiProvider` in `lib/main.dart`.

### 7. CodeForge Screen
- Created `lib/screens/code_forge_screen.dart`:
  - Barcode format selector chips.
  - Live interactive preview card with copy payload, reset styling, and export buttons.
  - Pre-flight link safety banner for URL payloads.
  - Payload form with presets: Text, URL, Wi-Fi, Contact, UPI Pay, SMS, Email, Geo.
  - QR Code Structure & Design Studio:
    - Corner Eye Outer Shape (Square, Rounded, Circle, Leaf).
    - Inner Eye Pupil Shape (Square, Rounded, Circle, Diamond).
    - Data Module Pattern (Square, Dots, Rounded, Classy, Diamond).
    - Color Studio (Foreground, Background, Eye Outer, Eye Inner, Linear Gradients).
    - Error Correction Level (L, M, Q, H).
    - Center Badge (None, Payload Icon, Verified Shield).
  - Share PNG and Share SVG buttons.

### 8. Localization
- Updated `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, and `lib/l10n/app_sa.arb` with full key parity across English, Malayalam, and Sanskrit.
- Sanskrit translations strictly adhere to classical grammar and contain zero Hindi markers.
- Ran `flutter gen-l10n`.

### 9. Roadmap Documentation
- Updated `docs/feature_improvements_and_roadmap.md` marking section 3.4 as implemented.

### 10. Verification
- Added automated unit and widget tests:
  - `test/models/code_forge_config_test.dart`
  - `test/services/code_forge_service_test.dart`
  - `test/providers/code_forge_provider_test.dart`
  - `test/screens/main_shell_screen_test.dart`
- Ran static analysis: `flutter analyze` (0 issues found).
- Ran all tests: `flutter test` (253 tests passed).
- Ran code formatting: `dart format .`.
