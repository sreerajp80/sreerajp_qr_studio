# Change Log: Bring the app in line with the updated guidelines

Implements plan [plans/20261027_205050_adhere-to-updated-guidelines.md](../plans/20261027_205050_adhere-to-updated-guidelines.md).

## Security impact

Stronger only. The HTTPS check never accepts a rejected certificate, cleartext traffic is
turned off explicitly, and the AirQR PIN and stream id use the secure random generator.
Nothing was weakened.

## What changed

### Code

| # | Change | Files |
|---|---|---|
| A1 | `formattingLocale` now uses `Intl.canonicalizedLocale` (`en_US`, not `en-US`), then the language code, then `en` (standard §8.3.2). Tests added for `en_US`, `ml_IN` and `sa_IN`. | `lib/l10n/formatting_locale.dart`, `test/l10n/formatting_locale_test.dart` |
| A2 | The `titleApp` ARB key is removed. The in-app name now comes from `appName` in `app_config.json` plus `AppFlavorConfig.nameSuffix` (`' Dev'` in dev builds) (`guideline.md` §1.8). Startup loads `AppConfig` once and provides it with `Provider`. New `context.appDisplayName` helper is used for the task-switcher title, the home app bar and the two Appearance previews. | `lib/core/config/app_flavor_config.dart`, `lib/core/config/app_config.dart` (`displayName`), `lib/services/app_startup_service.dart`, `lib/main.dart`, new `lib/widgets/app_display_name.dart`, `lib/screens/scanner_screen.dart`, `lib/screens/appearance/accent_color_settings_screen.dart`, `lib/screens/appearance/typography_settings_screen.dart`, the three ARB files, `test/l10n/l10n_parity_test.dart` |
| A3 | The HTTPS check's `badCertificateCallback` always returns `false`. Before, a certificate with valid dates (for example self-signed, or for another site) was accepted and shown as valid. The reason is now worked out by `UrlSafetyService.certificateProblem` and shown: expired, not yet valid, or the new "not trusted" message. | `lib/services/url_safety_service.dart`, `lib/models/app_message.dart`, `lib/l10n/app_message_text.dart`, new ARB key `bodySslUntrusted` (en, ml, sa), `test/services/url_safety_service_test.dart` |
| A4 | The AirQR passphrase PIN and stream id use `Random.secure()`. The fountain-code generator keeps `Random(seed)`; it is not a security value. | `lib/screens/air_qr_transmitter_screen.dart`, `lib/services/air_qr_service.dart` |
| A5 | `android:usesCleartextTraffic="false"` added to `<application>`. | `android/app/src/main/AndroidManifest.xml` |
| A6 | Android launcher name per language: new `values-ml` and `values-sa` `strings.xml` for both flavors, copied from `appName` in `app_config.json`. The dev name is now `SreerajP QR Studio Dev` (was `QR Studio Dev`), so it matches `appName` + suffix. | `android/app/src/{dev,prod}/res/values*/strings.xml` |

### Tests

| # | Change | File |
|---|---|---|
| B1 | Badge test: `madeWithLove` and `madeWithLoveA11y` in every ARB, exactly one `{heart}`, no heart emoji in either key (standard §8.7). | `test/l10n/l10n_parity_test.dart` |
| B2 | `app_config.json` test fails when a `details` row is a plain string, except `email`, `website`, `privacyPolicy`. | `test/l10n/l10n_parity_test.dart` |

### Docs and repo files

| # | Change | Files |
|---|---|---|
| C1 | New §1.1 Security Baseline, §3.1 Entry Points, Third-Party SDKs table (§4), HTTPS / certificate / timeout rules (§5), §7.1 Usability Balance, `PendingIntent` and `FileProvider` lines (§10.1), string-literal note (§8.1), three new checklist items (§18). OWASP M3 renamed "Insecure Authentication/Authorization". | `docs/security.md` |
| C2 | New §0 Product brief with §0.1 Data and privacy, and §7 Tools and workflow. Dev display name and the "same privacy URL everywhere" note updated. | `docs/PROJECT_PROFILE.md` |
| C3 | Same edits in both: layout lists `core/logging/` and `l10n/`; keystore backup rule points to `guideline.md` §2.3; three Security Baseline lines; cleartext flag; literal list and the `app_config.json` text-source rule; badge written with `{heart}`; "no new warnings (zero is the goal)"; "Security impact" line in workflow rule 1; dev display name. | `CLAUDE.md`, `AGENTS.md` |
| C4 | Release tag is now `v<X.Y.Z>`, once per release. Old `Release_YYYYMMDD` tags stay. | `docs/release_process.md`, `docs/architecture.md` |
| C5 | `.env` and `.env.*` ignored. | `.gitignore` |
| C6 | Comments use `{heart}` instead of the emoji. Dev display name updated in the README and architecture doc. | `lib/widgets/made_with_love.dart`, `lib/screens/about_screen.dart`, `README.md`, `docs/architecture.md` |

## Changes from the plan

- The About screen keeps its own `loadAndVerify()` call (it also checks the version against the
  installed package). It does not use the provided config. The result is the same name.
- `README.md` and `docs/architecture.md` were also updated for the new dev display name.

## Checks done

- `flutter gen-l10n`, `dart format .` (0 changed), `flutter analyze` — no issues.
- `flutter test` — all 895 tests pass.
- `flutter build apk --flavor dev --debug` builds. The APK's `app_name` has English, Malayalam
  and Sanskrit values, each with the ` Dev` suffix. Gradle daemons stopped afterwards; no
  `GradleDaemon` or `KotlinCompileDaemon` process left. Nothing was installed on a phone.
- `docs/guidelines/` was not touched.

## Not done (needs a person)

- Native-reader review: `bodySslUntrusted` in Malayalam (`SSL സർട്ടിഫിക്കറ്റ് വിശ്വസനീയമല്ല`) and
  Sanskrit (`प्रमाणपत्रं विश्वसनीयं नास्ति`).
- `docs/security.md` §7.1: time PBKDF2 (600,000 iterations) on the slowest supported phone before
  the next release.
- Shared files (images, PDFs) have no file-size limit before decoding; only the decoder's pixel
  limit applies. Worth a later look.
