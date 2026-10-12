# CodeForge — Standalone QR & Barcode Generator Plan

**Status:** completed

## Problem
Currently, SreerajP QR Reader is primarily a scanner with one-way optical reception (and specialized AirQR text streaming). Users have no built-in suite to create their own QR codes or 1D retail barcodes (Code 128, EAN-13, UPC-A), format rich payloads (Wi-Fi logins, Contact vCards, UPI payments, SMS, Email, Geo), or customize the visual structure of QR codes (eye design, corner design, pattern dots, color themes, gradients, and center badges). Furthermore, the app opens directly into the camera scanner without a root tab navigation to move between scanning, generating, and history.

## Proposed Fix
Implement feature 3.4 from `docs/feature_improvements_and_roadmap.md` — **CodeForge: Standalone QR & Barcode Generator** — as a dedicated root navigation tab alongside Scan and History, with complete visual structure customization for QR codes.

### 1. Root Tab Navigation Shell
File: `lib/screens/main_shell_screen.dart` (NEW)
- Add a root `MainShellScreen` containing a Material 3 `NavigationBar` with 3 primary tabs:
  - Tab 0: **Scan** (`Icons.qr_code_scanner`) -> `ScannerScreen`
  - Tab 1: **CodeForge** (`Icons.qr_code_2`) -> `CodeForgeScreen`
  - Tab 2: **History** (`Icons.history`) -> `HistoryScreen`
- Use an `IndexedStack` to preserve state across tab switches (e.g. user input and custom styling in CodeForge remain intact when briefly switching to History or Scanner).
- Camera lifecycle management:
  - When switching away from Tab 0 (Scan), pause/stop the scanner camera controller so hardware is released and battery is saved.
  - When returning to Tab 0 (Scan), resume the scanner camera controller.
- Update `lib/main.dart` to set `home: const MainShellScreen()` and add `/code_forge` to routes.

### 2. Dependencies
File: `pubspec.yaml`
- Add `barcode: ^2.2.9` (Apache 2.0 license, pure Dart, offline-first 1D/2D barcode generation, already present transitively via `pdf`).
- Update `docs/dependencies.md` recording `barcode` as an approved offline production dependency.

### 3. Domain Models
File: `lib/models/code_forge_config.dart` (NEW)
- `CodeForgeBarcodeType`: `qrCode`, `code128`, `ean13`, `ean8`, `upcA`, `code39`, `pdf417`, `dataMatrix`.
- `CodeForgePayloadType`: `text`, `url`, `wifi`, `contactVCard`, `upiPayment`, `sms`, `email`, `geo`.
- `QrPatternShape`: `square`, `dots`, `rounded`, `classy`, `diamond`.
- `QrEyeShape`: `square`, `rounded`, `circle`, `leaf`.
- `QrEyeBallShape`: `square`, `rounded`, `circle`, `diamond`.
- `QrCenterBadge`: `none`, `payloadIcon`, `shieldVerified`.
- `CodeForgeConfig`: immutable configuration model with:
  - Barcode type and payload type.
  - Raw payload data and structured form fields.
  - QR visual styling: pattern shape, eye outer frame shape, eye inner ball shape.
  - Color palette: foreground color, background color, eye outer color, eye inner color.
  - Gradient styling: optional linear gradient (Sunset, Ocean, Neon, Royal Gold).
  - Error correction level: L (7%), M (15%), Q (25%), H (30%).
  - Center badge selection and size.

### 4. Service Layer
File: `lib/services/code_forge_service.dart` (NEW)
- Payload encoding:
  - Wi-Fi: `WIFI:T:<WPA|WEP|nopass>;S:<ssid>;P:<password>;H:<true|false>;;`
  - Contact vCard: standard 3.0 vCard (`BEGIN:VCARD...FN:...TEL:...EMAIL:...END:VCARD`).
  - UPI Payment: `upi://pay?pa=<vpa>&pn=<name>&am=<amount>&tn=<note>&cu=INR`.
  - SMS: `smsto:<phone>:<message>`.
  - Email: `mailto:<email>?subject=<subject>&body=<body>`.
  - Geo: `geo:<lat>,<lng>`.
- 1D/2D Barcode generation:
  - Generates barcode paths and geometries using `package:barcode/barcode.dart` for Code 128, EAN-13, EAN-8, UPC-A, Code 39, PDF417, and Data Matrix.
