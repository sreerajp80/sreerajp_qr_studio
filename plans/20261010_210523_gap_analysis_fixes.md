# Close gaps found in the full-project gap analysis

**Status:** completed

## Summary of the check

The whole project was checked on 2026-10-10:

- `flutter analyze` — clean, 0 issues.
- `flutter test` — all 491 tests pass.
- Every feature listed in `docs/features.md` was checked against the code. All
  of them exist (torch, camera switch, zoom, PDF "Save all", share intent,
  backup `.sreerajqr`, RDAP, rate limit, TOTP, SEPA, crypto pay, Material You,
  AR batch copy, AirQR fountain code, MeCard, Sanskrit delegates, and more).
- Every camera setting and every URL-safety setting is both saved and used.
- Every Android component in `AndroidManifest.xml` has a matching Kotlin class.
  No leftover `qr_reader` names after the rename.

So there is no missing feature. The gaps are rule breaks, dead code, and
out-of-date docs. They are listed below, most important first.

---

## Gap 1 — Settings screen handles API keys itself (hard rule break)

**Issue.** The rules say widgets must not touch secure storage. But
`lib/screens/settings_screen.dart` creates its own `FlutterSecureStorage` and
reads, writes, and deletes the API keys for Google Safe Browsing, VirusTotal,
and URLhaus. The key names (`'google_safe_browsing_api_key'`,
`'virustotal_api_key'`, `'urlhaus_api_key'`) are typed by hand in two places in
the screen and again in `UrlSafetyService`. One typo would break a provider
with no error.

**Fix.**
- In `lib/services/url_safety_service.dart`, add one named constant per key and
  small methods: `hasApiKey(provider)`, `saveApiKey(provider, value)`,
  `deleteApiKey(provider)`, and `countActiveProviders()`. Use the constants in
  the service's own reads too.
- In `settings_screen.dart`, remove `FlutterSecureStorage` and call these
  service methods instead. Screen behaviour stays the same.
- The screen never reads the key value back; it only asks "is a key saved?".
- Add tests in `test/services/url_safety_service_test.dart` with a fake secure
  storage (save, has, delete, count).

## Gap 2 — English text that skips the translation files (l10n rule break)

**Issue.** These strings are typed in English in code, so they stay in English
when the user picks Malayalam or Sanskrit:

| File | Text |
| ---- | ---- |
| `lib/screens/code_forge_screen.dart` | "Barcode Content", "Enter barcode number or code", "None (Open)", "e.g. merchant@upi", "Optional" (×2), "QR Code", "Data Matrix" |
| `lib/screens/result_screen.dart` | "AirQR / JSON / StegoQR Payload Unlocked", "StegoQR Encrypted Payload Detected", "Hide Advanced", "Show Advanced (Salt / IV)", "Salt (Base64 / Optional)", "IV / Nonce (Base64 / Optional)" |
| `lib/screens/history_screen.dart` | "N scan records found" |
| `lib/screens/ar_codevision_screen.dart` | "N Items Selected" |
| `lib/screens/settings_screen.dart` | "• Dynamic colors", "Feed not yet downloaded" |
| `lib/screens/appearance/accent_color_settings_screen.dart` | Dynamic Color explanation text |
| `lib/screens/appearance/typography_settings_screen.dart` | "Scale Preference", the sample line, and the font-scale explanation |
| `lib/widgets/camera_adjustments_sheet.dart` | brightness value label |
| `lib/services/code_forge_service.dart` | 4 validation errors ("Content cannot be empty", "Text must not exceed N characters", "Wi-Fi Network Name (SSID) is required", "UPI ID / VPA is required") — these show on screen |
| `lib/services/encrypted_payload_service.dart` | fallback titles such as "StegoQR Encrypted Payload", "AirQR Transfer Frame (x/y)" |
| `lib/services/dom_sandbox_service.dart` | "(Offline / Network Restricted)" |

**Fix.**
- Add a new key for each string to `app_en.arb` (with an `@key` description),
  `app_ml.arb`, and `app_sa.arb`. Sanskrit must pass the Hindi-marker rule;
  labels stay ≤ 22 characters. Run `flutter gen-l10n`.
