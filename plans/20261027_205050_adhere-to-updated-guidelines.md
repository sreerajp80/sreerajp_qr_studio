# Plan: Bring the app in line with the updated guidelines

**Status:** completed

## Why

The guidelines submodule (`docs/guidelines/`) was updated. The update adds a Security Baseline for
every app, a new "app name" rule (`guideline.md` §1.8), a fixed `formattingLocale` sample, stricter
ARB parity tests, and new template sections for `docs/security.md`, `docs/PROJECT_PROFILE.md`,
`CLAUDE.md` and `AGENTS.md`.

I checked the app against the new rules. `flutter analyze` is clean today, all imports already use
`material_ui`, `PendingIntent`s are immutable, `allowBackup="false"` is set, and only the needed
components are exported. The gaps below remain.

## Security impact

This plan touches the network check (TLS certificate handling), the Android manifest (cleartext
flag) and random-number use. Every change makes security stronger; nothing is weakened.

## Gaps found and the fix for each

### A. Code

| # | Gap (rule) | Fix |
|---|---|---|
| A1 | `formattingLocale` uses `toLanguageTag()` (`en-US`), but `intl` keys use `en_US`, so a regional locale wrongly falls back to `en` (standard §8.3.2). | Use the new sample: `Intl.canonicalizedLocale(locale.toString())`, then the language code, then `en`. Add test cases for `en_US`, `ml`, `sa`. |
| A2 | `titleApp` is a second app-name key in the ARB files. §1.8 says the in-app name comes only from `appName` in `app_config.json`, plus a flavor suffix (`AppFlavorConfig.nameSuffix`). | Add `nameSuffix` (`' Dev'` for dev, `''` for prod) to `AppFlavorConfig`. Load `AppConfig` once at startup and provide it with `Provider`. Use `config.appName.resolve(lang) + nameSuffix` for `onGenerateTitle`, the home app bar, and the two Appearance preview screens. About screen uses the same provided config. Remove `titleApp` from all three ARB files and run `flutter gen-l10n`. |
| A3 | The SSL check's `badCertificateCallback` returns `true` for a certificate with valid dates. So a self-signed or wrong-host certificate is accepted and shown as "valid" (standard §15.1: never disable certificate checks). | The callback always returns `false`. It only records why (expired / not yet valid / not trusted). The handshake error is then caught and the recorded reason is shown. Add a new message `sslUntrusted` ("certificate is not trusted") with a new ARB key in English, Malayalam and Sanskrit. Add a unit test. |
| A4 | The AirQR passphrase PIN uses `Random()` (standard §15.1: `Random.secure()` for security values). | Use `Random.secure()` for the PIN and the AirQR stream id. The fountain-code parity generator keeps `Random(seed)`; it is not a security value. |
| A5 | Android cleartext is off only by default; the release rules say to set it explicitly (`release_process.md` §6.5, `security.md` §10). | Add `android:usesCleartextTraffic="false"` to `<application>` in `AndroidManifest.xml`. |
| A6 | The Android launcher name is not translated: there is no `values-ml` / `values-sa` `app_name`. The dev name `QR Studio Dev` does not match `appName` + suffix (§1.8, flavors guide). | Add `app_name` in `android/app/src/{dev,prod}/res/values-ml/strings.xml` and `values-sa/strings.xml`, using the `appName` texts from `app_config.json`. Dev names get the ` Dev` suffix. Change the dev English name to `SreerajP QR Studio Dev`. |

### B. Tests

| # | Gap | Fix |
|---|---|---|
| B1 | Badge test only checks that `{heart}` exists (standard §8.7). | Check that `madeWithLove` and `madeWithLoveA11y` exist in every ARB, `madeWithLove` has exactly one `{heart}`, and neither key has a heart emoji. |
| B2 | A plain-string display row in `app_config.json` passes the test silently (standard §8.7). | Fail when a `details` row is a plain string, except the technical keys `email`, `website`, `privacyPolicy`. |