- QR Matrix calculation:
  - Uses `package:qr/qr.dart` (`QrCode`, `QrImage`) to generate the module matrix with user-selected error correction level.
- Vector SVG export:
  - Generates standalone valid SVG markup for both styled QR codes and 1D barcodes.
- High-Resolution PNG export & sharing:
  - Renders the custom painted code at 1024x1024 or 2048x2048 to PNG image bytes.
  - Saves to temporary directory and invokes `share_plus` (`Share.shareXFiles`).
- Pre-flight URL Safety Verification:
  - When the generated payload is a URL, provides a direct check against `UrlSafetyService` so users can verify link safety before sharing or printing.

### 5. Custom QR Painter & Barcode Widgets
Files:
- `lib/widgets/code_forge_qr_painter.dart` (NEW):
  - Canvas painter rendering:
    - Data modules: square, circular dots, rounded rectangles, classy connected/diamond.
    - 3 Corner Finder Patterns (Eyes): outer frame (square, rounded rect, circle, leaf) and inner ball (square, rounded rect, circle, diamond).
    - Finder patterns use custom eye colors or blend with foreground.
    - Supports solid colors and linear gradients across data modules.
    - Quiet zone padding and center badge cutout protection.
- `lib/widgets/code_forge_barcode_widget.dart` (NEW):
  - Canvas painter for 1D barcodes (Code 128, EAN, UPC) with human-readable text footer.

### 6. Provider Layer
File: `lib/providers/code_forge_provider.dart` (NEW)
- Manages:
  - Active `CodeForgeConfig`.
  - Form field controllers and payload state.
  - Active barcode type and payload preset.
  - Safety check result for URL payloads.
  - Export status (busy, error, success).
- Registered in `lib/main.dart` under `MultiProvider`.

### 7. CodeForge Screen
File: `lib/screens/code_forge_screen.dart` (NEW)
- Clean, responsive Material 3 layout:
  - **Top Bar**: Format selector chip carousel (QR Code, Code 128, EAN-13, UPC-A, etc.).
  - **Live Code Card**:
    - Real-time responsive visual preview of the styled QR code or barcode.
    - Safety badge if verified safe.
    - Quick actions: Share, Save PNG, Copy Payload, Safety Check.
  - **Payload Input Section**:
    - Preset chips: Text/URL, Wi-Fi, vCard, UPI, SMS, Email, Geo.
    - Adaptive input forms based on active preset (e.g. SSID + Password for Wi-Fi, Name + VPA + Amount for UPI).
  - **QR Design & Structure Studio** (collapsible / segmented):
    - Eye Outer Design: Square, Rounded, Circle, Leaf.
    - Eye Inner Ball Design: Square, Rounded, Circle, Diamond.
    - Pattern Design: Square, Circular Dots, Squircles, Classy.
    - Color Studio: Foreground, Background, Eye Colors, Gradient themes (Sunset, Ocean, Neon, Gold).
    - Error Correction Level: L, M, Q, H.
    - Center Badge: None, Type Icon, Verified Shield.
  - **Export Action Buttons**:
    - Export PNG (High-Res).
    - Export SVG (Vector).
    - Share via Android sheet.

### 8. Localization (English, Malayalam, Sanskrit)
Files:
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ml.arb`
- `lib/l10n/app_sa.arb`
- Add localized strings for tabs, barcode types, payload presets, eye shapes, pattern shapes, color labels, export actions, and error messages across all 3 languages.
- Strictly enforce Sanskrit rules (zero Hindi copulas/markers) and natural Malayalam.
- Run `flutter gen-l10n`.

### 9. Documentation Updates
Files:
- `docs/dependencies.md`
- `docs/feature_improvements_and_roadmap.md` (mark 3.4 as implemented)

### 10. Automated Tests & Verification
Files:
- `test/services/code_forge_service_test.dart` (NEW)
- `test/models/code_forge_config_test.dart` (NEW)
- `test/providers/code_forge_provider_test.dart` (NEW)
- `test/screens/main_shell_screen_test.dart` (NEW)
- Parity & Sanskrit quality tests.
- Static analysis (`flutter analyze` with 0 warnings).
- Unit tests (`flutter test` with 100% pass).
