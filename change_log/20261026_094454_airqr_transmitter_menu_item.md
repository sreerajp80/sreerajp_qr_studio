# Change log: AirQR transmitter as its own menu item

Implements plan: `plans/20261026_094234_airqr_transmitter_menu_item.md`

## What changed

- `lib/screens/scanner_screen.dart` — added an "AirQR transmitter" item to the scanner's
  more-options (⋮) menu, right after "AirQR receiver". It opens `/air_qr_transmitter`,
  uses the `Icons.cast` icon and the existing `titleAirQrTransmitter` text. It goes
  through `_navigateToRoute`, so the scanner camera is stopped before the screen opens.
- `lib/screens/air_qr_screen.dart` — removed the transmitter button (QR icon) from the
  receiver's top bar, with its camera stop/restart code. The reset button stays.
- `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` — removed the now unused
  `tooltipAirQrTransmitter` key (and its `@` entry). Ran `flutter gen-l10n`, so
  `lib/l10n/gen/*` is updated.
- `test/screens/air_qr_screen_test.dart` — the permission test now also checks that the
  transmitter button is no longer on the receiver screen.

Other ways into the transmitter are unchanged: Settings → AirQR sync, and the
"Beam via AirQR" button in the export dialog.

## Checks

- `dart format` — no changes needed.
- `flutter analyze` — no issues.
- `flutter test` — all 888 tests pass.
- Not yet checked on a device.

## Notes for review

- The Malayalam menu label "എയർ ക്യുആർ ട്രാൻസ്മിറ്റർ" (reused screen title) is about
  24 characters, a little over the 22-character menu label limit. Kept as is, as agreed
  in the plan.
