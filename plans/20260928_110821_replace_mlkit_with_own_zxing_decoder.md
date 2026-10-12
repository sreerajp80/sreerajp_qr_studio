# Replace Google ML Kit with our own zxing-cpp based decoder

**Status:** completed

---

## 1. What the issue is

The app scans codes with `mobile_scanner: ^7.2.0`. On Android, `mobile_scanner` uses
Google ML Kit (`com.google.mlkit:barcode-scanning`, the bundled model).

- Camera images and barcode contents stay on the phone.
- But ML Kit brings Google's `datatransport` (Firelog) library. It sends usage and
  performance metrics (device model, OS version, package name, API timings) to Google.
- The app holds the `INTERNET` permission for Safe Browsing and page preview, so these
  metrics can leave the phone even when the user never turns on online checks.

This goes against the spirit of the hard rules: offline-first, open source only, and no
analytics. We want a scanner that is **our own code**, with no Google or closed code in it.

## 2. Licence check of zxing-cpp (done)

Checked the upstream repository `github.com/zxing-cpp/zxing-cpp` at tag **v3.1.1**
(released 2026-07-29).

| Item | Result |
| --- | --- |
| Main licence | **Apache-2.0** (261 source files carry `SPDX-License-Identifier: Apache-2.0`) |
| Other licence inside | **BSD-3-Clause** in `core/src/libzueci/` (10 files). This is a character-set library (it turns ECI / Shift-JIS / GBK / Big5 bytes into text). The readers need it. |
| Writer-only code | `zint/` and `core/src/libzint/` (BSD-3). **Not needed**. We build with writers turned off, so we do not copy these folders. |
| `NOTICE` file | None upstream. So Apache-2.0 §4(d) adds no extra text we must copy. |
| Copyright holders | ZXing authors, Nu-book Inc., Huy Cuong Nguyen, Axel Waggershauser, gitlost, Jeremias Maerki, siiky, Antoine Mérino. All under the two licences above. |
| Closed or paid code | None. `Commercial Support.md` only offers paid support; the code is fully open. |

**What the licences ask of us (and what this plan does about it):**

1. Keep every original copyright and SPDX header in the copied files. → We copy the files
   as they are.
2. Ship a copy of the Apache-2.0 and BSD-3 licence texts with the app. → We add both
   texts to the app's "Open-source licences" page (see step 7).
3. Mark any upstream file that we change. → We try not to change upstream files at all.
   All our own code sits in separate files. If we ever must patch one, we add a
   "Modified by SreerajP QR Reader" note at the top and record it in `UPSTREAM.md`.
4. We may **not** claim we wrote zxing-cpp. → The README and About page will credit it.

Apache-2.0 and BSD-3 both allow us to copy, change and ship the code inside our app.
Both fit the "open source only" hard rule.

## 3. Code quality check of zxing-cpp (done)

| Area | Finding |
| --- | --- |
| Activity | Last push 2026-09-20. Releases v3.0.1 (Feb 2026) → v3.1.1 (Jul 2026). Not archived. |
| Community | ~2,000 GitHub stars, ~560 forks, 40 open issues. |
| Maintainers | One main maintainer (`axxel`, ~2,460 commits), then `huycn` (188) and `gitlost` (73). **Risk:** it depends mostly on one person. Because we copy the source into our repo, the app keeps working even if the project stops. |
| Size | About 300 `.cpp`/`.h` files, about 55,000 lines in `core/src` (readers + writers). Readers only is smaller. |
| Language | Modern C++20, with a clean plain-C API (`ZXingC.h`), which is ideal for Dart FFI. |
| Tests | Unit tests for each format, a Reed–Solomon test, and "black box" image tests with real photo sets for every format we use (QR, Code 128/39/93, EAN-8/13, UPC-A/E, PDF417, Data Matrix) plus false-positive sets. |
| Safety checks | CI runs on Linux, macOS and Windows. It runs AddressSanitizer + UndefinedBehaviorSanitizer and ThreadSanitizer builds, CodeQL and MSVC static analysis. It has 5 fuzz targets (fuzzing = feeding random broken data to find crashes). |
| Android | Upstream builds an Android library in CI (`wrappers/android`, CameraX based). We use it only as a reference, not as a dependency. |
| API fit | `ZXing_ReadBarcodes` reads many codes in one frame. `ZXing_Barcode_position` gives the 4 corner points (needed by AR CodeVision and multi-code). It accepts a plain luminance (grey) buffer with a row stride, so the camera's Y plane can be passed in with **no copy or colour conversion**. |

