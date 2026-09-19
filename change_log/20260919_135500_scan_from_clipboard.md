# Change Log: Scan From Clipboard

**Date:** 2026-09-19

**Reference Plan:** `plans/20260919_134845_scan_from_clipboard.md`

---

## 1. Summary of Changes

Implemented feature **2.1.3: Scan From Clipboard** from `docs/feature_improvements_and_roadmap.md`. The app now automatically detects when the system clipboard contains an image, URL, or raw barcode payload (such as Wi-Fi credentials, vCards, SMS, UPI payments, ISBNs, retail barcodes, or OTP tokens) and presents a quick-action floating chip on the scanner screen. In addition, an on-demand "Scan from Clipboard" button is provided in the scanner AppBar actions suite.

---

## 2. Detailed Changes

### Domain Models
- `lib/models/clipboard_scan_data.dart`:
  - Created `ClipboardContentType` enum (`url`, `barcodePayload`, `image`, `text`).
  - Created immutable `ClipboardScanData` model containing `type`, `content`, `barcodeType`, and `preview`.

### Platform Integration
- `android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt`:
  - Added method channel `in.sreeraj.qr_reader/clipboard`.
  - Implemented `getClipboardImage` method to check Android `ClipboardManager` for `image/*` MIME type or image content URI, stream it to a temporary cache file, and return the path.

### Services
- `lib/services/clipboard_scan_service.dart`:
  - Created `ClipboardScanService` that checks the native platform channel for copied images, Flutter's `Clipboard.getData(Clipboard.kTextPlain)` for text, base64 data URIs, local image file paths, URLs, and structured barcode payloads via `PayloadParserService` and regex.
  - Returns structured `ClipboardScanData?` without depending on `BuildContext` or holding UI strings.

### Localization
- `lib/l10n/app_en.arb`:
  - Added English localization keys with `@key` translator descriptions: `scanFromClipboard`, `clipboardBannerTitle`, `clipboardActionScan`, `clipboardDismiss`, `clipboardEmptyMessage`, `clipboardNoValidContent`, `clipboardTypeUrl`, `clipboardTypeBarcode`, `clipboardTypeImage`, `clipboardTypeText`.
- `lib/l10n/app_ml.arb`:
  - Added authentic Malayalam translations with full key parity.
- `lib/l10n/app_sa.arb`:
  - Added authentic Sanskrit translations adhering to §8.5 (zero Hindi markers).
- Compiled with `flutter gen-l10n`.

### Screens & UI
- `lib/screens/scanner_screen.dart`:
  - Integrated `ClipboardScanService`.
  - Added clipboard checks on initial load, app resume (`didChangeAppLifecycleState`), and returning from other routes (`didPopNext`).
  - Added a floating quick-action pill/chip on the viewfinder with an icon, content type badge, preview snippet, "Scan Now" button, and dismiss button.
  - Added an on-demand `Icons.content_paste_go` button in the AppBar actions suite.
  - Supported routing for images, single scans, and batch scanning.

### Documentation
- `docs/feature_improvements_and_roadmap.md`:
  - Marked feature 2.1.3 ("Scan From Clipboard") as implemented in both the scanner improvements table and the priority summary.

### Tests
- `test/models/clipboard_scan_data_test.dart`:
  - Tested model properties, equality, hashCode, toString, and enum values.
- `test/services/clipboard_scan_service_test.dart`:
  - Tested URL detection, structured barcode payload detection (Wi-Fi, vCard, SMS, Email, Geo, Phone, UPI, 2FA/TOTP, EAN-13, EAN-8), image data URI and file path detection, generic text filtering, and empty clipboard handling.

---

## 3. Verification

- `flutter gen-l10n`: Completed with code 0.
- `flutter test test/models/clipboard_scan_data_test.dart test/services/clipboard_scan_service_test.dart`: Passed (22/22 tests).
- `test/l10n/l10n_parity_test.dart`: Passed with full key parity and zero Hindi markers in Sanskrit.
- `flutter test`: All 322 unit and widget tests passed across the repository.
- `flutter analyze`: Passed with 0 warnings/issues.
- `dart format .`: Formatted code cleanly.
