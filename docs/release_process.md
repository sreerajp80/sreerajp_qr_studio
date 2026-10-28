# Release Process — SreerajP QR Studio

This is the release runbook for SreerajP QR Studio: scope, versioning, flavors, release-build
hardening, signing, the release checklist, the Android release steps, distribution, rollback and
post-release checks. Read it before building or distributing any release artifact.

**Read first:**
- [CLAUDE.md](../CLAUDE.md) / [AGENTS.md](../AGENTS.md)
- [PROJECT_PROFILE.md](PROJECT_PROFILE.md)
- [security.md](security.md)
- [guidelines/release_process.md](guidelines/release_process.md) (template)
- [guidelines/platform_store_readiness.md](guidelines/platform_store_readiness.md) §1, §2
- [guidelines/guideline.md](guidelines/guideline.md) §2 (keystore rules)

> **Secrets:** `android/key.properties` and `android/keystore.jks` hold the release signing
> credentials. They are git-ignored and must **never** be committed, pasted into a plan or change
> log, or given to CI.

---

## 1. Release Scope

- App: SreerajP QR Studio (`in.sreerajp.qr_studio`)
- Release profile: **public**
- Release platforms: **Android** only (minSdk 24, targetSdk 36, compileSdk 37)
  - channels: **Google Play** (`.aab`) and **direct download** (split APKs)
- Store gates in force: [platform_store_readiness.md](guidelines/platform_store_readiness.md)
  §1 (every store) and §2 (Google Play).
- Engineering standard profiles in force: `Core Baseline`, `Production App Extension`,
  `Sensitive Data Extension`.
- Languages: English (`en`), Malayalam (`ml`), Sanskrit (`sa`).

---

## 2. Roles And Responsibilities

One person does every role in this project.

| Role | Responsibility | Owner |
|---|---|---|
| Release owner | Release decisions, signing, final sign-off | App maintainer |
| Engineering | Code, analyze, tests, release builds | App maintainer |
| QA | Device tests in all three languages | App maintainer (plus fluent ml/sa readers for translation review) |
| Store owner | Play Console upload, listings, declarations | App maintainer |

---

## 3. Versioning Policy

- Version format: `MAJOR.MINOR.PATCH+BUILD`.
- Source of truth: `pubspec.yaml` (currently `4.1.0+34`).
- `assets/config/app_config.json` `version` and `build` MUST match `pubspec.yaml`
  (`ConfigService.loadAndVerify` logs a mismatch). The Android build regenerates
  `lib/core/constants/app_version.g.dart` and `build_date.g.dart` from `pubspec.yaml`
  (`tool/generate_app_version.dart`, `tool/generate_build_date.dart`).
- Build number: +1 for every upload to any channel, never reused, even for a rejected build.
- Git tag format: **`v<X.Y.Z>`** (no `+build`), once per release, on the release commit —
  for example `v4.1.8`. Older releases were tagged `Release_YYYYMMDD`; those tags stay as they
  are.

---

## 4. Branch And Merge Policy

- Strategy: `main` only, with short-lived work and direct commits by the maintainer.
- Required before a merge or push to `main`: the CI checks pass (format, `flutter analyze`,
  `flutter test`, Sanskrit Hindi-marker gate) and every change has an approved plan and a change
  log (`plans/`, `change_log/`).
- Dependabot pull requests pass the same checks; a major-version update gets its own plan.
- Hotfixes: a fix commit on `main`, then the normal release steps (§9) with a new build number.

---

## 5. Environment And Flavor Matrix

| Flavor | App ID | Mode | Purpose | Command |
|---|---|---|---|---|
| `dev` | `in.sreerajp.qr_studio.dev` | debug | Daily development (icon has a "DEV" badge) | `flutter run --flavor dev` |
| `dev` | `in.sreerajp.qr_studio.dev` | release | Release-like test build | `flutter build apk --flavor dev --release` |
| `prod` | `in.sreerajp.qr_studio` | release | Direct-download split APKs | `./tool/build_release.sh apk` |
| `prod` | `in.sreerajp.qr_studio` | release | Google Play bundle | `./tool/build_release.sh appbundle` |

`tool/build_release.sh` adds every required flag (§6.1) and `BUILD_DATE`. On Android,
`--flavor <name>` is enough: Flutter sets `FLUTTER_APP_FLAVOR` itself (never pass it with
`--dart-define`); `AppFlavorConfig` reads it.

