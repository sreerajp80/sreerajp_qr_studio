# Change Log: Camera Sheet Nav Bar Fix, GPS Location Button, UPI Verification

**Plan:** `plans/20260918_203400_camera_sheet_gps_upi_fixes.md`

**Date:** 2026-09-18

---

## Changes

### Issue 1 — Camera Settings Sheet Hidden Under Navigation Bar

**File:** `lib/widgets/camera_adjustments_sheet.dart`

- Added `MediaQuery.of(context).viewPadding.bottom` to the bottom padding calculation.
- The sheet now clears both the software keyboard (`viewInsets`) and the system navigation bar (`viewPadding`).

### Issue 2 — GPS "Use My Location" Button for CodeForge Geo Preset

**Files changed:**
- `pubspec.yaml` — Added `geolocator: ^14.0.2` dependency.
- `android/app/src/main/AndroidManifest.xml` — Added `ACCESS_FINE_LOCATION` and `ACCESS_COARSE_LOCATION` permissions.
- `lib/l10n/app_en.arb` — Added 4 new keys: `codeForgeGeoUseMyLocation`, `codeForgeGeoFetching`, `codeForgeGeoFailed`, `codeForgeGeoPermissionDenied`.
- `lib/l10n/app_ml.arb` — Added Malayalam translations for the 4 keys.
- `lib/l10n/app_sa.arb` — Added Sanskrit translations for the 4 keys.
- `lib/screens/code_forge_screen.dart` — Added imports for `geolocator` and `permission_handler`. Added `_isFetchingLocation` state flag. Changed the geo form from a flat `Row` to a `Column` with the lat/lng row plus a full-width "Use My Location" `OutlinedButton.icon`. Added `_fetchCurrentLocation()` method that requests location permission at point of use, fetches GPS position with high accuracy, and auto-fills the lat/lng text fields and provider state.

### Issue 3 — UPI QR Code Format

No changes. The existing `upi://pay?pa=...&pn=...&am=...&tn=...&cu=INR` format in `lib/services/code_forge_service.dart` already follows the NPCI UPI Deep Linking Specification.

---

## Verification

- `flutter pub get` — Success.
- `flutter gen-l10n` — Success.
- `flutter analyze` — No issues found.
