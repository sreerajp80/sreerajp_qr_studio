# Change log: AirQR fountain code, block size, and doc fixes

Implements plan: [plans/20260926_220121_airqr_fountain_and_block_size_fixes.md](../plans/20260926_220121_airqr_fountain_and_block_size_fixes.md)

## What changed

### `lib/services/air_qr_service.dart`

- `defaultBlockSize` changed from 180 to **150**. This is now the only block size
  used by the app.
- Parity frames now pick their degree (how many pieces they mix) from the
  **Robust Soliton** distribution (`c = 0.1`, `delta = 0.5`). Before, the degree
  was spread evenly from 2 up to all pieces.
- New public method `generateParityFrames(systematicFrames, count:, seed:)`. It
  makes a new set of parity frames from the data frames. With no seed, every call
  gives different frames. It returns an empty list if the data frames are not a
  full set for one stream.
- `encodePayload` now uses `generateParityFrames` for its parity part. It has a
  new optional `paritySeed` parameter (for repeatable tests). Without it, parity
  frames are no longer the same on every call (the old fixed `Random(42)` is gone).
- The receiver now checks the CRC32 of each parity frame before using it, and
  drops it if the check fails.
- The receiver now ignores a frame whose `totalBlocks` does not match the active
  stream with the same stream ID.

### `lib/models/air_qr_frame.dart`

`AirQrFrame.parse` now returns `null` for:

- `totalBlocks` of 0 or less,
- a `v1` index out of range,
- a parity index list that is empty, has a number out of range, has a repeated
  number, or has a length that does not match the degree.

The repeated-number check was not in the plan. It was added because XOR-ing the
same piece twice cancels it out, so such a frame would give wrong data.

### `lib/screens/air_qr_transmitter_screen.dart`

- Removed `blockSize: 64` from both the text mode and device sync mode calls. The
  service default (150) is used.
- When the frame loop wraps back to the first frame, the parity frames are
  replaced with a fresh set (`_refreshParityFrames`). Data frames stay the same,
  and the total frame count does not change.

### Docs and text

- `lib/screens/help/air_qr_help_screen.dart`: removed "Reed-Solomon" (now says
  fountain-code repair frames), fixed the FPS range to 5 to 25, and removed the
  claim that the chunk size can be set.
- `lib/l10n/app_en.arb`: `airQrSamplePayload` no longer says "256-byte chunks".
  Generated files updated with `flutter gen-l10n`. `app_ml.arb` and `app_sa.arb`
  were not changed (their text has no block size, and no keys changed).
- `README.md`: "256-byte chunks" → "small chunks (150 bytes by default)".
- `docs/architecture.md` and `docs/project_structure.md`: "Reed-Solomon" → "LT
  fountain code (XOR parity)"; the model entry `air_qr_packet.dart` /
  `AirQrPacket` (which does not exist) is replaced by `air_qr_frame.dart` /
  `AirQrFrame` and `air_qr_progress.dart` / `AirQrProgress`.

### Tests

- `test/services/air_qr_service_test.dart`: the existing parity recovery test now
  passes `paritySeed: 42` so it stays repeatable. New tests for the degree
  spread, fresh parity per seed, rebuilding after losing about 30% of data frames,
  rejecting a corrupted parity frame, ignoring a frame with a different
  `totalBlocks`, and the default frame size staying within QR version 10 level L
  (271 characters).
- `test/models/air_qr_frame_test.dart` (new): parser safety tests.

## Change from the plan

The plan said the degree test would check that over 70% of degrees are 1–3 for 50
pieces. A correct Robust Soliton spread gives about 62% for 50 pieces, because it
adds a planned "spike" of higher degrees (around 15 here) that helps finish the
decoding. The test now checks for more than 50% with degree 1–3 and an average
degree under 10. The old code gave about 4% and an average of about 26.

## Checks

- `dart format lib test`: no changes needed.
- `flutter gen-l10n`: done.
- `flutter analyze`: no issues.
- `flutter test`: all 375 tests pass.

## Still to do

- Check the new block size on two real phones. Time the same payload at 64, 120,
  150, 180 and 256 bytes, then set `defaultBlockSize` to the fastest one.
- Help screens are still hard-coded English (out of scope; separate task).
