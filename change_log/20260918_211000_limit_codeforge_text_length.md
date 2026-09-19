# Change Log: Limit Text Length in CodeForge for Proper QR Generation

**Plan:** `plans/20260918_211000_limit_codeforge_text_length.md`

**Date:** 2026-09-18

---

## Changes

### 1. Constant Definition

**File:** `lib/core/constants/app_constants.dart`
- Added `maxCodeForgeTextLength = 500`.

### 2. Service Validation

**File:** `lib/services/code_forge_service.dart`
- In `validateContent()`, added a length check for QR code text presets against `AppConstants.maxCodeForgeTextLength` (500 characters).

### 3. Screen Text Input Limits and Live Counter

**File:** `lib/screens/code_forge_screen.dart`
- Separated `CodeForgePayloadType.text` from `CodeForgePayloadType.url`.
- Configured text `TextField` with `maxLines: 4`, `maxLength: AppConstants.maxCodeForgeTextLength`, `maxLengthEnforcement: MaxLengthEnforcement.enforced`, and `helperText: l10n.codeForgeTextHint`.
- Input displays live character counter and cleanly blocks inputs beyond 500 characters.

### 4. Tri-lingual Localization

**Files:**
- `lib/l10n/app_en.arb` — Added `codeForgeTextHint` with `@codeForgeTextHint` context description.
- `lib/l10n/app_ml.arb` — Added Malayalam translation for `codeForgeTextHint`.
- `lib/l10n/app_sa.arb` — Added Sanskrit translation for `codeForgeTextHint`.

### 5. Automated Tests

**File:** `test/services/code_forge_service_test.dart`
- Added test cases verifying that plain text QR configurations with <= 500 characters pass validation and > 500 characters fail validation.

---

## Verification

- `flutter gen-l10n` — Succeeded without errors.
- `flutter test test/services/code_forge_service_test.dart` — All 10 tests passed.
- `flutter analyze` — Clean, 0 issues found.
- `dart format .` — Code formatted cleanly.