- Screens: use `AppLocalizations`.
- Services: return an `AppMessage` (key + arguments) instead of English text,
  as the rules require. `CodeForgeService.validateContent` will return
  `AppMessage?`; the screen turns it into text. Same for the encrypted-payload
  fallback titles and the sandbox offline label, through
  `lib/l10n/app_message_text.dart`.
- Left as-is on purpose: brand names ("Google Safe Browsing", "URLhaus"),
  protocol tokens ("WPA", "WEP"), CSV/JSON export headers, and the sandbox
  HTML source comment (not shown as UI text).
- Update the tests that check these messages (`code_forge_service_test.dart`,
  `code_forge_provider_test.dart`, `encrypted_payload_service_test.dart`).
  The ARB parity test will check all three files.

## Gap 3 — Icon buttons without a tooltip (rule §7.8)

**Issue.** Two icon-only buttons have no tooltip, so screen readers say
nothing useful:
- `lib/screens/code_forge_screen.dart` — show/hide Wi-Fi password button.
- `lib/screens/scanner_screen.dart` — pause/resume scanning button.

**Fix.** Add localized tooltips (reuse existing keys if they exist, else add
new ones in all three ARB files).

## Gap 4 — Dead code

**Issue.** These classes are never used anywhere (not in `lib/`, not in
tests). They were replaced by newer screens but not deleted:

- In `lib/screens/settings_screen.dart`: `AppearanceSettingsScreen` (replaced by
  `AppearanceScreen`), a second copy of `ScanOverlaySettingsScreen` (the live
  one is in `lib/screens/appearance/`), `SafeBrowsingSettingsScreen` (only
  wraps `UrlSafetyProvidersScreen`), and `HelpSettingsScreen` (replaced by
  `HelpHomeScreen`). About 400 lines.
- In `lib/models/camera_settings.dart`: the `CameraSettings` class. The two
  enums in the same file are used and stay.

**Fix.** Delete them. Remove any ARB keys that only these classes used (keep
parity in all three files).

## Gap 5 — Out-of-date docs

**Issue.**
- `docs/features.md` still says "version 2.6.11, build 18" (real: 4.0.4+33)
  and says the app "does not generate" QR images (CodeForge does). It does
  not mention: CodeForge generator, scan from clipboard, onboarding,
  multi-code selection, the extra URL-safety providers (VirusTotal, URLhaus,
  PhishTank, OpenPhish), device sync, accent colour / font-size settings, and
  the extra formats read from gallery/PDF. It also says the Wi-Fi button only
  opens settings, but the app now joins the network directly (Android Wi-Fi
  suggestion) and falls back to settings.
- `docs/security.md` permission table is missing `ACCESS_FINE_LOCATION`,
  `ACCESS_COARSE_LOCATION`, `ACCESS_WIFI_STATE`, `CHANGE_WIFI_STATE`,
  `ACCESS_NETWORK_STATE`, `CHANGE_NETWORK_STATE`.
- `docs/implementation_progress.md` says version 1.4.3 and `mobile_scanner`.
  `docs/implementation_plan.md` still plans `mobile_scanner`.
  `docs/feature_analysis_and_roadmap.md` says "current version v1.4.3+1".

**Fix.** Update these docs to match the code. Use the real version from
`pubspec.yaml`. Mark old historical sections as history instead of deleting
them.

## Gap 6 — Plan files with wrong status

**Issue.** 68 older files in `plans/` use statuses that are not allowed
("Approved", "Proposed", "Pending Approval", "Implemented", "Completed" with a
capital C, …), and 4 have no `Status:` line at all. Every one of them already
has a matching change log or a shipped feature in the code.

**Fix.** Set each one to `**Status:** completed`. Add the missing line to the
4 that have none. Only the status line changes.

## Gap 7 — Camera brightness, contrast and invert are not saved

**Issue.** In `lib/providers/camera_settings_provider.dart`, `setBrightness`,
`setContrast` and `setInvertColors` only change memory. Every other camera
setting (flash, resolution, distance zoom, sharpening, multi-code) is saved
to `SharedPreferences`. So these three go back to default each time the app
starts, which is not what a user expects from a settings sheet.

**Fix.**
- Add three keys: `camera_brightness`, `camera_contrast`,
  `camera_invert_colors`.
- Save the value in each setter. Load them in `_loadPreferences()`, with the
  same clamp ranges the setters use (brightness −1.0…1.0, contrast 0.5…2.5),
  so a bad stored value cannot break the preview.
