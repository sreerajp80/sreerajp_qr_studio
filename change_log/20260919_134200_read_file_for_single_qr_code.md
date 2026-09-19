# Change Log: Read File to Generate Single QR Code

**Plan:** `plans/20260919_133300_read_file_for_single_qr_code.md`

**Date:** 2026-09-19

---

## Changes

### 1. Domain Models & Messages

**File:** `lib/models/app_message.dart`
- Added `codeForgeFileEmpty`, `codeForgeFileTruncated`, `codeForgeFileLoaded`, and `codeForgeFileReadError` to `AppMessageKey`.

### 2. Service Implementation

**File:** `lib/services/code_forge_service.dart`
- Defined immutable `CodeForgeFileReadResult` holding `content`, `wasTruncated`, `message`, and `isSuccess`.
- Implemented `readTextFromFile(String filePath, {int maxLength = AppConstants.maxCodeForgeTextLength})` to read text files, validate content, and enforce the 500-character single QR code limit. If text exceeds 500 characters, it is trimmed to the first 500 characters and flagged with `wasTruncated = true`.
- Implemented `pickAndReadTextFile({int maxLength = AppConstants.maxCodeForgeTextLength})` utilizing `FilePicker.platform.pickFiles` with allowed text extensions (`txt`, `csv`, `json`, `md`, `log`, `xml`, `yaml`, `yml`).

### 3. Screen & UI Integration

**File:** `lib/screens/code_forge_screen.dart`
- Added a "Read from file" button (`OutlinedButton.icon`) with localized tooltip `codeForgeLoadFromFileTooltip` in the text preset form field section of `CodeForgeScreen`.
- Added `_handleLoadFromFile` method which triggers `pickAndReadTextFile()`, populates the text controller, updates `CodeForgeProvider`, and shows feedback via floating `SnackBar` using `appMessageText`.

### 4. Localization (Tri-lingual Standard)

**Files:**
- `lib/l10n/app_message_text.dart` — Mapped the new `AppMessageKey` values to `AppLocalizations`.
- `lib/l10n/app_en.arb` — Added English strings and `@key` descriptions for `codeForgeLoadFromFile`, `codeForgeLoadFromFileTooltip`, `codeForgeFileEmpty`, `codeForgeFileTruncated`, `codeForgeFileLoaded`, and `codeForgeFileReadError`.
- `lib/l10n/app_ml.arb` — Added Malayalam translations for all new keys.
- `lib/l10n/app_sa.arb` — Added Sanskrit translations adhering strictly to the zero-Hindi-markers standard.

### 5. Automated Unit & Integration Tests

**File:** `test/services/code_forge_service_test.dart`
- Added unit tests for `readTextFromFile`:
  - Reading a file with content <= 500 characters.
  - Truncating a file with content > 500 characters and setting `wasTruncated = true`.
  - Handling empty or whitespace-only files.
  - Handling non-existent files.

---

## Verification

- `flutter gen-l10n` — Successfully regenerated localization code.
- `flutter test test/services/code_forge_service_test.dart` — All 14 tests passed.
- `flutter test test/l10n/l10n_parity_test.dart` — All 5 localization parity and Hindi marker tests passed.
- `flutter test` — All 300 tests passed.
- `flutter analyze` — Clean, 0 issues found.
- `dart format --output=none --set-exit-if-changed .` — Clean formatting across all 166 files.
