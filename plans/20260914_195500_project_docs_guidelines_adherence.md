# Plan: Bring Project Documentation into Strict Adherence with Guidelines

**Status:** completed

## Problem Statement

A review of project documentation against the authoritative guidelines in `docs/guidelines/` (`guideline.md`, `flutter_project_engineering_standard.md`, `DOCS_FOLDER_GUIDELINE.md`, `CLAUDE_MD_GUIDELINE.md`, and `AGENTS_MD_GUIDELINE.md`) revealed significant drift and contradictions:

1. **`CLAUDE.md` and `AGENTS.md`**:
   - Both contain the statement: *"This applies even though the app ships English only."* This directly contradicts `guideline.md` §3 and `flutter_project_engineering_standard.md` §8, which mandate that every app ships three languages: English (`en`), Malayalam (`ml`), and Sanskrit (`sa`).
   - Missing required rules for the Sanskrit fallback delegates (`SaMaterialLocalizationsDelegate`), in-app language picker (`app_language` in `SharedPreferences`), and key parity.
   - Identity table does not list supported languages or full feature capabilities.

2. **`docs/GUIDELINES_MANIFEST.md`**:
   - Out of sync with `docs/guidelines/GUIDELINES_MANIFEST.md`. Lacks entries for `CLAUDE_MD_GUIDELINE.md`, `AGENTS_MD_GUIDELINE.md`, `DOCS_FOLDER_GUIDELINE.md`, and the three mandatory languages definition.

3. **`docs/architecture.md`**:
   - Outdated; still describes the initial 4-screen prototype. Omits SQLite history database (`sqflite`), StegoQR biometrics & encryption, AirQR optical transmission, AR CodeVision tracking, modern providers, and the localization architecture.

4. **`docs/dependencies.md`**:
   - Only lists 9 original dependencies. Missing approved packages added for biometrics, encryption, database, PDF, media picking, and dynamic theming (`local_auth`, `encrypt`, `pointycastle`, `sqflite`, `crypto`, `pdf`, `image_picker`, `file_picker`, `pdfx`, `dynamic_color`, `receive_sharing_intent`, etc.).

5. **`docs/release_process.md`**:
   - Records outdated version `1.4.3+1` instead of current `2.8.1+21`.
   - Build commands omit mandatory obfuscation and symbol splitting flags (`--obfuscate --split-debug-info=...`) required by `guideline.md` §2.4.
   - Checklist lacks localization parity and Sanskrit/Malayalam quality checks.

6. **`docs/security.md`**:
   - States "No custom cryptography" and "Data sensitivity level: low", omitting StegoQR encryption (AES-256 / PBKDF2), biometric access control, and encrypted scan history database.

7. **`docs/project_structure.md`**:
   - Omits modern screens, providers, widgets, and database helpers.

## Proposed Changes

### 1. Root Instruction Files (`CLAUDE.md` & `AGENTS.md`)
- Update Localization rules:
  - Remove "This applies even though the app ships English only."
  - Enforce the three mandatory languages: English (`en`), Malayalam (`ml`), and Sanskrit (`sa`).
  - Specify ARB key parity, `@key` descriptions, Sanskrit fallback delegates, and in-app language selection.
- Update Project identity table with supported locales (`en`, `ml`, `sa`) and current capabilities.
- Keep `CLAUDE.md` and `AGENTS.md` identical in instruction content.

### 2. Manifest (`docs/GUIDELINES_MANIFEST.md`)
- Sync with `docs/guidelines/GUIDELINES_MANIFEST.md`, including table entries for CLAUDE/AGENTS guidelines, DOCS folder guideline, and profiles.

### 3. Architecture Blueprint (`docs/architecture.md`)
- Update scope to include `Core Baseline`, `Production App Extension`, and `Sensitive Data Extension`.
- Update top-level source layout and ownership rules to include all providers, screens, services, widgets, and SQLite database.
- Document complete state boundaries across all 6 providers.
- Document domain models (`SafetyCheckResult`, `ScanHistoryItem`, `AirQrPacket`, `ArTrackedCode`).
- Document persistence: `sqflite` for encrypted scan history, `flutter_secure_storage` for API keys, `shared_preferences` for counters and language preference.
- Add Section 15 on Localization Architecture detailing the 3 locales, fallback delegates, and language persistence.

### 4. Dependencies Registry (`docs/dependencies.md`)
- Catalog all 23 production and 3 development dependencies currently in `pubspec.yaml`.
- Document the security, privacy, and licensing note for each package.
- Maintain prohibited packages list (analytics, crash reporting, ads, alternative state managers).

### 5. Release Runbook (`docs/release_process.md`)
- Update current version and build number to `2.8.1+21`.
- Update production release commands with mandatory flags:
  - APK: `flutter build apk --flavor prod --release --obfuscate --split-debug-info=build/symbols/android-prod/ --split-per-abi`
  - App Bundle: `flutter build appbundle --flavor prod --release --obfuscate --split-debug-info=build/symbols/android-prod/`
- Add language verification checklist: key parity, no untranslated strings, no Hindi markers in `app_sa.arb`.

### 6. Security Blueprint (`docs/security.md`)
- Update security scope to include `Sensitive Data Extension` for StegoQR encryption and biometrics.
- Detail cryptography design: AES-GCM / PBKDF2 for StegoQR payloads, SHA-256 checksums, platform keystore for API key.
- Document biometric authentication flow (`local_auth`) and fallback behavior.
- Document database security (local SQLite storage, safe parameterization).

### 7. Project Structure Guide (`docs/project_structure.md`)
- Update directory tree and component ownership to reflect actual codebase structure.

## Files to Modify

- `CLAUDE.md`
- `AGENTS.md`
- `docs/GUIDELINES_MANIFEST.md`
- `docs/architecture.md`
- `docs/dependencies.md`
- `docs/release_process.md`
- `docs/security.md`
- `docs/project_structure.md`

## Verification Plan

### Automated Verification
- Run static analysis: `flutter analyze`
- Run test suite: `flutter test`
- Format check: `dart format --output=none --set-exit-if-changed .`

### Manual Review
- Verify all links in `docs/` are valid relative links.
- Verify no absolute paths or local system details exist in any updated file.
- Verify exact consistency between `CLAUDE.md` and `AGENTS.md`.
