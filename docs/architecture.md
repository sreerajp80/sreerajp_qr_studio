# Architecture — SreerajP QR Studio

This document defines the technical architecture, data flow, state management, persistence, localization design, and component boundaries for SreerajP QR Studio. Read this before modifying application structure, providers, services, models, or screens.

**Read first:**
- [CLAUDE.md](../CLAUDE.md)
- [AGENTS.md](../AGENTS.md)
- [security.md](security.md)
- [dependencies.md](dependencies.md)
- [workflow_rules.md](workflow_rules.md)
- [guidelines/architecture.md](guidelines/architecture.md)
- [guidelines/flutter_project_engineering_standard.md](guidelines/flutter_project_engineering_standard.md)

---

## 1. Scope

- Product: SreerajP QR Studio
- Repository type: Application
- Engineering standard profiles in force:
  - `Core Baseline`
  - `Production App Extension`
  - `Sensitive Data Extension`
- Platforms: Android only (minSdk 24, targetSdk 36, compileSdk 37)

---

## 2. Goals And Non-Goals

### Goals
- High-speed offline QR code and barcode scanning with camera adjustments (zoom, exposure, flash, camera flip).
- 6-layer URL safety verification (IP-based hostnames, homograph attacks, URL shorteners, tracking parameters, scheme anomalies, and optional Google Safe Browsing API checks).
- In-app sandboxed DOM page preview to inspect links safely before opening them in a browser.
- StegoQR: Detection and AES-256 GCM decryption of hidden encrypted messages protected by passphrases and optional biometric authentication (`local_auth`).
- AirQR: Optical stream transmitter and receiver for high-speed offline, air-gapped data transfer without network or Bluetooth.
- AR CodeVision: Multi-code camera viewfinder HUD that tracks and labels multiple barcodes simultaneously in real time.
- Persistent scan history stored in a local SQLite database with search, export, and encrypted backup/restore.
- Full tri-lingual support: English (`en`), Malayalam (`ml`), and Sanskrit (`sa`) with an in-app language picker.

### Non-Goals
- iOS, desktop, or web support.
- Cloud account sync or user tracking.
- Ad networks or invasive telemetry.

---

## 3. Architecture Summary

The app follows a Tier 1 layer-first structure using Provider (`ChangeNotifier`) for state management. `ScannerScreen` delegates live camera frame decoding to `ScanProvider`, which coordinates URL safety analysis through `UrlSafetyService` and encrypted payload decoding through `EncryptedPayloadService`. Scanned records are persisted locally using SQLite via `HistoryProvider` and `HistoryDatabaseHelper`. Optical streaming is driven by `AirQrProvider`, while multi-target augmented reality labeling is coordinated by `ArCodevisionProvider`. All user-visible strings are loaded through `AppLocalizations` across English, Malayalam, and Sanskrit, supported by custom Sanskrit fallback delegates and runtime language persistence.

---

## 4. Repository Structure

### Structure Tier: Tier 1 (Layer-First)

```text
assets/
|-- config/
|   `-- app_config.json          # About screen metadata (single source of truth)
`-- app_icon.png
lib/
|-- core/
|   |-- config/
|   |   |-- app_config.dart      # AppConfig model & fallback
|   |   `-- config_service.dart  # Config asset loader and version verifier
|   `-- constants/
|       |-- app_constants.dart   # Technical constants
|       `-- build_date.g.dart    # Build timestamp metadata
|-- l10n/
|   |-- app_en.arb               # Template locale (English)
|   |-- app_ml.arb               # Malayalam translation
|   |-- app_sa.arb               # Sanskrit translation
|   |-- sa_material_localizations.dart # Sanskrit framework fallback delegates
|   `-- gen/                     # Generated localization accessors
|-- models/
|   |-- safety_check_result.dart # URL safety evaluation records
|   |-- ghost_scan_capture.dart  # One screen capture (path, fromBubble, blocked)
|   |-- scan_history_item.dart   # Scanned code history model
|   |-- air_qr_frame.dart        # Optical stream frame (data or parity)
|   |-- air_qr_progress.dart     # Receiver progress state
|   `-- smart_action.dart        # Action triggers (Wi-Fi, contacts, UPI, etc.)
|-- providers/
|   |-- scan_provider.dart       # Active scan result and URL analysis state
|   |-- history_provider.dart    # Database scan history state
|   |-- theme_provider.dart      # Theme selection (Light/Dark/OLED/System)
|   |-- air_qr_provider.dart     # Optical transmitter/receiver state
|   |-- ar_codevision_provider.dart # Multi-code tracking state
|   |-- camera_settings_provider.dart # Viewport controls (zoom, brightness)
|   `-- scan_bubble_provider.dart # Floating Scan bubble state
|-- screens/
|   |-- scanner_screen.dart      # Live camera scanning interface
|   |-- result_screen.dart       # Detailed scan analysis and action cards
|   |-- history_screen.dart      # Searchable scan history list
|   |-- air_qr_screen.dart       # Optical receiver interface
|   |-- air_qr_transmitter_screen.dart # Optical transmission interface
|   |-- ar_codevision_screen.dart # AR multi-code HUD viewfinder
|   |-- settings_screen.dart     # App preferences, language picker, API keys
|   |-- scan_bubble_settings_screen.dart # Scan bubble switch, permission, restart option
|   `-- about_screen.dart        # Dynamic about screen with MadeWithLove
|-- services/
|   |-- url_safety_service.dart  # 6-layer URL safety and homograph detection
|   |-- encrypted_payload_service.dart # AES-GCM decryption and biometrics
|   |-- database_helper.dart     # SQLite database migrations and queries
|   |-- ghost_scan_service.dart  # GhostScan screen capture channel
|   |-- scan_bubble_service.dart # Scan bubble overlay channel
|   `-- air_qr_service.dart      # Frame packetizing and LT fountain code (XOR parity) assembly
|-- widgets/
|   |-- made_with_love.dart      # Fixed signature footer badge
|   |-- focus_ring_widget.dart   # Tap-to-focus camera ring animation
|   `-- camera_adjustments_sheet.dart # Viewport controls bottom sheet
`-- main.dart                    # App initialization, Provider tree, MaterialApp
```

