# Plan: Scan From Clipboard

**Status:** completed

**Date:** 2026-09-19

---

## 1. Issue & Context

Currently, the scanner screen supports camera scanning, gallery image picking, and PDF document picking. When users copy links, raw barcode payloads (such as Wi-Fi credentials, vCards, UPI payment strings, or ISBNs), or QR code images in messaging apps (like WhatsApp, Telegram, Slack) or web browsers, they must either save images to disk or paste URLs into external tools.

Feature roadmap item 2.1.3 requires:
> "Detect if system clipboard contains an image, URL, or raw barcode payload and offer a quick 'Scan from Clipboard' button on the scanner screen."

---

## 2. Proposed Changes

### Domain Models
- `lib/models/clipboard_scan_data.dart`:
  - Create immutable model `ClipboardScanData` (`type`, `content`, `barcodeType`, `preview`).
  - Enum `ClipboardContentType` (`url`, `barcodePayload`, `image`, `text`).

### Native Platform Integration
- `android/app/src/main/kotlin/in/sreerajp/qr_reader/MainActivity.kt`:
  - Add method channel `in.sreeraj.qr_reader/clipboard`.
  - Handle `getClipboardImage`: Check Android `ClipboardManager` for `image/*` MIME type or content URI, copy stream to a temporary cache file, and return the absolute path.

### Services
- `lib/services/clipboard_scan_service.dart`:
  - Create `ClipboardScanService`:
    - `checkClipboard({bool includeGenericText = false})`:
      - Query native platform channel for copied images.
      - Query Flutter `Clipboard.getData(Clipboard.kTextPlain)`.
      - Check for base64 image data URIs (`data:image/...;base64,...`) and local image file paths.
      - Check for URLs (`http://`, `https://`, custom URI schemes).
      - Check for structured barcode payloads (`WIFI:`, `BEGIN:VCARD`, `MECARD:`, `otpauth:`, `geo:`, `upi:`, `SMSTO:`, `mailto:`, `tel:`, retail barcodes/ISBN, StegoQR) using `PayloadParserService`.
      - Return structured `ClipboardScanData?` or `null`.
    - Pure Dart service: zero `BuildContext`, zero UI strings, safe error handling.

### Localization
- `lib/l10n/app_en.arb`:
  - Add keys with `@key` translator descriptions:
    - `scanFromClipboard`: "Scan from Clipboard"
    - `clipboardBannerTitle`: "Clipboard content detected"
    - `clipboardActionScan`: "Scan Now"
    - `clipboardDismiss`: "Dismiss"
    - `clipboardEmptyMessage`: "Clipboard is empty"
    - `clipboardNoValidContent`: "No scannable link, code, or image found in clipboard"
    - `clipboardTypeUrl`: "URL"
    - `clipboardTypeBarcode`: "Barcode Payload"
    - `clipboardTypeImage`: "Image"
    - `clipboardTypeText`: "Text"
- `lib/l10n/app_ml.arb`:
  - Add Malayalam translations with full key parity.
- `lib/l10n/app_sa.arb`:
  - Add Sanskrit translations adhering to §8.5 (pure authentic Sanskrit, zero Hindi markers).

### UI & Scanner Screen
- `lib/screens/scanner_screen.dart`:
  - Integrate `ClipboardScanService`.
  - Check clipboard on initial load, app resume (`didChangeAppLifecycleState`), and returning from other screens (`didPopNext`).
  - Display a floating quick-action pill/chip on the scanner viewfinder when scannable clipboard content is detected.
  - Provide a dismiss button to hide the banner and avoid re-prompting for the same content.
  - Add an on-demand "Scan from Clipboard" icon button in the AppBar actions suite.
  - Route execution:
    - For images: call `_scanImagePath(path)`.
    - For URLs / barcodes / text: call `_processSingleBarcode(content, barcodeType)` (or add to batch if batch scan mode is active).

### Roadmap Documentation
- `docs/feature_improvements_and_roadmap.md`:
  - Update row 2.1.3 to mark "Scan From Clipboard" as completed.

### Testing
- `test/models/clipboard_scan_data_test.dart`:
  - Unit tests for model construction, properties, and enum values.
- `test/services/clipboard_scan_service_test.dart`:
  - Unit tests for URL detection, structured barcode payload detection (WiFi, vCard, UPI, OTP, etc.), image data URI detection, generic text filtering, and empty clipboard handling.

---

## 3. Verification

1. `flutter gen-l10n` to compile new localization keys.
2. `flutter test test/services/clipboard_scan_service_test.dart` to verify clipboard detection logic.
3. `flutter test test/l10n/l10n_parity_test.dart` to ensure ARB key parity and Hindi marker gate compliance.
4. `flutter test` to ensure all existing unit and widget tests pass with zero regressions.
5. `flutter analyze` to ensure zero static analysis warnings.
6. `dart format .` to maintain code formatting.