---

## 6. Release Build Hardening

### 6.1 Obfuscation and debug symbols
- Every production build uses `--release --obfuscate
  --split-debug-info=build/symbols/android-prod-<version>/`, where `<version>` is the full
  `pubspec.yaml` version (e.g. `4.1.0+34`), so symbols from different releases never collide.
  `tool/build_release.sh` does this, and adds `--split-per-abi` for APKs (no universal APK).
- After the build, copy `build/symbols/android-prod-<version>/` to the secure archive **outside
  the repository**, next to the release artifacts, and keep it for the life of that version.
  Without it, crash stack traces from that version cannot be read. Never commit it (`build/` is
  git-ignored).
- For Play, also upload the native debug symbols in Play Console.

### 6.2 ProGuard / R8
- R8 full mode is on by default for release builds (AGP 9).
- `android/app/proguard-rules.pro` is referenced by the release build type
  ([security.md](security.md) §8.2). Test the release build end to end after every dependency
  change: R8 problems show up only in release builds (`ClassNotFoundException`,
  `NoSuchMethodException`).

### 6.3 App size
Run before every release and record the result in §14:

```bash
flutter build appbundle --flavor prod --release --analyze-size
flutter build apk --flavor prod --release --split-per-abi --analyze-size
```

Budgets (engineering standard §10.7): APK arm64 under 30 MB (hard limit 50 MB); AAB download
under 20 MB (hard limit 40 MB). A growth of more than 10% without a reason is a review item.

### 6.4 Debuggable and backup
The merged release manifest must have no `debuggable` and must have `allowBackup` false
(required under the Sensitive Data Extension, [security.md](security.md) §10).

```bash
APK=build/app/outputs/flutter-apk/app-arm64-v8a-prod-release.apk
aapt2 dump badging "$APK" | grep -i debuggable          # expect: nothing
aapt2 dump xmltree "$APK" --file AndroidManifest.xml | grep -i allowBackup   # expect: 0x0
```

```powershell
$APK = "build\app\outputs\flutter-apk\app-arm64-v8a-prod-release.apk"
aapt2 dump badging $APK | Select-String -Pattern "debuggable"
aapt2 dump xmltree $APK --file AndroidManifest.xml | Select-String -Pattern "allowBackup"
```

### 6.5 Cleartext traffic
No `usesCleartextTraffic` and no network security config: Android 9+ blocks cleartext by default.
Confirm nothing added either before a release.

### 6.6 Asset and secret audit
List the APK assets and confirm only expected files are inside (`app_config.json`, the licence
texts, `app_icon.png`, fonts and Flutter assets) — no `.env`, keys, keystores or test data.

```bash
unzip -l build/app/outputs/flutter-apk/app-arm64-v8a-prod-release.apk "assets/*"
```

```powershell
tar -tf build\app\outputs\flutter-apk\app-arm64-v8a-prod-release.apk | Select-String "assets/"
```

### 6.7 Exported components
Only `MainActivity` and the two Quick Settings tile services (protected by
`BIND_QUICK_SETTINGS_TILE`) may be exported ([security.md](security.md) §10.1). Check the merged
manifest for any new `exported="true"`.

### 6.8 No scanner telemetry
The APK must contain no `com.google.mlkit`, `com.google.android.datatransport` or
`com.google.firebase` classes (check with `dexdump`).

### 6.9 16 KB page size
Android 15+ requires 16 KB page alignment. The app bundles its own `.so` (zxing-cpp, built by the
Android NDK through CMake) and plugin libraries. Before every Play submission, run
`flutter build appbundle --analyze-size`, check the `.so` files, and test the release build on a
16 KB emulator image.

---

## 7. Signing And Secret Handling

> Keystore location, `key.properties` format and the `.gitignore` rules follow
> [guideline.md](guidelines/guideline.md) §2.

- Signing config: `android/key.properties` (local only) pointing at `android/keystore.jks`.
- Keystore owner: app maintainer. Keep at least two secure, offline backups of the keystore
  and its passwords; losing them means no more updates on Google Play.
- Play App Signing MUST be enabled for the app in Play Console (one-time,
  [platform_store_readiness.md](guidelines/platform_store_readiness.md) §2.3); the local keystore
  is then the upload key. Confirm it in Play Console before the next upload.