---

## 5. State Management

- Pattern: Provider (`ChangeNotifier`).
- State boundaries:
  - `ScanProvider`: Scanned raw value, barcode format, safety analysis results, loading indicators.
  - `HistoryProvider`: SQLite database interactions, search filter query, batch deletion, export.
  - `ThemeProvider`: Material 3 theme mode (`system`, `light`, `dark`, `oled`), dynamic wallpaper color integration.
  - `AirQrProvider`: Frame sequencing, FPS rate, transmission progress, packet assembly.
  - `ArCodevisionProvider`: Real-time bounding boxes, category tagging, HUD coordinates.
  - `CameraSettingsProvider`: Zoom factor, exposure/brightness compensation, torch mode, active camera lens.
  - `ScanBubbleProvider`: Scan bubble on/off, "Display over other apps" permission status, start-after-restart choice. Refreshed when its screen opens or the app resumes, because the bubble can also be turned on/off from the tile, notification, or drag-to-close.

---

## 6. Data Flow

```text
[Camera Viewport]  (camera plugin, CameraX, YUV frames)
       │
       ▼
[ScanCameraController] ── Y plane ──> [BarcodeDecoderService isolate]
       │                                   │ dart:ffi
       │                                   ▼
       │                        [libsreeraj_barcode.so → zxing-cpp]
       ▼
ScanFrameResult (ScannedCode list + upright frame size)
       │
       ▼
[ScanProvider] ──> [UrlSafetyService] (stateless analysis)
       │         ──> [EncryptedPayloadService] (AES/Stego check)
       │         ──> [HistoryProvider] ──> [HistoryDatabaseHelper (SQLite)]
       ▼
[ResultScreen] ──> User Actions (Open URL, Copy, Share, Stego Reveal)
```

---

### Screen scan flow (GhostScan and Scan bubble)

```text
[GhostScan tile] or [Scanner menu] or [Scan bubble tap]   (ScanBubbleService draws the bubble)
       │
       ▼
GhostScanActivity ── Android screen capture consent ──> GhostScanCaptureService (one frame)
       │                                                     │ JPEG in app cache (+ fromBubble, blocked flags)
       ▼                                                     ▼
(cancel → bubble shown again)               MainActivity ── ghost_scan channel ──> GhostScanService
                                                                     │ GhostScanCapture
                                                                     ▼
                                     ScannerScreen → MediaScanService → ScanProvider → HistoryProvider
                                     (metadata source = screen / screen_bubble; cache file deleted)
```

Native pieces (`android/app/src/main/kotlin/`): `ScanBubbleService` (overlay + special-use
foreground service), `ScanBubbleTileService` (Quick Settings toggle), `ScanBubbleShortcutActivity`
(app shortcut and tile starter), `ScanBubbleBootReceiver` (optional restart), `ScanBubblePrefs`
(native on/off flags and position). Dart talks to them over the `in.sreerajp.qr_studio/scan_bubble`
channel through `ScanBubbleService` (Dart).

## 6a. Barcode Decoding Engine

The app decodes codes with its **own** engine. No Google ML Kit or other closed SDK is used.

