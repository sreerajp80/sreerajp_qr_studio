# Plan: Read File to Generate Single QR Code

**Status:** completed

**Date:** 2026-09-19

---

## 1. Issue

Users currently have to type or paste text manually into CodeForge to generate a plain text QR code. There is no direct way to load text from a file (e.g. `.txt`, `.csv`, `.json`, `.md`). Furthermore, large text makes QR codes dense and hard to scan, slowing down optical sharing. The app must ensure that any text loaded from a file does not exceed the capacity for fast, reliable single QR code sharing (`AppConstants.maxCodeForgeTextLength` = 500 characters).

---

## 2. Proposed Changes

### Domain Models & Messages
- `lib/models/app_message.dart`:
  - Add keys to `AppMessageKey`: `codeForgeFileEmpty`, `codeForgeFileTruncated`, `codeForgeFileLoaded`, `codeForgeFileReadError`.

### Services
- `lib/services/code_forge_service.dart`:
  - Add immutable `CodeForgeFileReadResult` class (`content`, `wasTruncated`, `message`, `isSuccess`).
  - Add `readTextFromFile(String filePath, {int maxLength = AppConstants.maxCodeForgeTextLength})` to parse text, validate size, and truncate if greater than 500 characters.
  - Add `pickAndReadTextFile({int maxLength = AppConstants.maxCodeForgeTextLength})` using `FilePicker.platform.pickFiles` with allowed text extensions (`txt`, `csv`, `json`, `md`, `log`, `xml`, `yaml`, `yml`).

### Localization
- `lib/l10n/app_message_text.dart`:
  - Connect new `AppMessageKey` values to `AppLocalizations`.
- `lib/l10n/app_en.arb`:
  - Add English strings and `@key` descriptions:
    - `codeForgeLoadFromFile`: "Read from file"
    - `codeForgeLoadFromFileTooltip`: "Read text from a file into the QR code generator"
    - `codeForgeFileEmpty`: "The selected file is empty."
    - `codeForgeFileTruncated`: "Text was trimmed to 500 characters to fit in a single, fast-scanning QR code."
    - `codeForgeFileLoaded`: "Text loaded from file successfully."
    - `codeForgeFileReadError`: "Unable to read the selected file."
- `lib/l10n/app_ml.arb`:
  - Add Malayalam translations for all new keys.
- `lib/l10n/app_sa.arb`:
  - Add Sanskrit translations for all new keys adhering to zero-Hindi-markers rule.

### Screens & UI
- `lib/screens/code_forge_screen.dart`:
  - In `_buildFormFieldsForPreset()` under `CodeForgePayloadType.text`, add a "Read from file" button with tooltip.
  - Call `_service.pickAndReadTextFile()`.
  - Update `_rawContentController` and `provider.updateRawContent()`.
  - Display feedback to the user via floating `SnackBar` using `appMessageText()`.

### Unit Tests
- `test/services/code_forge_service_test.dart`:
  - Test `readTextFromFile` with:
    - Normal text (<= 500 characters).
    - Long text (> 500 characters), verifying truncation to 500 characters and `wasTruncated == true`.
    - Empty file, verifying `codeForgeFileEmpty`.
    - Non-existent file, verifying error handling.

---

## 3. Verification

1. `flutter gen-l10n` to rebuild localization classes.
2. `flutter test test/services/code_forge_service_test.dart` to verify unit tests.
3. `flutter test` to ensure no regression across the test suite.
4. `flutter analyze` to ensure zero warnings/errors.
5. `dart format .` to maintain code formatting.