- Rules:
  - signing material never goes into source control, plans, change logs or CI;
  - GitHub CI runs only checks and Dependabot, never signing (engineering standard §19).
- Without `android/key.properties`, every **prod** release task (`assembleProdRelease`,
  `bundleProdRelease`, `packageProdRelease`) **fails** with a clear message
  (`android/app/build.gradle`). Only `dev` release builds — never shipped — may fall back to the
  debug key.

---

## 8. Release Checklist

Complete before every release.

### Code and quality
- [ ] CI checks passed on the release commit.
- [ ] `flutter pub get` succeeds.
- [ ] `dart format --output=none --set-exit-if-changed .` passes.
- [ ] `flutter analyze` — zero issues.
- [ ] `flutter test` — all tests pass.
- [ ] `flutter test integration_test --flavor dev -d <device>` — native decoder tests pass.
- [ ] `bash tool/check_sanskrit_hindi_markers.sh` passes.
- [ ] No release-blocking bug open.
- [ ] Release artifacts built locally, not in CI.
- [ ] `flutter pub licenses` checked if the release adds dependencies (open source only).

### Performance
- [ ] Release build checked for jank on the main scan flow (profile mode).
- [ ] App size within budget (§6.3).
- [ ] Cold start under 2 seconds on a mid-range phone.

### Security
- [ ] `--obfuscate` and `--split-debug-info` used (§6.1); symbols archived.
- [ ] ProGuard / R8 rules verified (§6.2).
- [ ] `debuggable` absent and `allowBackup` false in the merged release manifest (§6.4).
- [ ] Cleartext traffic still blocked (§6.5).
- [ ] Asset audit passed (§6.6); exported components checked (§6.7); no ML Kit/Firebase classes
      (§6.8).
- [ ] Permissions in the merged manifest match [security.md](security.md) §11.
- [ ] Release APK signed with the release key — `apksigner verify --print-certs` shows the
      release certificate, not "Android Debug".
- [ ] [security.md](security.md) §12 OWASP table reviewed and §18 checklist done; no item left
      `open`.
- [ ] "Delete all data" tried on a device (data retention, [security.md](security.md) §13).

### Localization
- [ ] One ARB file per declared language; parity, label-length and Hindi-marker tests pass.
- [ ] New or changed Malayalam and Sanskrit strings reviewed by fluent readers (see the
      "needs native-reader review" lists in `change_log/`).
- [ ] Every screen opened in en, ml and sa on a clean device — no missing glyphs, no overflow.
- [ ] Language picker: System default + English / മലയാളം / संस्कृतम्; persists; applies without
      restart.
- [ ] `bundle.language.enableSplit = false` still in `android/app/build.gradle`.
- [ ] Date pickers and dialogs checked under Sanskrit.
- [ ] Every icon-only control has a tooltip.
- [ ] About screen ends with the "Made with ❤️ from India" badge, localized and centered.

### Store readiness (Google Play and direct APK)
- [ ] [platform_store_readiness.md](guidelines/platform_store_readiness.md) §1 passes.
- [ ] §2 Google Play gate: target API level re-checked against Play's current rule;
      `versionCode` increased; App Bundle with Play App Signing; listings and screenshots in
      `en-US` and `ml-IN`; internal testing and pre-launch report clean; staged rollout planned.
