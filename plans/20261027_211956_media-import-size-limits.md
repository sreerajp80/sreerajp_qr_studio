# Plan: Size limits for shared and imported images and PDFs

**Status:** completed

## Why

The guidelines review (`change_log/20261027_211559_adhere-to-updated-guidelines.md`) found that
images and PDFs from outside the app have no size check before decoding. Today:

- **Images** (gallery, file picker, share target, clipboard image): the whole file is read into
  memory with `readAsBytes()`. Pixel decoding is already safe: it is scaled down so no side is
  over 4096 px (`BarcodeDecoderService.maxImageDimension`). But a very large file (for example
  1 GB) is still read whole, which can run the phone out of memory and close the app.
- **PDFs** (file picker, share target): any file size and any page count are accepted. Each page
  is drawn at 2× its own size, so a page that claims a huge size (for example 14,400 pt wide)
  is drawn at 28,800 px, which can also run out of memory. A 2,000-page file runs for a very
  long time behind a dialog that cannot be closed.
- **Clipboard data URI** (`data:image/...;base64,...` text): decoded with no length check.

This breaks hard rule 4 ("never crash on malformed inputs") and the Security Baseline rule on
outside input (engineering standard §15.1).

## Security impact

Touches input from outside the app (share intents, file import, clipboard). The change only adds
checks; nothing is weakened.

## Proposed limits

| Input | Limit | Reason |
|---|---|---|
| Image file size | **50 MB** | Phone photos are about 2–15 MB; large panoramas and screenshots stay well under 50 MB. |
| PDF file size | **100 MB** | Scanned documents and statements are usually under 20 MB. |
| PDF pages checked | **first 100 pages** | Codes are almost always on the first pages. More pages are skipped, and the user is told: "Only the first 100 pages were checked." |
| PDF page drawing size | **longest side 4096 px** (still 2× for normal pages) | Same cap the image decoder already uses. A normal A4 page at 2× is about 1190 × 1684 px, so normal pages do not change. |
| Clipboard data URI text | **70 MB of text** (about 50 MB of image) | Same as the image limit after base64 decoding. |

A file over a size limit is not read. The user sees a friendly message, for example "This image
is too large to scan (over 50 MB)." No crash, no long wait.

## Fix

1. `lib/core/constants/app_constants.dart`: add `maxImportImageBytes`, `maxImportPdfBytes`,
   `maxPdfPagesScanned`, `maxPdfRenderDimension`, `maxClipboardDataUriChars`.
2. `lib/services/media_scan_service.dart`:
   - `scanImageFile`: check `File.length()` first; over the limit → `MediaScanResult` with
     `AppMessage(AppMessageKey.mediaImageTooLarge, args: {'maxMb': 50})`.
   - `scanPdfFile`: check file size first (`mediaPdfTooLarge`); scan only the first 100 pages;
     cap the draw size so the longest side is at most 4096 px; set a new
     `MediaScanResult.pagesSkipped` count when pages were skipped.
3. `lib/services/clipboard_scan_service.dart`: skip a data URI longer than the limit (it is then
   not offered as an image).
4. `lib/screens/scanner_screen.dart`: when `pagesSkipped > 0`, show a short snackbar
   (`bodyPdfPagesSkipped`) next to the normal result.
5. `lib/models/app_message.dart`, `lib/l10n/app_message_text.dart`: new keys
   `mediaImageTooLarge`, `mediaPdfTooLarge`.
6. ARB files (`app_en.arb` with `@` descriptions, `app_ml.arb`, `app_sa.arb`): new keys
   `errorImageTooLarge`, `errorPdfTooLarge`, `bodyPdfPagesSkipped`, with real translations;
   then `flutter gen-l10n`.
7. Tests in `test/services/media_scan_service_test.dart` (and the clipboard service test):
   too-large image, too-large PDF, normal file passes, data URI over the limit is ignored. The
   page cap and draw-size cap are tested through a small pure helper
   (`MediaScanService.pdfRenderSize`) so no real PDF engine is needed.
8. `docs/security.md` §3.1: add the limits to the share-target and file-import rows.
9. Change log in `change_log/`.

## Files to change

- `lib/core/constants/app_constants.dart`
- `lib/services/media_scan_service.dart`
- `lib/services/clipboard_scan_service.dart`
- `lib/screens/scanner_screen.dart`
- `lib/models/app_message.dart`, `lib/l10n/app_message_text.dart`
- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb` (+ generated files)
- `test/services/media_scan_service_test.dart`, `test/services/clipboard_scan_service_test.dart`
  (new or extended)
- `docs/security.md`
- `change_log/<timestamp>_media-import-size-limits.md`

## Checks

`dart format .`, `flutter analyze`, `flutter test`. No build is needed (Dart-only change), so
no Gradle daemon is started. Nothing is installed on a phone.

## Needs native-reader review

The three new messages in Malayalam and Sanskrit.