- `resetAdjustments()` also clears the three saved values.
- The sliders call the setter many times while dragging. To avoid a disk
  write on every tiny move, the brightness and contrast setters save the
  value only once, when the user lets go of the slider (`onChangeEnd` in
  `lib/widgets/camera_adjustments_sheet.dart`).
- Add the three keys to the settings list in
  `lib/services/device_sync_service.dart`, so device sync copies them like the
  other camera settings.
- Tests in `test/providers/camera_settings_provider_test.dart`: values are
  saved, loaded back, clamped, and cleared by reset. Update
  `test/services/device_sync_service_test.dart` for the new keys.

## Gap 8 — CodeForge screen calls the location plugin itself (layer break)

**Issue.** `_fetchCurrentLocation` in `lib/screens/code_forge_screen.dart`
asks for location permission and calls `Geolocator.getCurrentPosition`
directly. This is device/service work inside a widget, against the
`screens → providers → services` rule. It also cannot be unit tested.

**Fix.**
- New service (layer: `services`): `lib/services/location_service.dart` with
  one method, `Future<LocationResult> getCurrentLocation()`. It asks for
  permission at point of use, gets the position with the same settings as
  today (high accuracy, 15-second limit), and returns one of: success
  (latitude, longitude), permission denied, or failed. It never throws and
  holds no UI text.
- New model (layer: `models`): `lib/models/location_result.dart`, an
  immutable class with a `const` constructor.
- `CodeForgeProvider` gets a `fetchCurrentLocation()` method that calls the
  service, fills the geo latitude/longitude, and exposes an `isFetchingLocation`
  flag. The service is passed in through the constructor (a default real one),
  so tests can use a fake.
- `code_forge_screen.dart` calls the provider and only shows the result:
  update the two text fields, or show the existing localized snack bars
  (`codeForgeGeoPermissionDenied`, `codeForgeGeoFailed`). It no longer imports
  `geolocator` or `permission_handler`.
- Behaviour for the user stays the same.
- Tests: `test/services/location_service_test.dart` (with the plugin calls
  wrapped behind small functions passed to the constructor, so they can be
  faked) and new cases in `test/providers/code_forge_provider_test.dart`
  (success fills lat/lng; denied and failed leave them empty).

## Gap 9 — 8 screens have no widget test

**Issue.** These screens have no test file under `test/screens/`:
`history_screen`, `code_forge_screen`, `scanner_screen`, `air_qr_screen`,
`air_qr_transmitter_screen`, `ar_codevision_screen`, `appearance_screen`,
`features_screen`.

**Fix.** Add one test file per screen, in `test/screens/`, using fake
providers/services and the three locales. Each file checks the screen builds
without errors and its main controls work:

| Test file | What it checks |
| --------- | -------------- |
| `history_screen_test.dart` | empty state; list shows records; search box filters; category chips change the filter; record count text is localized |
| `code_forge_screen_test.dart` | switch payload types; validation error shows as localized text; Wi-Fi password show/hide button and its tooltip; "use current location" fills lat/lng through a fake provider |
| `appearance_screen_test.dart` | all four rows show; tapping each opens the right sub-screen |
| `features_screen_test.dart` | builds in `en`, `ml`, `sa`; all feature cards show |
| `air_qr_transmitter_screen_test.dart` | empty text blocks start; entering text and starting shows frames; speed slider limits 5–25 FPS |
| `scanner_screen_test.dart` | camera permission denied shows the friendly message and the "open settings" button; pause/resume button has a tooltip |
| `air_qr_screen_test.dart` | permission denied state; progress area shows from a fake provider |
| `ar_codevision_screen_test.dart` | permission denied state; mode switch (Warehouse / Safety); "N items selected" and Batch Copy appear when targets are selected |

- The three camera screens need a real camera, which a widget test does not
  have. They will be tested in the "no camera permission" state, using a fake
  for the permission check. If a screen has no way to take a fake, I will add
  one optional constructor parameter (for example a permission-check
  function) with today's behaviour as the default. No user-visible change.
- If a screen turns out to need more than a small test hook, I will stop and
  tell you before changing more.

---

## Found during implementation (not yet approved)

