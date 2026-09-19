# Plan: Limit Text Length in CodeForge for Proper QR Generation

**Status:** Approved

**Date:** 2026-09-18

---

## Issue

In CodeForge, the text payload preset allows unrestricted text input without any character limit or counter.
When users enter or paste lengthy text:
1. The generated QR code becomes overly dense with tiny data modules (high QR version).
2. Mobile camera sensors struggle to focus and scan such dense QR codes reliably.
3. If the input exceeds the byte capacity of QR version 40, QR matrix generation fails.

---

## Files to Change

- `lib/core/constants/app_constants.dart` — Add `maxCodeForgeTextLength = 500` constant.
- `lib/services/code_forge_service.dart` — Validate that text payload does not exceed `AppConstants.maxCodeForgeTextLength`.
- `lib/screens/code_forge_screen.dart` — Separate `CodeForgePayloadType.text` and `CodeForgePayloadType.url` fields in `_buildFormFieldsForPreset`; add `maxLength`, `maxLengthEnforcement`, and helper text for text mode.
- `lib/l10n/app_en.arb` — Add `codeForgeTextHint` with `@codeForgeTextHint` description.
- `lib/l10n/app_ml.arb` — Add Malayalam translation for `codeForgeTextHint`.
- `lib/l10n/app_sa.arb` — Add Sanskrit translation for `codeForgeTextHint`.
- `test/services/code_forge_service_test.dart` — Add unit test verifying that text over 500 characters fails validation and text under 500 characters passes.

---

## Fix

1. **Constant:** Define `maxCodeForgeTextLength = 500` in `AppConstants`. 500 characters allows a comprehensive paragraph or multi-line message while keeping the QR code version around 15–18 (~81x81 modules), ensuring crisp rendering and fast, reliable scanning across all camera lenses.
2. **Service Validation:** In `CodeForgeService.validateContent`, check if payload type is `text` and text length exceeds 500 characters, returning a friendly validation error message.
3. **UI Limit & Feedback:** In `CodeForgeScreen`, set `maxLength: AppConstants.maxCodeForgeTextLength` and `maxLengthEnforcement: MaxLengthEnforcement.enforced` on the text `TextField`. This displays a character counter (e.g. `120/500`) and cleanly prevents text overflow.
4. **Tri-lingual Localization:** Add `codeForgeTextHint` across English, Malayalam, and Sanskrit ARB files to provide guidance under the text input.
5. **Testing:** Add unit tests to ensure validation rules enforce the length boundary.