### C. Docs and repo files

| # | Gap | Fix |
|---|---|---|
| C1 | `docs/security.md` lacks the new template parts. | Add §1.1 Security Baseline checklist (each line `verified` or `n/a`), §3.1 Entry Points (QR/barcode payloads, gallery/file import, clipboard, share intent, quick-settings tiles, platform channels, backup import, network responses), a Third-Party SDKs table in §4 (none), the HTTPS/certificate/timeout rules in §5 "In Transit", §7.1 Usability Balance, and the new Android lines in §10 (cleartext explicit, exported list, `PendingIntent`, `FileProvider`). Fix the §8.1 obfuscation note (it does not hide string literals). |
| C2 | `docs/PROJECT_PROFILE.md` lacks template §0 (product brief, §0.1 data and privacy, with the third-party SDK row) and §7 (tools and workflow, CI row). | Add both sections. Update the dev display name to `SreerajP QR Studio Dev`. Add the "same URL everywhere" note to the privacy policy row. |
| C3 | `CLAUDE.md` and `AGENTS.md` miss new template lines. | Same edit in both files: layout lists `core/logging/` and `l10n/`; keystore backup line points to `guideline.md` §2.3 (two backups, one offline); three Security Baseline lines; literals list adds `Semantics` test tags and developer-only screens; note that `app_config.json` About values are the one other text source; "no new warnings (zero is the goal)"; "Security impact" line in workflow rule 1; dev display name in the flavors table. |
| C4 | `docs/release_process.md` tags `Release_YYYYMMDD`; the rule is now `v<X.Y.Z>` (no `+build`), once per release. | Change the tag step. |
| C5 | `.gitignore` does not ignore `.env` files (standard §20.4). | Add `.env` and `.env.*`. |
| C6 | Comments in `made_with_love.dart` and `about_screen.dart` use the ❤️ emoji (§1.7 says use `{heart}`). | Change the comments to "Made with {heart} from India". |

## Files to change

- `lib/l10n/formatting_locale.dart`
- `lib/core/config/app_flavor_config.dart`
- `lib/main.dart`, `lib/services/app_startup_service.dart` (load and provide `AppConfig`)
- `lib/screens/scanner_screen.dart`, `lib/screens/about_screen.dart`,
  `lib/screens/appearance/accent_color_settings_screen.dart`,
  `lib/screens/appearance/typography_settings_screen.dart`
- `lib/services/url_safety_service.dart`, `lib/models/app_message.dart`, `lib/l10n/app_message_text.dart`
- `lib/screens/air_qr_transmitter_screen.dart`, `lib/services/air_qr_service.dart`
- `lib/widgets/made_with_love.dart`
- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb` (+ generated files)
- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/dev/res/values/strings.xml` and new `values-ml`, `values-sa` files under `dev` and `prod`
- `test/l10n/formatting_locale_test.dart`, `test/l10n/l10n_parity_test.dart`,
  `test/services/` (SSL check test), any test that used `titleApp`
- `docs/security.md`, `docs/PROJECT_PROFILE.md`, `docs/release_process.md`
- `CLAUDE.md`, `AGENTS.md`, `.gitignore`
- `change_log/<timestamp>_adhere-to-updated-guidelines.md`

Not changed: anything in `docs/guidelines/` (read-only) and `native/zxing-cpp/`.

## Checks after the change

- `flutter gen-l10n`, `dart format .`, `flutter analyze` (no issues), `flutter test` (all pass).
- One `flutter build apk --flavor dev --debug` to confirm the new Android string files build, then
  `android\gradlew --stop` and make sure no Gradle or Kotlin daemon is left. No install on any phone.

## Needs native-reader review

- The new `sslUntrusted` text in Malayalam and Sanskrit.
- Launcher names in Malayalam and Sanskrit (copied from `app_config.json`, not new text).
