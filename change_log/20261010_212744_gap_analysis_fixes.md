# Change log: gap analysis fixes

Implements plan: [plans/20261010_210523_gap_analysis_fixes.md](../plans/20261010_210523_gap_analysis_fixes.md)

## Result

- `flutter analyze`: no issues.
- `flutter test`: 559 passed, 1 failed. The failing test is the Sanskrit case
  of `test/screens/history_screen_test.dart`. It shows a real crash (Gap 10
  below) that is waiting for approval. Before this work there were 491 tests.

## Gap 1 — API keys handled only by the service

- `lib/services/url_safety_service.dart`: added named constants for the three
  secure-storage keys, and `hasApiKey`, `saveApiKey`, `deleteApiKey`,
  `countActiveProviders`. The service's own checks use the constants.
- `lib/screens/settings_screen.dart`: no longer imports or uses
  `FlutterSecureStorage`. It calls the service methods, and never reads a key
  value back.
- Tests: 7 new cases in `test/services/url_safety_service_test.dart`.

## Gap 2 — English text moved into the translation files

- 29 new keys in `app_en.arb` (with descriptions), `app_ml.arb` and
  `app_sa.arb`. Key parity is kept (1203 keys each). The Sanskrit check and
  the ≤ 22-character limit for labels pass.
- Screens now use `AppLocalizations`: `code_forge_screen.dart`,
  `result_screen.dart`, `history_screen.dart` (plural count),
  `ar_codevision_screen.dart` (plural count), `settings_screen.dart`,
  `appearance/accent_color_settings_screen.dart`,
  `appearance/typography_settings_screen.dart`. "QR Code" reuses the existing
  `formatQrCode` key.
- `CodeForgeService.validateContent` now returns `AppMessage?` (new keys
  `codeForgeContentEmpty`, `codeForgeTextTooLong`,
  `codeForgeWifiSsidRequired`, `codeForgeUpiVpaRequired`,
  `codeForgeBarcodeInvalid`). The barcode package's own English detail is
  passed as an argument inside a localized sentence.
- `DomSandboxResult` has a new `fetchFailed` flag. The service no longer
  writes "(Offline / Network Restricted)". The preview card adds the localized
  `domFetchFailedTitle` text.
- `UrlSafetyService` lookalike list now uses "x → y" instead of the English
  "x (looks like y)".
- Not changed, on purpose: brand names (Google Safe Browsing, URLhaus),
  protocol tokens (WPA, WEP), barcode type names (Code 128, EAN-13, Data
  Matrix…), the "+20%" brightness number, and the encrypted-payload fallback
  titles in `encrypted_payload_service.dart`. On checking, those titles are
  never shown; the result screen shows the scanned text and its own
  localized card titles.
- Tests: new cases in `code_forge_service_test.dart` and
  `dom_sandbox_service_test.dart`.

## Gap 3 — Tooltips

- Wi-Fi password show/hide button in CodeForge: reuses `wifiShowPassword` /
  `wifiHidePassword`.
- Scanner pause/resume button: new `scanPauseTooltip` / `scanResumeTooltip`.
  This button only appears once the camera is running, so a widget test
  cannot reach it; it was checked by code scan.

## Gap 4 — Dead code removed

- `settings_screen.dart`: removed `AppearanceSettingsScreen`, the second
  `ScanOverlaySettingsScreen`, `SafeBrowsingSettingsScreen` and
  `HelpSettingsScreen` (1919 → about 1530 lines).
- `models/camera_settings.dart`: removed the unused `CameraSettings` class;
  the two enums stay.
- Removed 32 ARB keys that only those classes used, from all three files.

## Gap 5 — Docs

- `docs/features.md`: new CodeForge section; scan from clipboard,
  multi-code selection, camera settings sheet, onboarding; extra URL safety
  providers; device sync; Wi-Fi connect behaviour; appearance and language
  settings; gallery/PDF formats; no hard-coded version; note that AR Safety
  mode cannot be selected yet.
- `docs/security.md`: added the location and Wi-Fi/network permissions; noted
  that `VIBRATE` is not declared (haptics use `HapticFeedback`).
- `docs/implementation_progress.md`: rewritten for version 4.0.4+33 and the
  own decoder.
- `docs/implementation_plan.md`, `docs/feature_analysis_and_roadmap.md`:
  marked as history; old `mobile_scanner` / v1.4.3 text no longer reads as
  current.

## Gap 6 — Plan statuses

- 62 plan files changed to `**Status:** completed`; 4 plan files with no
  status line got one. Only the status line changed.

## Gap 7 — Camera brightness, contrast and invert are saved

- `camera_settings_provider.dart`: new keys `camera_brightness`,
  `camera_contrast`, `camera_invert_colors`. Invert saves on change;
  brightness and contrast save once when the slider is released
  (`saveImageAdjustments`, called from `onChangeEnd` in
  `camera_adjustments_sheet.dart`). Loading clamps the values and ignores a
  wrong type. `resetAdjustments` removes the saved values.
- `device_sync_service.dart`: copies the three keys. Plain key strings are
  used so the service does not import a provider; a test checks the strings
  match the provider's.
- Tests: 4 new cases in `camera_settings_provider_test.dart`, 2 in
  `device_sync_service_test.dart`.

## Gap 8 — Location lookup moved out of the CodeForge screen

- New model `lib/models/location_result.dart` and service
  `lib/services/location_service.dart` (permission at point of use, 15-second
  limit, never throws, no UI text).
- `CodeForgeProvider` gets `fetchCurrentLocation()` and `isFetchingLocation`;
  the service is passed in through the constructor.
- `code_forge_screen.dart` no longer imports `geolocator` or
  `permission_handler`.
- Tests: `test/services/location_service_test.dart` (4 cases) and 4 new cases
  in `code_forge_provider_test.dart`.

## Gap 9 — Widget tests for 8 screens

- New helper `test/helpers/test_app.dart`: builds the app with the real
  localization delegates, fakes the Android channels for the camera screens
  ("camera permission denied"), and can ignore only "RenderFlex overflowed"
  errors.
- New test files in `test/screens/`: `appearance_screen_test.dart`,
  `features_screen_test.dart`, `history_screen_test.dart`,
  `code_forge_screen_test.dart`, `air_qr_transmitter_screen_test.dart`,
  `scanner_screen_test.dart`, `air_qr_screen_test.dart`,
  `ar_codevision_screen_test.dart`.
- No test hooks were needed in the app code; the camera screens are tested by
  faking the platform channels.
- Planned checks that could not be done in a widget test, because they need
  a running camera: the scanner pause/resume button, and the AR mode switch,
  selection count and Batch Copy bar. AR selection is still covered by
  `test/providers/ar_codevision_provider_test.dart`.

## Found during this work, not fixed (waiting for approval)

- **Gap 10:** History screen crashes in Sanskrit (`intl` has no `sa` date
  format).
- **Gap 11:** AR CodeVision has no control to switch to Safety mode.
- **Gap 12:** AirQR receiver shows "Initializing…" forever when the camera is
  blocked.
- **Device check:** the CodeForge style-editor chip rows may overflow on
  narrow phones.

Details and proposed fixes are in the plan, under "Found during
implementation".
