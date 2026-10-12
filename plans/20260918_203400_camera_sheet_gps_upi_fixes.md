# Plan: Fix Camera Sheet Overlap, Add GPS Location, Verify UPI Format

**Status:** completed

**Date:** 2026-09-18

---

## Issue

Three items reported by the user:

1. The camera settings bottom sheet content is hidden behind the Android navigation bar.
2. The CodeForge Location (Geo) preset only allows manual lat/lng entry — user wants a "Use My Location" button to fetch GPS coordinates.
3. User asked whether the UPI QR code format is correct.

---

## Files to Change

### Issue 1 — Camera Sheet Nav Bar Fix
- `lib/widgets/camera_adjustments_sheet.dart` — Add `viewPadding.bottom` to the bottom padding calculation.

### Issue 2 — GPS Location Button
- `pubspec.yaml` — Add `geolocator` dependency.
- `android/app/src/main/AndroidManifest.xml` — Add `ACCESS_FINE_LOCATION` and `ACCESS_COARSE_LOCATION` permissions.
- `lib/l10n/app_en.arb` — Add four new localization keys for the GPS button.
- `lib/l10n/app_ml.arb` — Add corresponding Malayalam translations.
- `lib/l10n/app_sa.arb` — Add corresponding Sanskrit translations.
- `lib/screens/code_forge_screen.dart` — Add a "Use My Location" button with GPS icon to the geo preset form.

### Issue 3 — UPI QR Code
- No file changes. The existing `upi://pay?pa=...&pn=...&am=...&tn=...&cu=INR` format follows the NPCI deep link specification.

---

## Fix

1. **Camera sheet:** The bottom padding uses `viewInsets.bottom` (keyboard height) but ignores `viewPadding.bottom` (nav bar height). Adding `viewPadding.bottom` to the padding fixes the overlap.

2. **GPS button:** Add the `geolocator` package (BSD-3-Clause, open source) to get device GPS coordinates. Add location permissions to AndroidManifest. Add a GPS icon button in the geo form that requests permission at point of use and auto-fills lat/lng.

3. **UPI format:** Already correct. The generated URL matches the NPCI UPI Deep Linking Specification with all required (`pa`, `cu`) and recommended (`pn`, `am`, `tn`) parameters.
