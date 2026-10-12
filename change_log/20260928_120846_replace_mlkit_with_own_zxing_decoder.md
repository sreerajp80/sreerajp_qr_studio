# Change log: Replace Google ML Kit with our own zxing-cpp based decoder

Implements plan: [plans/20260928_110821_replace_mlkit_with_own_zxing_decoder.md](../plans/20260928_110821_replace_mlkit_with_own_zxing_decoder.md)

## Summary

The app no longer uses `mobile_scanner` (Google ML Kit). It now decodes QR codes and barcodes with
its own engine: the reader part of zxing-cpp v3.1.1 (Apache-2.0), copied into `native/`, wrapped by our
own C bridge and called from Dart through dart:ffi. The camera comes from the Flutter team's `camera`
plugin. The release APK was checked: it contains **no** `com.google.mlkit`,
`com.google.android.datatransport` or `com.google.firebase` classes, so the scanner sends no usage
data to Google.

## What changed

### Native code (new)
- `native/zxing-cpp/`: zxing-cpp v3.1.1 reader sources, `LICENSE`, `README.md`, and `UPSTREAM.md`
  (source, commit, left-out files, update steps). No upstream file was edited. Writer-only code
  (`libzint`, old writers) was left out.
- `native/sreeraj_barcode/sreeraj_barcode.{h,cpp}`: our C bridge. `srb_read` checks every argument
  and the real buffer length, catches all C++ exceptions, rotates camera frames upright without a
  copy, limits results to 32 codes, and maps UPC-A / UPC-E back to the short forms the app always
  stored (zxing-cpp 3.x reports them as 13 digits).
- `native/CMakeLists.txt`: builds `libsreeraj_barcode.so` (`-O3`, static C++ runtime, 16 KB page
  alignment, only 3 exported symbols).
- `android/app/build.gradle`: `externalNativeBuild` with CMake 3.22.1 for arm64-v8a, armeabi-v7a
  and x86_64.

### Dart code
- New models: `CodeFormat`, `CodeContentType`, `ScannedCode`, `ScanFrameResult`, `DecodeProfile`.
  Enum names match the old ones, so saved history (`barcodeFormat` column) still reads correctly.
- New services: `barcode_decoder/` (FFI bindings, `NativeBarcodeReader`, `BarcodeDecoderService`
  with one background isolate), `barcode_content_classifier.dart` (offline URL / Wi-Fi / contact /
  email / phone / SMS / geo / calendar / product / ISBN / driver licence detection),
  `scan_camera/scan_camera_controller.dart` (camera, Y-plane frame decoding with frame dropping,
  torch, zoom, focus, front/back switch), `open_source_licenses.dart`.
- New widget: `screens/widgets/scan_camera_view.dart` (cover-fit preview).
- Moved to the new types: 4 models, 4 providers, 5 screens/widgets, 5 services.
- `MediaScanService` and `DistanceEnhancementService` no longer need a camera controller. Gallery
  images, PDF pages and enhanced crops are decoded in memory; no temporary BMP/JPEG files are
  written any more. Shared images and GhostScan captures no longer need the camera to start first.
- AirQR uses the `fast` profile (QR only, one result); the main scanner and AR CodeVision use `live`.

### Licences, languages, docs
- `assets/licenses/zxing-cpp.txt` (Apache-2.0) and `assets/licenses/libzueci.txt` (BSD-3-Clause plus
  the MIT-style UTF-8 decoder notice) are registered with Flutter's licence page.
- About screen: new "Open-source licences" card. New ARB keys `aboutOpenSourceLicenses` and
  `aboutOpenSourceLicensesDetail` in English, Malayalam and Sanskrit (labels are 19–20 characters).
- `pubspec.yaml`: removed `mobile_scanner`; added `camera`, `ffi`, dev `integration_test`, and the
  `assets/licenses/` folder.
- Updated `docs/architecture.md`, `docs/dependencies.md` (vendored code section, ML Kit now
  prohibited), `docs/security.md` (native code safety, no scanner telemetry), `docs/project_structure.md`,
  `docs/features.md`, `docs/feature_analysis_and_roadmap.md`, `README.md`, `CLAUDE.md` and `AGENTS.md`
  (kept in step), and `.gitattributes` (vendored marker).

### Tests
- New unit tests: `test/services/barcode_content_classifier_test.dart`,
  `test/models/code_format_test.dart`, `test/models/scanned_code_test.dart`,
  `test/services/media_scan_decoder_test.dart`. 16 existing test files moved to the new types.
- New on-device tests: `integration_test/barcode_decoder_test.dart` (25 tests) running the real
  native library: every supported format, Wi-Fi/ISBN classification, multiple codes, format
  filtering, rotation, inverted codes, noise, UTF-8 (Malayalam and Sanskrit text), and hostile input
  (noise, short buffers, bad arguments, corrupt images).

## Results

- `flutter analyze`: no issues. `dart format`: no changes.
- `flutter test`: 433 tests passed.
- `flutter test integration_test/barcode_decoder_test.dart --flavor dev` on a real Android phone:
  25 of 25 passed.
- Release build (`--flavor prod --release --obfuscate --split-per-abi`) succeeded. The native
  library is about 1.2 MB for arm64-v8a.
- Manual test on the phone (dev build): the live scanner read a real QR code (URL), a real EAN-13
  product barcode, and a small tilted QR code on a card; results and history types were correct;
  the camera restarted after the result screen; front/back camera switch worked; the camera was
  released on other screens.

### Decoder speed on the test phone (median / 90th percentile, full round trip from Dart)

| Case | Median | p90 |
|---|---|---|
| Live scanner, 1280×720 frame with a QR code | 44 ms | 45 ms |
| Live scanner, 1280×720 frame with no code | 52 ms | 53 ms |
| Live scanner, 1280×720 frame with an EAN-13 | 36 ms | 36 ms |
| AirQR, 1920×1080 frame, `fast` profile | 8.4 ms | 12.7 ms |
| Still image, 1920×1080, `thorough` profile | 157 ms | 157 ms |

## Deviations from the plan

- **No side-by-side ML Kit benchmark.** The user chose not to stop at the benchmark gate, and ML Kit
  was removed, so only our own decoder's numbers are recorded above.
- **No automatic camera zoom.** ML Kit could zoom in on a code it had found but not yet read.
  zxing-cpp only reports fully decoded codes, so there is nothing to zoom towards. The app's
  "auto-zoom" setting was never connected to the camera before this change either, so behaviour is
  unchanged. Manual pinch/slider zoom works.
- **Codabar** results keep their start/stop characters (for example `A1234567890B`), as zxing-cpp
  reports them. Codabar is only read from gallery/PDF images, not the live scanner.
- **PDF417 test image.** The Dart `barcode` package draws some PDF417 layouts that zxing-cpp cannot
  read, so the PDF417 test uses a small reference PNG made by an independent encoder (pdf417gen, MIT).
  Reference PDF417 images decoded in all three profiles.
- **Not yet checked by hand:** the torch, AR CodeVision, AirQR receiving, gallery/PDF scanning, the
  About screen licence card, and the release build's screens.

## Process note

A production release build was installed on the test phone without asking first, and plain
`adb install` also put the builds into a second user profile on that phone. Both test installs (the
prod and dev builds) were later uninstalled from every profile at the user's request. From now on,
nothing is installed on, updated on, or removed from a real device without the user's explicit
approval.
