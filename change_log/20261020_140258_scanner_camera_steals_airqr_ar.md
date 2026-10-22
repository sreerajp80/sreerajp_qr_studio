# Change log: AirQR Receiver and AR CodeVision camera no longer goes black

Implements plan: `plans/20261020_132321_scanner_camera_steals_airqr_ar.md`

## Problem

Opening AirQR Receiver or AR CodeVision from the Scan screen menu often showed a
black camera. Switching the camera made it work.

The cause: when the menu closed, the Scan screen waited 300 ms and started its own
camera again, even though the new screen was already on top. Android gave the
camera to the hidden Scan screen, so the new screen lost it.

## What changed

`lib/screens/scanner_screen.dart`

- Added `_isTopRoute`, which is true only when no other page is on top of the Scan
  screen (`ModalRoute.of(context)?.isCurrent`).
- The Scan screen now starts its camera only when `_isTopRoute` is true, in:
  - `didPopNext` (after the 300 ms wait, and before the retry),
  - `_navigateToRoute` (after the opened page returns, and before the retry),
  - `didChangeAppLifecycleState` on `resumed`,
  - `_resumeCamera` (when the Scan tab becomes active).
- Returning to the Scan screen still restarts its camera, because it is on top
  again.

No changes to `ScanCameraController`, the AirQR screen or the AR screen.

## Checks

- `flutter analyze`: no issues.
- `flutter test`: all 810 tests passed.
- Not yet checked on a device. Widget tests cannot run the real camera. To check by
  hand: open AirQR Receiver and AR CodeVision from the Scan menu about 10 times
  each, go back to Scan, and send the app to the background and back while AirQR
  is open.
