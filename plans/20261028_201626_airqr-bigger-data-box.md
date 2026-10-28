# Make the AirQR "Data to send" box bigger

**Status:** completed

## Files to change

- `lib/screens/air_qr_transmitter_screen.dart`

## The issue

On the AirQR transmitter screen, the "Data to send" text box shows only 3 lines
(`maxLines: 3`). Longer text is hard to read and edit, because the user must
scroll inside a very small box.

## The fix

Change the custom-text `TextField` (around line 328) from:

```dart
maxLines: 3,
```

to:

```dart
minLines: 6,
maxLines: 12,
```

- The box always shows at least 6 lines, so it starts about twice as tall.
- It grows as the user types, up to 12 lines. After that it scrolls inside.
- The screen body already scrolls, so the QR preview below just moves down.
- No new text, so no ARB changes. No logic change.

## Checks

- `dart format`, `flutter analyze`, `flutter test`.

## Security impact

None. Layout only.
