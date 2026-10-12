# AirQR: fountain code, block size, and doc fixes

**Status:** completed

## Summary

AirQR sends data from one phone to another as a loop of QR codes. A review found
problems in how it builds its repair ("parity") frames, how it picks the block
size, how the receiver checks frames, and in the docs that describe it. This plan
fixes all of them in one change.

Target layers: `services` (main logic), `models` (frame parsing), `screens`
(transmitter loop, help text), `l10n` (one sample string), and docs.

## Files to change

| File | Change |
| ---- | ------ |
| `lib/services/air_qr_service.dart` | Robust Soliton degree choice; new method to make fresh parity frames; parity checksum check; frame safety checks; new default block size |
| `lib/models/air_qr_frame.dart` | Reject frames with bad indices or a degree that does not match the index list |
| `lib/screens/air_qr_transmitter_screen.dart` | Remove the hard-coded `blockSize: 64` (2 places); make fresh parity frames on each loop |
| `lib/screens/help/air_qr_help_screen.dart` | Fix wrong facts in the text (Reed-Solomon, FPS range, chunk size control) |
| `lib/l10n/app_en.arb` | `airQrSamplePayload`: remove the wrong "256-byte" number |
| `docs/architecture.md` | Fix "Reed-Solomon"; fix the model name `air_qr_packet.dart` / `AirQrPacket` → `air_qr_frame.dart` / `AirQrFrame`; add `air_qr_progress.dart` |
| `docs/project_structure.md` | Same fixes as `architecture.md` |
| `README.md` | Fix "256-byte chunks" line |
| `test/services/air_qr_service_test.dart` | New tests (listed below) |
| `test/models/air_qr_frame_test.dart` (new) | Parser safety tests |

`app_ml.arb` and `app_sa.arb` do not change. Their `airQrSamplePayload` text does
not mention a block size, and no keys are added or removed.

## Issues

### 1. Poor degree choice for parity frames

`encodePayload` picks each parity frame's degree (how many pieces it mixes)
evenly at random from 2 up to all pieces:

```dart
final degree = min(totalBlocks, max(2, rand.nextInt(totalBlocks) + 1));
```

The receiver can only use a parity frame when all but one of its pieces are
already known. With this spread, about half the parity frames mix more than half
of all pieces, so they are useless until the transfer is almost done. They also
carry a long list of piece numbers, which makes the QR code bigger and harder to
read.

### 2. The same parity frames repeat forever

Only `50%` extra parity frames are made once, with a fixed seed (`Random(42)`).
The transmitter then loops the same list. If a missing piece is not covered by
any of those parity frames, the receiver must wait for that one data frame to come
around again. A real fountain code keeps making new, different repair frames.

### 3. Block size is set in two places with different values

- `AirQrService.defaultBlockSize = 180`
- The transmitter screen passes `blockSize: 64` in both text mode and device sync
  mode, so 180 is never used.
- The sample text and README say "256-byte chunks".

64 bytes is safe but slow: it sends about a third of the data per frame compared
with 180.

### 4. Parity frames are not checked on arrival

Data frames are checked with CRC32 before use. Parity frames are not. A parity
frame that the camera misread can put a wrong piece into the result. Then the
full-message check fails and the user sees an error, with no way to recover
except a reset.

### 5. Frame parser accepts unsafe values

`AirQrFrame.parse` does not check that piece numbers are between `0` and
`totalBlocks - 1`, or that the degree matches the list length. A bad index is
stored as a "resolved" piece. The receiver counts pieces, not the right pieces, so
it can think it is done too early and then fail. A frame with a different
`totalBlocks` for the same stream ID is also accepted. (Hard rule 4: never crash
or break on malformed input.)

### 6. Wrong facts in docs and help text

- `docs/architecture.md` and `docs/project_structure.md` say "Reed-Solomon". The
  code uses an LT fountain code with XOR. (Reed-Solomon is already inside each QR
  code; AirQR does not add it.)
- Both docs name a model file `air_qr_packet.dart` / `AirQrPacket` that does not
  exist. The real files are `air_qr_frame.dart` (`AirQrFrame`) and
  `air_qr_progress.dart`.
- The help screen says "Reed-Solomon", says the FPS range is "5 to 20" (the slider
  is 5 to 25), and says you can set the chunk size (there is no such control).
- `airQrSamplePayload` and `README.md` say "256-byte chunks".

## Fix plan

### A. Robust Soliton degree choice (`air_qr_service.dart`)

- Add a private static helper that builds the **Robust Soliton** distribution for
  `k = totalBlocks` pieces (the standard choice for LT codes). Use the usual
  settings `c = 0.1` and `delta = 0.5`. It makes most frames mix 1–3 pieces and
  only a few mix many.
