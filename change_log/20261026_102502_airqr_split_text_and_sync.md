# Change log: AirQR transmitter shows one job only (text or sync)

Implements plan: `plans/20261026_101201_airqr_split_text_and_sync.md`

## What changed

### `lib/screens/air_qr_transmitter_screen.dart`
- Removed the **Custom Text / Device Sync** toggle (`SegmentedButton`) at the top of the
  screen.
- The mode is now fixed by how the screen is opened:
  - From the AirQR menu: Custom Text only. Title "AirQR transmitter".
  - From Settings → AirQR Optical Sync, or Export/Import → Beam via AirQR
    (`syncMode: true`): Device Sync only. Title "AirQR Optical Sync"
    (existing key `titleAirQrSyncSettings`).
- **Extra fix found by the new test (not in the plan):** in sync mode the screen built the
  sync package straight from `didChangeDependencies`. If history was not loaded yet, this
  loaded it during the build step and Flutter threw "setState() called during build"
  (debug builds). The sync package is now built just after the first frame
  (`addPostFrameCallback`), once only (`_syncPrepareScheduled`). Same file, small change.

### `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` (+ regenerated `lib/l10n/gen/*`)
- Removed the two keys used only by the toggle: `labelAirQrModeText`,
  `labelAirQrModeSync` (and their `@` entries in `app_en.arb`). No new strings.

### `test/screens/air_qr_transmitter_screen_test.dart`
- Default screen: checks there is no toggle and no sync passphrase field.
- New test per language (`en`, `ml`, `sa`): opened in sync mode, the title is
  "AirQR Optical Sync", the passphrase field shows, the text payload field and the toggle
  do not.

## Not changed
- Frame building, PIN, encryption, streaming.
- The receiver screen (`air_qr_screen.dart`); it still detects sync packages by itself.

## Checks
- `dart format` — no changes needed.
- `flutter analyze` — no issues.
- `flutter test test/screens/air_qr_transmitter_screen_test.dart` — 9 tests pass.
- Full `flutter test` — all 891 tests pass.
- Not tested on a device.

## Translations
No new translations. Only unused keys were removed.