**Verdict:** good quality, well tested, safe licences. Fit for use.

## 4. What "our own code" means in this plan

- The zxing-cpp source is **copied into our repo** (vendored), pinned to v3.1.1, readers
  only. It is not pulled from pub.dev, Maven or the internet at build time.
- **We write** the C bridge, the Dart FFI bindings, the isolate worker, the decoder
  service, the models, and the content-type classifier. There is no third-party Flutter
  wrapper (for example, we do **not** use `flutter_zxing`).
- Camera: we use the Flutter team's `camera` plugin (BSD-3, CameraX on Android, no ML
  Kit). See "Open decisions" if you want to write our own camera code too.
- `mobile_scanner` and all ML Kit / `datatransport` code are **removed** from the app.

## 5. Files to be changed

### New files

| File | Layer / purpose |
| --- | --- |
| `native/zxing-cpp/` | Vendored upstream source: `core/src` reader files, `libzueci/`, `LICENSE`, `README.md`. No `zint/`, no writers, no tests or sample images. |
| `native/zxing-cpp/UPSTREAM.md` | Upstream URL, tag `v3.1.1`, commit hash, date copied, list of files left out, list of local patches (should be none). |
| `native/sreeraj_barcode/sreeraj_barcode.h` / `.cpp` | **Our** small C bridge. One function takes a grey image + options and returns a simple C struct array (format, text, raw bytes, 4 corners, ECI flag). Stops C++ exceptions from crossing into Dart. Also lets us tune for speed (for example "AirQR mode" = QR only, no try-harder). |
| `native/CMakeLists.txt` | Builds `libsreeraj_barcode.so` from our bridge + vendored reader sources. `ZXING_READERS=ON`, `ZXING_WRITERS=OFF`, `-O3`, NEON on arm64, `-ffunction-sections -fdata-sections`, stripped symbols. |
| `lib/services/barcode_decoder/barcode_ffi_bindings.dart` | Hand-written `dart:ffi` bindings to our bridge (small, easy to review; no code generator). |
| `lib/services/barcode_decoder/barcode_decoder_service.dart` | **Service layer.** `decodeFrame(...)` for live camera frames and `decodeImageFile(...)` for gallery / PDF / distance-enhance. Returns our own models. No `BuildContext`, no UI text. |
| `lib/services/barcode_decoder/barcode_decode_isolate.dart` | A long-lived background isolate (a separate Dart worker so the UI stays smooth). Drops new frames while it is busy, so the queue never grows. |
| `lib/services/barcode_content_classifier.dart` | **Service layer.** Our own replacement for ML Kit's `BarcodeType` (URL, Wi-Fi, contact, email, phone, SMS, geo, calendar, product/ISBN, text). zxing-cpp only gives raw text, so we classify it ourselves. It reuses the existing payload parsers where possible. |
| `lib/services/scan_camera_service.dart` | **Service layer.** Wraps the `camera` plugin: start/stop, switch camera, torch, zoom, focus point, frame stream (Y plane only), and our own simple auto-zoom (zoom in when a code is found but too small). |
| `lib/models/scanned_code.dart` | **Model layer.** Immutable `ScannedCode` (format, raw text, raw bytes, corners, content type). Replaces mobile_scanner's `Barcode`. |
| `lib/models/code_format.dart` | **Model layer.** Our own `CodeFormat` enum. Replaces `BarcodeFormat`. |
| `lib/models/code_content_type.dart` | **Model layer.** Our own `CodeContentType` enum. Replaces `BarcodeType`. |
| `lib/models/scan_frame_result.dart` | **Model layer.** Immutable result of one frame (list of codes + frame size + rotation), replaces `BarcodeCapture`. |
| `lib/screens/widgets/scan_camera_view.dart` | Camera preview widget that also maps corner points from sensor coordinates to screen coordinates (handles the 90° sensor rotation in portrait). Replaces the `MobileScanner` widget. |
| `test/services/barcode_decoder_service_test.dart` | Decodes a set of bundled test images (made by us with `qr_flutter` / the app's own Code Forge, so no licence issue) for every format we support. |
| `test/services/barcode_content_classifier_test.dart` | Checks each content type, plus broken and hostile inputs (hard rule 4: never crash). |
| `test/models/scanned_code_test.dart`, `test/models/code_format_test.dart` | Model tests. |
| `test/fixtures/barcodes/` | Our own generated test images. |
| `tool/benchmark_decoder.dart` (or an integration test) | Measures speed and success rate on a real phone. |

### Changed files

| File | Change |
| --- | --- |
| `pubspec.yaml` | Remove `mobile_scanner`. Add `camera` (BSD-3, Flutter team) and `ffi` (BSD-3, Dart team). |
| `android/app/build.gradle` | Add `externalNativeBuild { cmake { path "../../native/CMakeLists.txt" } }` and ABI filters (`arm64-v8a`, `armeabi-v7a`, `x86_64`). |
| `android/app/src/main/AndroidManifest.xml` | No ML Kit meta-data remains. Camera permission is unchanged and still asked at point of use. |
| `android/app/proguard-rules.pro` (if present) | Remove any ML Kit rules. |
| `lib/models/visible_barcode.dart`, `ar_code_target.dart`, `batch_scan_item.dart`, `clipboard_scan_data.dart` | Use `ScannedCode` / `CodeFormat` / `CodeContentType`; remove the `mobile_scanner` import. `VisibleBarcode.toBarcode()` is replaced by `toScannedCode()`. |
| `lib/providers/scan_provider.dart`, `ar_codevision_provider.dart`, `batch_scan_provider.dart`, `multi_code_selection_provider.dart` | Take `ScanFrameResult` / `ScannedCode` instead of `BarcodeCapture` / `Barcode`. The logic stays the same. |
| `lib/services/media_scan_service.dart`, `distance_enhancement_service.dart` | Call `BarcodeDecoderService.decodeImageFile` / `decodeGrey` instead of `controller.analyzeImage`. Distance-enhance can then pass the enhanced grey pixels **straight to the decoder**, with no temporary BMP file. This is faster and writes nothing to disk. |
| `lib/services/multi_code_service.dart`, `ar_spatial_service.dart`, `clipboard_scan_service.dart` | Switch to our models. |
| `lib/screens/scanner_screen.dart`, `ar_codevision_screen.dart`, `air_qr_screen.dart`, `result_screen.dart`, `lib/screens/widgets/multi_code_bounding_box_widget.dart` | Replace `MobileScanner` / `MobileScannerController` with `ScanCameraView` + `ScanCameraService`. Screens keep calling providers only. |
| Every other file that uses `BarcodeType` (22 files in total, including Code Forge) | Switch to `CodeContentType`. Where Code Forge only uses `BarcodeFormat` names for *making* codes, switch to `CodeFormat`. |
| The 16 test files that import `mobile_scanner` | Switch to our models. |
| `lib/main.dart` | Register the zxing-cpp Apache-2.0 and libzueci BSD-3 licence texts with `LicenseRegistry`. Nothing else, so `main.dart` stays thin. |
| About screen + `assets/config/app_config.json` | Add an "Open-source licences" entry that opens Flutter's `showLicensePage`. |
| `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` (+ regenerate `gen/`) | New keys for the licences button and any new camera error states, with `@key` descriptions and all three languages. Labels ≤ 22 characters. |
| `docs/architecture.md`, `docs/dependencies.md`, `docs/security.md`, `docs/project_structure.md`, `docs/features.md`, `README.md` | Describe the new decoder, the `native/` folder, the removed ML Kit, and the "no Google telemetry" guarantee. |
| `.gitattributes` (if needed) | Mark `native/zxing-cpp/**` as vendored so diffs and language stats ignore it. |

## 6. Plan for the fix (phases)

Each phase ends with `flutter analyze` clean and `flutter test` passing.

**Phase 1 — Native decoder (no app changes yet)**
1. Copy the zxing-cpp v3.1.1 reader sources into `native/zxing-cpp/` and write `UPSTREAM.md`.
2. Write our C bridge `sreeraj_barcode`.
3. Add the CMake build and wire it into `android/app/build.gradle` for both `dev` and `prod`
   flavors. Check that the `.so` builds for all three ABIs and check its size.

**Phase 2 — Dart side, next to the old scanner**
4. Add the models (`ScannedCode`, `CodeFormat`, `CodeContentType`, `ScanFrameResult`).
5. Add the FFI bindings, the isolate worker and `BarcodeDecoderService`.
6. Add `BarcodeContentClassifier` and its tests. Its output must match ML Kit's types on
   the same inputs, so the result screen and safety checks behave the same.
7. Add the unit tests using our own generated images.

**Phase 3 — Benchmark before switching (go / no-go gate)**
8. On a real phone, run the same image set through ML Kit and through our decoder.
   Record: median decode time per frame, success rate on clean codes, and success rate on
   hard codes (blurry, small, tilted, low light, damaged). Also check AirQR frames per
   second. The numbers go into the change log.
9. **Stop and report to you.** If our decoder is clearly worse on the hard set, we tune
   first (try-harder only on a second pass, cropping around the last seen code, etc.).
   We only move to Phase 4 with your OK.

**Phase 4 — Switch the app over**
10. Add `ScanCameraService` and `ScanCameraView` (preview, torch, zoom, focus, switch
    camera, corner mapping, our own auto-zoom).
11. Move the screens, providers, services and models to the new types, one feature at a
    time: main scanner → gallery/PDF/clipboard → distance-enhance → multi-code → AR
    CodeVision → AirQR.
12. Remove `mobile_scanner` from `pubspec.yaml`. Confirm that no `com.google.mlkit` or
    `com.google.android.datatransport` class is left in the APK (check with
    `apkanalyzer` or by listing the dex classes).

**Phase 5 — Licences, docs and checks**
13. Add the licence texts to `LicenseRegistry` and the "Open-source licences" button
    (all three languages).
14. Update the docs and README.
15. Final checks: `dart format .`, `flutter analyze`, `flutter test`, a `prod` release
    build with `--obfuscate --split-per-abi`, and a manual test of every scan feature on a
    real phone. Watch network traffic while scanning with Safe Browsing off and confirm
    that nothing is sent.
16. Write the change log in `change_log/`.

## 7. Risks

| Risk | How we handle it |
| --- | --- |
| Our decoder reads hard codes (blur, tiny, steep angle) worse than ML Kit. | Phase 3 benchmark is a go / no-go gate. Tuning options: a second "try harder" pass, cropping around the last code, and reusing the existing distance-enhance pipeline. |
| One main upstream maintainer. | Code is vendored and pinned. We can keep using and fixing it on our own. |
| Security bugs in native C++ code (malformed codes are attacker input). | Upstream uses fuzzing and sanitizers. Our bridge catches all C++ exceptions, checks all sizes and lengths, and always returns a safe empty result. We check upstream releases for security fixes every few months and record updates in `UPSTREAM.md`. |
| APK size grows. | Readers only, writers off, stripped, split per ABI. Expected roughly 1–2 MB per ABI, which replaces the ML Kit bundled model (about 2–3 MB). Measured in Phase 1. |
| The `camera` plugin lacks ML Kit's auto-zoom. | We write a simple auto-zoom of our own from the code's corner size. |
| Large change touching many files. | Phased. The app keeps working after every phase until the switch in Phase 4. |

## 8. Decisions (confirmed by the user)

1. **Camera code:** use the Flutter team's `camera` plugin.
2. **Phase 3 gate:** no stop after the benchmark. Record the numbers in the change log and
   continue straight to the switch-over, then test on a real device.
