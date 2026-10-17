# Change log: Screenshot guard setting

Implements plan [plans/20261017_133200_screenshot_guard_setting.md](../plans/20261017_133200_screenshot_guard_setting.md).

## What changed

The screenshot and screen-recording block on sensitive screens (`FLAG_SECURE`) is now a user
choice. A new **Screenshot guard** switch is in Settings → Privacy & probing. It is **on by
default**, so nothing changes for current users until they turn it off.

### Code

- `lib/services/screen_security_service.dart` — new `enabled` flag and `setEnabled(bool)`.
  The open-screen counter keeps running when the guard is off. The window flag is set only when
  the guard is on **and** a sensitive screen is open. Turning the guard on or off applies at
  once to an open sensitive screen. The service now remembers the last flag it sent, so it never
  sends the same value twice. Calls still never throw.
- `lib/providers/screen_security_provider.dart` (new, `providers` layer) — reads and saves
  the `screen_security_enabled` preference (default `true`) and passes it to the service.
- `lib/main.dart` — registers `ScreenSecurityProvider` with `lazy: false`, so a saved "off"
  reaches the service at app start, not only when Settings is opened.
- `lib/screens/settings_screen.dart` — new switch card between "App lock" and
  "Delete all data" on the Privacy screen.
- "Delete all data" clears preferences, so the guard is on again after a wipe (no change needed
  in `DataWipeService`).

### Text (all three languages)

- New keys: `labelScreenshotGuard`, `descScreenshotGuard` (with `@` descriptions in English).
- `descFeatureBiometricGuard` and `helpGuideHistoryBiometricsBullet2` now say the guard can be
  turned off in Settings › Privacy & probing.
- Ran `flutter gen-l10n`.

### Tests

- `test/services/screen_security_service_test.dart` — off means no flag; on/off while a
  screen is open; changing the setting with no open screen sends nothing.
- `test/providers/screen_security_provider_test.dart` (new) — default on, saved "off" is
  loaded, `setEnabled` saves and updates the service, listeners are told.
- `test/screens/settings_screen_test.dart` — the switch shows as on and can be turned off;
  the choice is saved.

### Docs

- `docs/security.md` §10.1, test table, accepted-risk table and release checklist.
- `docs/architecture.md` — provider table, app lock note, design decision row.
- `docs/project_structure.md` — new provider file.
- `docs/release_process.md` — device check for both switch states.
- `CHANGELOG.md` — Unreleased entry updated.

## Checks

- `dart format` — clean.
- `flutter analyze` — no issues.
- `flutter test` — all 777 tests pass.
- Not tested on a real device yet (release checklist item in `docs/release_process.md`).

## For native-reader review

Please check these new or changed translations:

- Malayalam: `labelScreenshotGuard` "സ്ക്രീൻഷോട്ട് സംരക്ഷണം" (exactly 22 characters, at the
  limit), `descScreenshotGuard`, and the new last sentence of `descFeatureBiometricGuard` and
  `helpGuideHistoryBiometricsBullet2` ("… എന്നതിൽ ഇത് ഓഫാക്കാം.").
- Sanskrit: `labelScreenshotGuard` "पटलचित्र-रक्षणम्", `descScreenshotGuard` (uses
  "अद्यतन-अनुप्रयोग-सूच्याम्" for "recent apps"), and the new sentence
  "… इत्यत्र एतत् निष्क्रियं कर्तुं शक्यते।".
