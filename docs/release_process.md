# Release Process — SreerajP QR Studio

This document provides the step-by-step release runbook, signing instructions, versioning rules, build commands, and release checklist for SreerajP QR Studio. Read this before building or distributing a release artifact.

**Read first:**
- [CLAUDE.md](../CLAUDE.md)
- [AGENTS.md](../AGENTS.md)
- [architecture.md](architecture.md)
- [security.md](security.md)
- [guidelines/release_process.md](guidelines/release_process.md)
- [guidelines/guideline.md](guidelines/guideline.md)

---

## 1. Secrets Warning

> **CRITICAL:** `android/key.properties` and `android/keystore.jks` contain release signing credentials and must **NEVER** be committed to source control. Ensure both are listed in `.gitignore`.

---

## 2. Release Scope

- App: SreerajP QR Studio
- Release profiles: Personal / Production distribution
- Supported platforms: Android only (minSdk 24, targetSdk 36, compileSdk 37)
- Current version: `4.0.4+33`
- Supported languages: English (`en`), Malayalam (`ml`), Sanskrit (`sa`)

---

## 3. Roles And Responsibilities

| Role | Responsibility | Owner |
|---|---|---|
| Release owner | All release decisions, signing validation, and final sign-off | Sreeraj P |
| Engineering | Implementation, linting, tests, and build artifact creation | Sreeraj P |

---

## 4. Versioning Policy

- Version format: `MAJOR.MINOR.PATCH+BUILD`
- Source of truth: `pubspec.yaml`
- Synchronized config: `assets/config/app_config.json` (`version` and `build` MUST match `pubspec.yaml`)
- Current version: `4.0.4+33`
- Git tag format: `vX.Y.Z` (e.g. `v4.0.4`)

---

## 5. Build Flavors Matrix

| Flavor | App ID | Purpose | Build Command |
|---|---|---|---|
| `dev` | `in.sreerajp.qr_studio.dev` | Daily development and testing | `flutter run --flavor dev` |
| `prod` | `in.sreerajp.qr_studio` | Production split APKs | `flutter build apk --flavor prod --release --obfuscate --split-debug-info=build/symbols/android-prod/ --split-per-abi` |
| `prod` | `in.sreerajp.qr_studio` | Production Google Play Bundle | `flutter build appbundle --flavor prod --release --obfuscate --split-debug-info=build/symbols/android-prod/` |

> **Hardening Note (`guideline.md` §2.4):** Every production release build MUST include `--release`, `--obfuscate`, and `--split-debug-info`. Immediately archive the resulting `build/symbols/android-prod/` directory securely so crash stack traces can be decoded.

---

## 6. Signing And Secret Handling

- Secrets location: `android/key.properties`
- Keystore location: `android/keystore.jks` (or path specified in `key.properties`)
- Rules:
  - `android/key.properties` and `*.jks` must never be committed.
  - Keystore must have an offline, secure backup.
  - If `key.properties` is missing during local builds, Gradle falls back to debug signing automatically.

---

## 7. Release Checklist

### Quality & Code Standards
- [ ] `flutter pub get` succeeds without version conflicts.
- [ ] `dart format --output=none --set-exit-if-changed .` passes cleanly.
- [ ] `flutter analyze` passes with 0 warnings.
- [ ] `flutter test` passes with 100% success rate across all unit and widget tests.

### Localization Gate (`engineering_standard.md` §8)
- [ ] `l10n.yaml` exists and `flutter gen-l10n` generates cleanly.
- [ ] Key parity verified: every key in `app_en.arb` is present and translated in `app_ml.arb` and `app_sa.arb`.
- [ ] No untranslated English strings left in `app_ml.arb` or `app_sa.arb`.
- [ ] Sanskrit quality check passes: zero forbidden Hindi markers (है, हैं, था, थे, थी, हो, और, करें, करना, करके, रहा, रही, रहे, गया, गयी, चाहिए, नहीं, लेकिन, क्या, कृपया, सेटिंग्स, ऐप, nukta).
- [ ] Sanskrit Material/Cupertino fallback delegates registered in `main.dart`.
- [ ] `android/app/build.gradle` has `bundle.language.enableSplit = false` so Play Store downloads do not strip non-default languages.
- [ ] Language switcher in Settings verified on a test device in all three languages.

### Versioning & Config
- [ ] Version and build number incremented in `pubspec.yaml`.
- [ ] `assets/config/app_config.json` updated to match `pubspec.yaml`.
- [ ] `android/key.properties` present for release signing.
- [ ] `pubspec.lock` committed.

### Google Play Declarations
- [ ] Play Console > App content > Foreground service permissions: declare `FOREGROUND_SERVICE_SPECIAL_USE` for the Scan bubble. Reason: "Shows a floating button that the user turned on. Tapping it starts a one-time, user-approved screen capture to read a QR code or barcode. Stays on until the user turns it off." Attach a short video of turning the bubble on and scanning a code.
- [ ] Declare `FOREGROUND_SERVICE_MEDIA_PROJECTION` for GhostScan (one-frame capture after user consent).
- [ ] Ready-to-paste answers for both entries, and the demo video shot list, are kept locally in `play_store_private/foreground_service_declaration.md` (gitignored, never committed).
- [ ] Play Console > App content > Privacy policy: enter the public URL of [PRIVACY_POLICY.md](../PRIVACY_POLICY.md). Update the policy first if permissions or network features changed.
- [ ] Play Console > App content > Data safety: form filled in. The answers are kept locally in `play_store_private/` (gitignored, never committed).

### Verification & Artifact Hardening
- [ ] Production split APKs built with `--obfuscate` and `--split-debug-info`.
- [ ] Symbols from `build/symbols/android-prod/` safely archived.
- [ ] APK installed and tested on a physical Android device (camera scanning, URL analysis, StegoQR, AirQR, Scan bubble on/off from Settings, tile and shortcut, language switching).
- [ ] Git release tag created (`vX.Y.Z`).