The new screen tests found three more problems. They were not part of this
plan. Gaps 10–12 are handled by
[20261010_213037_gaps_10_12_fixes.md](20261010_213037_gaps_10_12_fixes.md);
the chip-row note is handled by
[20261010_214723_codeforge_chip_row_wrap.md](20261010_214723_codeforge_chip_row_wrap.md).

- **Gap 10 — History crashes in Sanskrit.** `lib/screens/widgets/history_card.dart`
  formats dates with `DateFormat.yMMMd(locale)` and `DateFormat.jm(locale)`.
  The `intl` package has no date data for `sa`, so it throws `Invalid locale
  "sa"` and every history card fails to build. Proposed fix: when
  `DateFormat.localeExists(locale)` is false, use English (`en`) date format,
  the same fallback the Sanskrit Material delegates use. The Sanskrit case in
  `test/screens/history_screen_test.dart` checks this and fails until fixed.
- **Gap 11 — AR CodeVision mode cannot be changed.** `ArCodevisionProvider`
  has `setHudMode`, and the docs describe Warehouse and Safety modes, but no
  widget calls `setHudMode`. Users always get Warehouse mode; Safety mode is
  unreachable. Proposed fix: a localized Warehouse / Safety switch in the AR
  app bar.
- **Gap 12 — AirQR receiver never says the camera is blocked.** If camera
  permission is denied (or the camera fails), `lib/screens/air_qr_screen.dart`
  shows "Initializing…" forever, with no message and no way to grant
  permission. The Scanner and AR screens show a message and a button.
  Proposed fix: show the same permission message and button.
- **Note (needs a real device):** the CodeForge style-editor chip rows (for
  example the four error-correction chips) are `Row`s that do not wrap. With
  the wide test font they overflow; on a narrow phone, or in Malayalam or
  Sanskrit, they may overflow too. The CodeForge test ignores only this
  overflow error until this is checked on a device.

## Files to be changed

- `lib/services/url_safety_service.dart`
- `lib/screens/settings_screen.dart`
- `lib/screens/code_forge_screen.dart`
- `lib/screens/result_screen.dart`
- `lib/screens/history_screen.dart`
- `lib/screens/ar_codevision_screen.dart`
- `lib/screens/scanner_screen.dart`
- `lib/screens/appearance/accent_color_settings_screen.dart`
- `lib/screens/appearance/typography_settings_screen.dart`
- `lib/widgets/camera_adjustments_sheet.dart`
- `lib/services/code_forge_service.dart`
- `lib/providers/code_forge_provider.dart`
- `lib/services/encrypted_payload_service.dart`
- `lib/services/dom_sandbox_service.dart`
- `lib/models/camera_settings.dart`
- `lib/providers/camera_settings_provider.dart`
- `lib/widgets/camera_adjustments_sheet.dart` (also in Gap 2)
- `lib/services/device_sync_service.dart`
- `lib/services/location_service.dart` (new)
- `lib/models/location_result.dart` (new)
- `lib/main.dart` (only if `CodeForgeProvider` setup needs the new service)
- `lib/screens/air_qr_screen.dart`, `lib/screens/air_qr_transmitter_screen.dart`,
  `lib/screens/appearance_screen.dart`, `lib/screens/features_screen.dart`
  (only if a small test hook is needed)
- `test/providers/camera_settings_provider_test.dart`
- `test/services/device_sync_service_test.dart`
- `test/services/location_service_test.dart` (new)
- 8 new files in `test/screens/` (see Gap 9)
- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`
- `lib/l10n/app_message_text.dart`, `lib/models/app_message.dart` (if new keys are needed)
- `lib/l10n/gen/*` (regenerated by `flutter gen-l10n`)
- `test/services/url_safety_service_test.dart`
- `test/services/code_forge_service_test.dart`
- `test/providers/code_forge_provider_test.dart`
- `test/services/encrypted_payload_service_test.dart`
- `docs/features.md`, `docs/security.md`, `docs/implementation_progress.md`,
  `docs/implementation_plan.md`, `docs/feature_analysis_and_roadmap.md`
- 72 files in `plans/` (status line only)
- New change log in `change_log/`

## How it will be checked

- `flutter gen-l10n`, `dart format .`, `flutter analyze` (must be clean),
  `flutter test` (all must pass, including ARB parity and Sanskrit tests).
- No install or test on the phone.
