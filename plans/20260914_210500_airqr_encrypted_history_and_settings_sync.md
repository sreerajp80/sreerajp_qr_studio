# AirQR Encrypted History & Settings Sync Plan

**Status:** Approved

## Problem
Currently, users can only back up and restore their scan history by exporting a manual file (JSON/CSV/PDF) or copying encrypted strings. App settings (theme mode, dynamic color, overlay style, language, vibration, sound, active probing, and camera preferences) are not included in backups or transferable between devices. Furthermore, the existing AirQR optical transmitter/receiver pipeline exists for streaming text, but was not connected to history or settings, and the transmitter painted a mock pattern rather than a standard scannable QR code.

## Proposed Fix
Implement complete, air-gapped, zero-network device synchronization over the AirQR optical fountain pipeline. This enables users to beam their encrypted scan history and app settings from one phone to another using animated optical QR streams.

### 1. Dependencies
File: `pubspec.yaml`
- Add `qr_flutter: ^4.1.0` (BSD-3-Clause permissive open-source license, pure Dart, offline-first) so `AirQrTransmitterScreen` displays standard, scannable QR codes.

### 2. Domain Model
File: `lib/models/device_sync_data.dart` (NEW)
- Immutable model representing a complete sync bundle:
  - `records`: `List<ScanRecord>`
  - `settings`: `Map<String, dynamic>` (theme mode, dynamic color, scan overlay style, language, feedback vibration & sound, URL active probing, camera resolution and flash defaults)
  - `exportedAt`: `DateTime`
  - `version`: `int`
- JSON serialization (`toJson`, `fromJson`).

### 3. Service Layer
File: `lib/services/device_sync_service.dart` (NEW)
- `createEncryptedSyncPackage(DeviceSyncData data, String passphrase)`:
  - Encrypts the payload using AES-256 (CBC with SHA-256 derived key).
  - Packages into container `SREERAJ_AIRQR_SYNC_V1` with metadata (records count, settings flag, timestamp) for instant receiver UI preview.
- `decryptSyncPackage(String containerJson, String passphrase)`:
  - Verifies container header (`SREERAJ_AIRQR_SYNC_V1` or legacy `SREERAJ_QR_BACKUP_V1`).
  - Decrypts AES-256 ciphertext and restores `DeviceSyncData`.
- `collectCurrentSettings(SharedPreferences prefs)`:
  - Gathers user preferences safely (excluding sensitive secure-storage credentials).
- `applySettings(Map<String, dynamic> settings, SharedPreferences prefs)`:
  - Restores synced preferences to local storage.

### 4. AirQR Transmitter Screen
File: `lib/screens/air_qr_transmitter_screen.dart`
- Replace mock `AirQrCodePainter` with `QrImageView` from `qr_flutter` to render standard QR frames.
- Add "AirQR Device Sync" mode toggle alongside "Custom Text".
- In Sync mode:
  - Allow user to specify or generate a sync passphrase/PIN.
  - Checkboxes to include Scan History and/or App Settings.
  - One-tap button "Generate & Start Beam" that packages history + settings and streams animated AirQR frames.

### 5. AirQR Receiver Screen
File: `lib/screens/air_qr_screen.dart`
- On reassembling stream completion, detect if payload is an AirQR Sync container (`SREERAJ_AIRQR_SYNC_V1` or `SREERAJ_QR_BACKUP_V1`).
- If sync container detected:
  - Display interactive Sync Restoration Card instead of raw string viewer.
  - Prompt for passphrase.
  - Allow toggling: "Restore Scan History" and "Apply App Settings".
  - On decryption: insert records into database, update preferences, and notify providers (`ThemeProvider`, `LocaleProvider`, `ScanProvider`, `HistoryProvider`).

### 6. History & Settings Entry Points
Files:
- `lib/screens/widgets/export_import_dialog.dart`: Add "Beam via AirQR" action button next to file exports.
- `lib/screens/settings_screen.dart`: Add "AirQR Device Sync" card under settings.

### 7. Localization (Tri-lingual key parity)
Files:
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ml.arb`
- `lib/l10n/app_sa.arb`
- Add localized strings for AirQR sync (titles, descriptions, button labels, toasts) across English, Malayalam, and Sanskrit with zero Hindi markers.
- Run `flutter gen-l10n`.

### 8. Automated Testing & Verification
File: `test/services/device_sync_service_test.dart` (NEW)
- Test sync container creation and encryption.
- Test successful decryption and restoration of history and settings.
- Test wrong passphrase failure handling.
- Test backward compatibility with legacy backup formats.
- Run `flutter analyze` (0 warnings).
- Run `flutter test` (all tests passing).