| Layer | File | Role |
|---|---|---|
| Native | `native/zxing-cpp/` | Vendored zxing-cpp v3.1.1 reader (Apache-2.0), built with writers turned off |
| Native | `native/sreeraj_barcode/` | Our small C bridge: `srb_read`, `srb_free`, `srb_version`. Checks every size, catches every C++ exception, rotates frames without copying, and maps UPC-A/UPC-E back to their short forms |
| Build | `native/CMakeLists.txt` | Builds `libsreeraj_barcode.so` (`-O3`, 16 KB pages, static C++ runtime) from `android/app/build.gradle` |
| Service | `lib/services/barcode_decoder/` | `BarcodeFfiBindings` (hand-written FFI), `NativeBarcodeReader`, and `BarcodeDecoderService`, which runs decoding on one long-lived background isolate |
| Service | `lib/services/barcode_content_classifier.dart` | Offline URL / Wi-Fi / contact / product / ISBN / … classification of decoded text |
| Service | `lib/services/scan_camera/scan_camera_controller.dart` | Owns the `camera` plugin, sends the luminance plane of each frame to the decoder, drops frames while one is being decoded, handles torch, zoom, focus and lens switching |
| Widget | `lib/screens/widgets/scan_camera_view.dart` | Cover-fit camera preview that reports `ScanFrameResult`s |
| Models | `code_format.dart`, `code_content_type.dart`, `scanned_code.dart`, `scan_frame_result.dart`, `decode_profile.dart` | Immutable types that replaced `mobile_scanner`'s `Barcode`, `BarcodeFormat`, `BarcodeType` and `BarcodeCapture` |

Decode profiles: `fast` (AirQR, QR only), `live` (camera, rotated 1D barcodes allowed), `thorough`
(gallery, PDF, share sheet: all passes and all formats). Corner points are always reported in the
upright frame's coordinate space, mirrored for the front camera, so `MultiCodeService` can project
them with `BoxFit.cover`.

Gallery images, PDF pages and distance-enhanced crops are decoded **in memory**; no temporary image
files are written.

---

## 7. Domain Model

- Models are immutable value types with `const` constructors.
- Key models:
  - `SafetyCheckResult`: Outcome of individual URL safety heuristics (pass, warning, danger).
  - `ScanHistoryItem`: Complete snapshot of a scan including timestamp, code format, raw text, and security status.
  - `AirQrFrame`: One optical frame (data slice or XOR parity frame) with CRC32 checksum.
  - `AirQrProgress`: Receiver progress (captured blocks, FPS, status, rebuilt content).
  - `SmartAction`: Parsed payload entity (e.g. Wi-Fi SSID/password, vCard contact, UPI transaction).

---

## 8. Persistence And Storage

- SQLite (`sqflite`): Scan history items stored locally in private application storage.
- KeyStore (`flutter_secure_storage`): Google Safe Browsing API key encrypted via hardware-backed Android KeyStore.
- `SharedPreferences`: Non-sensitive settings:
  - `app_language`: Active locale choice (`system`, `en`, `ml`, `sa`).
  - `theme_mode`: UI appearance (`system`, `light`, `dark`, `oled`).
  - `sound_enabled`, `vibration_enabled`: Scan feedback preferences.
  - `daily_request_counter`: Safe Browsing quota usage tracking.

---

## 9. Localization Architecture

- Every app ships three languages: **English (`en`)**, **Malayalam (`ml`)**, and **Sanskrit (`sa`)**.
- `l10n.yaml` outputs strongly typed `AppLocalizations` to `lib/l10n/gen/`.
- Sanskrit Material/Cupertino Fallback:
  - Flutter does not include built-in `sa` translations.
  - `SaMaterialLocalizationsDelegate`, `SaCupertinoLocalizationsDelegate`, and `SaWidgetsLocalizationsDelegate` answer for `sa` by falling back to English framework strings, preventing runtime crashes during date picking and dialog rendering.
- In-App Language Selection:
  - Configurable in `SettingsScreen`.
  - Persisted under `SharedPreferences` key `app_language`.
  - Drives `MaterialApp.locale` immediately without requiring an application restart.

---

## 10. Navigation

- Approach: Named routes via `Navigator 1.0`.
- Routes registered in `lib/main.dart`:
  - `/`: `ScannerScreen` (Home)
  - `/result`: `ResultScreen`
  - `/history`: `HistoryScreen`
  - `/settings`: `SettingsScreen`
  - `/about`: `AboutScreen`
  - `/air_qr`: `AirQrScreen`
  - `/air_qr_transmitter`: `AirQrTransmitterScreen`
  - `/ar_codevision`: `ArCodevisionScreen`

---

## 11. Testing Strategy

- `test/providers/`: State transition tests for all 6 providers.
- `test/services/`: Unit tests for URL heuristics, homograph attacks, and StegoQR encryption/decryption.
- `test/l10n/`: ARB key parity tests and Sanskrit delegate smoke tests.
- `test/widgets/`: Widget tests covering `MadeWithLove` and icon-only button tooltip presence.
- Mocks: Network calls mocked via `MockClient` from `package:http/testing.dart`; SQLite mocked in headless unit tests using `sqflite_common_ffi`.