- [ ] Play Console → App content → Foreground service permissions: declare
      `FOREGROUND_SERVICE_SPECIAL_USE` for the Scan bubble ("Shows a floating button that the
      user turned on. Tapping it starts a one-time, user-approved screen capture to read a QR
      code or barcode. Stays on until the user turns it off.") with a short video, and
      `FOREGROUND_SERVICE_MEDIA_PROJECTION` for GhostScan (one-frame capture after user
      consent). Ready-to-paste answers and the video shot list are kept locally in
      `play_store_private/` (git-ignored, never committed).
- [ ] Play Console → App content → Privacy policy: the public URL of
      [PRIVACY_POLICY.md](../PRIVACY_POLICY.md) (update the policy first if permissions or
      network features changed).
- [ ] Play Console → App content → Data safety: filled in to match the app (answers kept in
      `play_store_private/`).

### Product and documentation
- [ ] `pubspec.yaml` version and `assets/config/app_config.json` updated together.
- [ ] [CHANGELOG.md](../CHANGELOG.md) updated; store "What's new" text written in en and ml.
- [ ] Docs updated for any behavior change.

### Artifact validation
- [ ] The exact upload artifact installs and launches on a clean physical device.
- [ ] Manual test on a device: camera scanning, link checks, StegoQR, AirQR, Scan bubble on/off
      (Settings, tile, shortcut), GhostScan, language switching, history (including the
      upgrade of history saved by the previous store build), "Delete all data".
- [ ] Android 13+ themed icon and the launcher icon look right.
- [ ] Screenshots of History, Result, the API keys screen and AirQR are blocked (`FLAG_SECURE`); after turning Settings → Privacy → Screenshot guard off they are allowed, and on again blocks them.
- [ ] App lock: turn on, close the app for 30 s, reopen — it asks to unlock; a quick gallery pick does not lock.
- [ ] A v2 backup made and restored; an AirQR sync sent and received between two phones.
- [ ] Version name and build number correct; prod icon has no "DEV" badge.

---

## 9. Android Release Steps

1. Check out the release commit; `git status` is clean.
2. Set the version in `pubspec.yaml` and `assets/config/app_config.json`; add the
   [CHANGELOG.md](../CHANGELOG.md) entry.
3. `flutter pub get`, then the checks in §8 "Code and quality".
4. Build:

   ```bash
   ./tool/build_release.sh appbundle    # Google Play
   ./tool/build_release.sh apk          # direct download (split per ABI)
   ```

5. Run the size analysis (§6.3) and the manifest, asset and component checks (§6.4–§6.8).
6. Verify the signature: `apksigner verify --print-certs <apk>` shows the release certificate.
7. Install the arm64 APK on a physical phone and run the manual tests in §8.
8. Archive `build/symbols/android-prod-<version>/` with the artifacts (§6.1).
9. Complete the Google Play gate (§8 "Store readiness"), upload the `.aab` to internal testing,
   check the pre-launch report, then start a staged rollout (for example 10% → 50% → 100%).
10. Publish the split APKs for direct download (with SHA-256 checksums).
11. Tag the release commit once: `git tag v<X.Y.Z>` (no `+build`) and push the tag.
12. Stop the Gradle daemons (`android\gradlew --stop`) and end any leftover `GradleDaemon` /
    `KotlinCompileDaemon` process.

---

## 10. iOS Release Steps

Not a declared platform.

## 11. Windows Release Steps

Not a declared platform.

## 11A. macOS Release Steps

Not a declared platform.

## 11B. Linux Release Steps

Not a declared platform.

---

## 12. Distribution Channels

| Channel | Artifact | Audience | Notes |
|---|---|---|---|
| Google Play | `.aab` | Public | Play App Signing; staged rollout; gate §2 |
| Direct APK | split `.apk` (arm64-v8a, armeabi-v7a, x86_64) | Users who install outside Play | Signed with the release key; publish SHA-256 checksums |

---

## 13. Rollback And Hotfix Process

- Rollback trigger: a crash or ANR spike in Android vitals, a data-loss or security bug, or a
  store policy problem.
- Rollback method: halt the staged rollout in Play Console; stop offering the direct APK. A
  build that reached users cannot be downgraded — ship a hotfix with a higher build number.
- Hotfix: fix on `main` (with its plan and change log), then the full §8 checklist and §9 steps.
  Archive the hotfix's debug symbols too.

---

## 14. Release Evidence

Record after each release (in the release's change log or next to the archived artifacts):

- CI run of the release commit.
- `flutter test` result and integration test result.
- Size analysis output (§6.3).
- Debug symbols archive location (outside the repository).
- Artifact location and SHA-256 checksums.
- Release notes ([CHANGELOG.md](../CHANGELOG.md) entry).
- Play Console rollout record.
- OWASP sign-off: [security.md](security.md) §12 reviewed — date and owner.

---

## 15. Post-Release Checks

- [ ] Android vitals (crash and ANR rate) reviewed at each rollout step.
- [ ] User reports and store reviews triaged.
- [ ] Release tag `v<X.Y.Z>` created and pushed.
- [ ] Debug symbols confirmed in the secure archive.
- [ ] Follow-up tasks recorded as plans.
