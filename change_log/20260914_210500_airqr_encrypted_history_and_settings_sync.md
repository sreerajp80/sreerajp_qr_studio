# AirQR Encrypted History & Settings Sync Change Log

**Reference Plan:** [plans/20260914_210500_airqr_encrypted_history_and_settings_sync.md](plans/20260914_210500_airqr_encrypted_history_and_settings_sync.md)

## Summary of Changes
Implemented air-gapped device synchronization over the AirQR optical fountain pipeline. Users can now beam their encrypted scan history and application settings from one phone to another without Wi-Fi, Bluetooth, or cables.

## Key Changes Made

### 1. Dependency Integration
- **`pubspec.yaml`**: Added `qr_flutter: ^4.1.0` (permissive BSD-3-Clause open-source package, pure Dart, offline-first) to generate standard ISO/IEC 18004 QR frames.
- **`docs/dependencies.md`**: Documented `qr_flutter` in the approved dependencies table.

### 2. Domain Model & Encryption Services
- **`lib/models/device_sync_data.dart`**: Created immutable `DeviceSyncData` container bundling scan records and app configuration (theme mode, dynamic color, overlay style, language, feedback vibration & sound, active probing, and camera defaults).
- **`lib/services/device_sync_service.dart`**: Implemented `DeviceSyncService` providing:
  - AES-256 (CBC with SHA-256 derived key) encryption into `SREERAJ_AIRQR_SYNC_V1` container.
  - Header inspection providing record count and settings summary prior to decryption.
  - Decryption and validation with fallback support for legacy `SREERAJ_QR_BACKUP_V1` files.
  - Safe collection and application of user preferences from/to `SharedPreferences`.

### 3. AirQR Transmitter Screen
- **`lib/screens/air_qr_transmitter_screen.dart`**:
  - Replaced custom mock painter with `QrImageView` for standard, scannable QR frame rendering.
  - Added a "Device Sync" mode tab alongside "Custom Text".
  - Provided PIN/passphrase generation, history and settings selection toggles, and instant stream encoding.

### 4. AirQR Receiver Screen
- **`lib/screens/air_qr_screen.dart`**:
  - Automatically detects when a received stream is an AirQR Sync container.
  - Replaces raw text viewer with an interactive Sync Restoration Card.
  - Prompts for decryption passphrase and allows choosing whether to restore history, apply app settings, or both.
  - Immediately applies settings to active providers (`ThemeProvider`, `LocaleProvider`, `ScanProvider`) without restart.

### 5. UI Entry Points
- **`lib/screens/widgets/export_import_dialog.dart`**: Added "Beam via AirQR" action button in History Export dialog and "Scan with AirQR" in restore mode.
- **`lib/screens/settings_screen.dart`**: Added "AirQR Optical Sync" navigation card under Settings.

### 6. Localization
- **`lib/l10n/app_en.arb`**, **`lib/l10n/app_ml.arb`**, **`lib/l10n/app_sa.arb`**: Added localized strings across English, Malayalam, and Sanskrit with full key parity and no Hindi markers in Sanskrit.
- Ran `flutter gen-l10n`.

### 7. Verification & Automated Tests
- **`test/services/device_sync_service_test.dart`**: Added 8 unit tests covering container serialization, AES-256 encryption/decryption, wrong passphrase handling, legacy format compatibility, and settings application.
- Ran `flutter analyze` (0 errors, 0 warnings).
- Ran `flutter test` (all 235 unit and widget tests passed).
- Updated roadmap item 2.5.3 in `docs/feature_improvements_and_roadmap.md`.
