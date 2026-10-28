# Change log: Make the AirQR "Data to send" box bigger

Implements plan: `plans/20261028_201626_airqr-bigger-data-box.md`

## What changed

- `lib/screens/air_qr_transmitter_screen.dart`: the custom-text `TextField`
  ("Data to send") changed from `maxLines: 3` to `minLines: 6, maxLines: 12`.
  The box now starts at 6 lines tall, grows as the user types, and scrolls
  inside after 12 lines.

No new text, no ARB changes, no logic changes.

## Checks

- `dart format`: no changes needed.
- `flutter analyze`: no issues found.
- `flutter test`: all 903 tests passed.
- Not checked on a device.
