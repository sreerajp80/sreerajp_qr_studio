# Change Log: Size limits for shared and imported images and PDFs

Implements plan [plans/20261027_211956_media-import-size-limits.md](../plans/20261027_211956_media-import-size-limits.md).
Follows up the open item in
[change_log/20261027_211559_adhere-to-updated-guidelines.md](20261027_211559_adhere-to-updated-guidelines.md).

## Security impact

Only adds checks on input from outside the app (share target, file import, clipboard). A very
large or hostile file can no longer run the phone out of memory. Nothing was weakened.

## Limits now in force

| Input | Limit |
|---|---|
| Image file (gallery, file picker, share, clipboard image file) | 50 MB — checked before the file is read |
| PDF file (file picker, share) | 100 MB — checked before the file is opened |
| PDF pages checked | First 100; the user sees "Only the first 100 pages were checked." |
| PDF page drawing size | 2× the page size, but at most 4096 px on the longest side |
| Clipboard `data:image/...;base64,` text | About 70 MB of text (50 MB of image); longer text is not offered as an image |

## What changed

| File | Change |
|---|---|
| `lib/core/constants/app_constants.dart` | New constants: `maxImportImageMb/Bytes`, `maxImportPdfMb/Bytes`, `maxPdfPagesScanned`, `maxPdfRenderDimension`, `maxClipboardDataUriChars`. |
| `lib/services/media_scan_service.dart` | `scanImageFile` and `scanPdfFile` check the file size first. `scanPdfFile` checks only the first 100 pages and draws each page with the new `pdfRenderSize` helper. `MediaScanResult` has a new `pagesSkipped` field. The limits can be passed in (`maxImageBytes`, `maxPdfBytes`) for tests. |
| `lib/services/clipboard_scan_service.dart` | A data URI longer than `maxDataUriChars` is not decoded. |
| `lib/screens/scanner_screen.dart` | Shows a short note when PDF pages were skipped. |
| `lib/models/app_message.dart`, `lib/l10n/app_message_text.dart` | New keys `mediaImageTooLarge`, `mediaPdfTooLarge`. |
| `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` (+ generated files) | New strings `errorMediaImageTooLarge`, `errorMediaPdfTooLarge`, `bodyPdfPagesSkipped`. |
| `test/services/media_scan_decoder_test.dart` | Tests: image over the limit is not read; image at the limit is read; PDF over the limit is not opened; default limits; `pdfRenderSize` for A4, a huge page, and a tall page. |
| `test/services/clipboard_scan_service_test.dart` | Test: a data URI over the limit is ignored. |
| `docs/security.md` | §3.1 entry-point rows list the new limits. |

## Changes from the plan

- The new tests went into the existing `test/services/media_scan_decoder_test.dart`, which
  already has the fake decoder, rather than `media_scan_service_test.dart`.
- The new ARB keys follow the file's existing naming (`errorMedia…`), so they are
  `errorMediaImageTooLarge` and `errorMediaPdfTooLarge` instead of `errorImageTooLarge` and
  `errorPdfTooLarge`.

## Checks done

- `flutter gen-l10n`, `dart format .` (0 changed), `flutter analyze` — no issues.
- `flutter test` — all 903 tests pass.
- No build was run (Dart-only change), so no Gradle daemon was started. Nothing was installed on
  a phone.

## Needs native-reader review

- Malayalam: `errorMediaImageTooLarge`, `errorMediaPdfTooLarge`, `bodyPdfPagesSkipped`.
- Sanskrit: the same three keys.
