# Change Log: Bring Project Documentation into Strict Adherence with Guidelines

## Metadata
- **Date:** 2026-09-14
- **Plan Reference:** `plans/20260914_195500_project_docs_guidelines_adherence.md`
- **Scope:** Project documentation (`CLAUDE.md`, `AGENTS.md`, `docs/`)

---

## 1. Summary of Changes

Updated project documentation and root instruction files to strictly adhere to the authoritative guidelines in `docs/guidelines/`:

1. **`CLAUDE.md` and `AGENTS.md`**:
   - Replaced the outdated single-language exception (*"This applies even though the app ships English only"*) with the mandatory tri-lingual standard (English `en`, Malayalam `ml`, and Sanskrit `sa`) per `guideline.md` §3 and `flutter_project_engineering_standard.md` §8.
   - Added explicit rules requiring ARB key parity, Sanskrit framework fallback delegates (`SaMaterialLocalizationsDelegate`), in-app language picker in Settings (`app_language` in `SharedPreferences`), and tooltip coverage for icon buttons.
   - Updated the Project identity table to reflect the current feature set, supported languages (`en`, `ml`, `sa`), and SQLite scan history database.
   - Kept both root instruction files in exact 1-to-1 lockstep.

2. **`docs/GUIDELINES_MANIFEST.md`**:
   - Synchronized with `docs/guidelines/GUIDELINES_MANIFEST.md`, adding pointer rows for `CLAUDE_MD_GUIDELINE.md`, `AGENTS_MD_GUIDELINE.md`, `DOCS_FOLDER_GUIDELINE.md`, and the 3 mandatory languages.

3. **`docs/architecture.md`**:
   - Updated architecture profile to include `Core Baseline`, `Production App Extension`, and `Sensitive Data Extension`.
   - Updated top-level source layout and ownership rules for all 6 providers (`ScanProvider`, `HistoryProvider`, `ThemeProvider`, `AirQrProvider`, `ArCodevisionProvider`, `CameraSettingsProvider`).
   - Documented the local SQLite database architecture (`sqflite`), StegoQR biometrics & encryption, AirQR optical stream engine, and AR CodeVision tracking.
   - Added Section 9 on Localization Architecture detailing the 3 locales, fallback delegates, and language persistence.

4. **`docs/dependencies.md`**:
   - Cataloged all 23 production dependencies and 3 development dependencies currently in `pubspec.yaml`, providing purpose, license, and security/privacy notes for each.

5. **`docs/release_process.md`**:
   - Updated the release version to `2.8.1+21`.
   - Updated production release build commands with mandatory obfuscation and symbol splitting flags (`--obfuscate --split-debug-info=build/symbols/android-prod/ --split-per-abi`).
   - Added localization verification steps to the release checklist (key parity across `en`, `ml`, `sa`, no untranslated text, no Hindi markers).

6. **`docs/security.md`**:
   - Updated security scope to include `Sensitive Data Extension` for StegoQR encryption and biometrics.
   - Documented AES-256 GCM encryption and PBKDF2 key derivation for StegoQR payloads.
   - Documented biometric authentication flow using `local_auth`.
   - Documented SQLite database security and scoped storage.

7. **`docs/project_structure.md`**:
   - Updated directory tree layout and responsibility mapping to accurately reflect all current code files, screens, providers, widgets, and services.

---

## 2. Files Modified

- `CLAUDE.md`
- `AGENTS.md`
- `docs/GUIDELINES_MANIFEST.md`
- `docs/architecture.md`
- `docs/dependencies.md`
- `docs/release_process.md`
- `docs/security.md`
- `docs/project_structure.md`
- `plans/20260914_195500_project_docs_guidelines_adherence.md`

---

## 3. Verification

- Ran `flutter analyze`: 0 issues found.
- Ran `flutter test`: 182 tests passed (100%).
- Ran `dart format --output=none --set-exit-if-changed .`: all formatted cleanly.