- Build the table of chances once per call, then pick each degree from it with the
  random generator.
- Special cases: when `k == 1`, the degree is always 1. Cap the degree at `k`.
- The frame format (`LT1|...|degree:i,j,k|...`) does not change, so old and new
  app versions can still read each other's frames.

### B. Fresh parity frames on every loop

- Split parity creation out of `encodePayload` into a new public static method:
  `generateParityFrames(List<AirQrFrame> systematicFrames, {required int count, int? seed})`.
  It rebuilds the source pieces from the data frames and makes `count` new parity
  frames. With no seed it uses a new random generator, so each call gives
  different frames. Tests pass a seed to get repeatable results.
- `encodePayload` keeps its current signature and output (data frames first, then
  parity frames). It calls the new method, so existing callers and tests still work.
- Transmitter screen: when the loop wraps back to frame 0, replace the parity part
  of `_encodedFrames` with a fresh set from `generateParityFrames`. The data
  frames stay the same. This is a light task (a few XORs over small blocks), so it
  is safe to do in the timer.

### C. One block size

- Change `AirQrService.defaultBlockSize` to **150**. At QR error level L this
  gives about 230 characters per data frame (QR version 9–10), and it leaves room
  for the parity index list at the current QR size of 240.
- Remove `blockSize: 64` from both calls in the transmitter screen, so the service
  default is the only value.
- Note in the change log that the best value depends on the phones, and should be
  checked with a real two-phone test (64 / 120 / 150 / 180 / 256).

### D. Check parity frames (`air_qr_service.dart`)

- In `processFrameString`, check the CRC32 of a parity frame's payload before
  using it. Drop it silently if it fails, the same way bad data frames are dropped.

### E. Safer parsing and stream checks

- `AirQrFrame.parse`: return `null` if
  - `totalBlocks <= 0`,
  - any index is `< 0` or `>= totalBlocks`,
  - the index list is empty, or its length does not match `degree`,
  - a `v1` frame has an out-of-range `sequenceIndex`.
- `AirQrService.processFrameString`: ignore a frame whose `totalBlocks` does not
  match the active stream's `totalBlocks`.

### F. Fix docs and text

- `docs/architecture.md` and `docs/project_structure.md`: say "LT fountain code
  (XOR parity)" instead of "Reed-Solomon"; fix the model file names and class name.
- `lib/screens/help/air_qr_help_screen.dart`: fix the three wrong facts. Keep the
  current style of the screen (see "Out of scope" below).
- `app_en.arb` `airQrSamplePayload`: change to
  "AirQR High-Speed Optical Air-Gap Transfer Test Payload. This payload is split
  into small chunks with Fountain FEC error correction." Then run
  `flutter gen-l10n`.
- `README.md`: change "256-byte chunks" to "small chunks (150 bytes by default)".

### G. Tests

In `test/services/air_qr_service_test.dart`:

- Degree choice: over many draws (fixed seed), all degrees are between 1 and `k`,
  and most are small (over 50% are 1–3 and the average degree is under 10 for `k = 50`; see the change log for why this is not 70%).
- `generateParityFrames`: two calls with different seeds give different frames;
  the same seed gives the same frames.
- Loss test: with a fixed seed, drop about 30% of data frames at random, then feed
  fresh parity sets until done. The message must be rebuilt exactly.
- A parity frame with a changed payload is rejected and does not break the result.
- A frame with a different `totalBlocks` for the same stream ID is ignored.
- Frame size: for the default block size, every data frame's `toQrString()` is at
  most 271 characters (QR version 10, level L, byte mode limit).
- Existing tests keep passing.

New `test/models/air_qr_frame_test.dart`:

- `parse` returns `null` for out-of-range indices, a degree/list mismatch, an empty
  list, and `totalBlocks` of 0 or less. None of these throw.

### H. Checks after the change

- `dart format .`
- `flutter gen-l10n`
- `flutter analyze` (must be clean)
- `flutter test` (all pass, including ARB key parity tests)

## Out of scope (noted, not fixed here)

- **Help screens are not localized.** All the help screens under
  `lib/screens/help/` use hard-coded English text, which breaks the project's
  three-language rule. Moving them to ARB files (with Malayalam and Sanskrit
  translations) is a large separate job and should have its own plan.
- **RaptorQ.** A stronger fountain code, but complex, with no mature open-source
  Dart package. Not needed for now.

## Risks

- Old app versions receiving from the new app: the frame format is the same, so
  they can still read the frames. They just benefit less.
- Frames from the new transmitter are bigger (150 bytes against 64). On a weak
  camera, more frames may be missed. The fountain fix (A + B) makes up for this,
  but it should be checked on real phones.
