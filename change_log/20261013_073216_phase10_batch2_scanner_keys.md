# Phase 10, batch 2 — ARB key prefixes: scanner and inputs

Plan: [plans/20261013_071846_phase10_arb_key_prefixes.md](../plans/20261013_071846_phase10_arb_key_prefixes.md) — batch 2 of 10
(scanner and inputs: scan, camera, clipboard, GhostScan, Scan bubble, batch scan, PDF, media
errors, code-format names, multi-code selection).

## What changed

- Keys renamed to the standard prefixes (engineering standard §8.6) in all three ARB files and
  every Dart use (22 files); `flutter gen-l10n` re-run. Prefix by real use: icon-button
  tooltips → `tooltip…`, buttons → `action…`, sheet and dialog titles → `title…`, switch / row /
  chip labels and code-format names → `label…`, subtitles → `desc…`, snackbars and banners →
  `body…`, failures → `error…`, the empty batch state → `empty…`, the GhostScan steps → `help…`.
- `openPhish…` and `openRiskDialogIssues` were left for batches 4 and 3 (link safety, result).
- Unused keys deleted (listed below).
- Shortened values: 10 English labels/tooltips over 20 characters, and 4 Malayalam/Sanskrit
  values over 22 characters (**needs native-reader review** for the ml/sa ones).
- Tests that matched the old English wording (`scan_bubble_settings_screen_test.dart`,
  `ghost_scan_sheet_test.dart`) now match the new wording.

### Problem found and fixed during this batch
`AppMessageKey` enum constants share their names with some ARB keys (for example
`formatQrUrl`, `mediaNoCodeInImage`). The first run also renamed 46 `AppMessageKey.…`
references; `flutter analyze` caught it at once, those references were put back exactly, and
the rename script now never touches `AppMessageKey.…`. The enum itself is unchanged.

## Checks

- `flutter analyze` — no issues; `flutter test` — all 687 passed (label-length test now covers
  this batch); `dart format` check — no changes; Sanskrit gate — passed.

## Renamed keys (119)

| Old key | New key |
|---|---|
| `pdfResultsTitle` | `titlePdfResults` |
| `pdfPageBadge` | `labelPdfPageBadge` |
| `pdfPageLabel` | `labelPdfPage` |
| `pdfSaveAllButton` | `actionPdfSaveAll` |
| `pdfScanNote` | `bodyPdfScanNote` |
| `pdfSavedToHistory` | `bodyPdfSavedToHistory` |
| `scanFromGallery` | `tooltipScanFromGallery` |
| `scanPdfDocument` | `tooltipScanPdfDocument` |
| `scanPdfProgress` | `bodyScanPdfProgress` |
| `scanSharedPdfProgress` | `bodyScanSharedPdfProgress` |
| `scanInitializingCamera` | `bodyScanInitializingCamera` |
| `scanInitializingFeed` | `bodyScanInitializingFeed` |
| `scanZoomTooltip` | `tooltipScanZoom` |
| `scanFlipCameraTooltip` | `tooltipScanFlipCamera` |
| `scanZoomValue` | `labelScanZoomValue` |
| `scanViewfinderHint` | `helpScanViewfinder` |
| `scanCameraPermissionRequired` | `bodyScanCameraPermissionRequired` |
| `openAnywayButton` | `actionOpenAnyway` |
| `mediaNoCodeInImage` | `errorMediaNoCodeInImage` |
| `mediaNoCodeInPdf` | `errorMediaNoCodeInPdf` |
| `mediaImagePickFailed` | `errorMediaImagePickFailed` |
| `mediaImageAnalyzeFailed` | `errorMediaImageAnalyzeFailed` |
| `mediaPdfPickFailed` | `errorMediaPdfPickFailed` |
| `mediaPdfScanFailed` | `errorMediaPdfScanFailed` |
| `formatQrUrl` | `labelFormatQrUrl` |
| `formatQrEmail` | `labelFormatQrEmail` |
| `formatQrPhone` | `labelFormatQrPhone` |
| `formatQrSms` | `labelFormatQrSms` |
| `formatQrWifi` | `labelFormatQrWifi` |
| `formatQrLocation` | `labelFormatQrLocation` |
| `formatQrContact` | `labelFormatQrContact` |
| `formatIsbn` | `labelFormatIsbn` |
| `formatEanUpc` | `labelFormatEanUpc` |
| `formatQrCode` | `labelFormatQrCode` |
| `formatEanUpcProduct` | `labelFormatEanUpcProduct` |
| `formatBarcode` | `labelFormatBarcode` |
| `scanFlashOff` | `tooltipScanFlashOff` |
| `scanFlashOn` | `tooltipScanFlashOn` |
| `scanFlashAuto` | `tooltipScanFlashAuto` |
| `scanFlashAutoActive` | `bodyScanFlashAutoActive` |
| `cameraTuneTooltip` | `tooltipCameraTune` |
| `cameraTuneTitle` | `titleCameraTune` |
| `cameraBrightnessLabel` | `labelCameraBrightness` |
| `cameraContrastLabel` | `labelCameraContrast` |
| `cameraInvertLabel` | `labelCameraInvert` |
| `cameraInvertHint` | `descCameraInvert` |
| `cameraResolutionLabel` | `labelCameraResolution` |
| `cameraResolutionFullHd` | `tooltipCameraResolutionFullHd` |
| `cameraResolutionMax` | `tooltipCameraResolutionMax` |
| `cameraResolutionHd` | `tooltipCameraResolutionHd` |
| `cameraResetAdjustments` | `actionCameraReset` |
| `cameraDistanceEnhanceLabel` | `labelCameraDistanceEnhance` |
| `cameraDistanceEnhanceHint` | `descCameraDistanceEnhance` |
| `cameraUnsharpLabel` | `labelCameraUnsharp` |
| `cameraDistanceZoomLabel` | `labelCameraDistanceZoom` |
| `cameraStartFailed` | `errorCameraStartFailed` |
| `cameraNotFound` | `errorCameraNotFound` |
| `cameraRetryButton` | `actionCameraRetry` |
| `batchModeTooltip` | `tooltipBatchMode` |
| `batchModeEnabledToast` | `bodyBatchModeEnabled` |
| `batchModeDisabledToast` | `bodyBatchModeDisabled` |
| `batchCounterBadge` | `labelBatchCounter` |
| `batchReviewTitle` | `labelBatchReview` |
| `batchReviewSubtitle` | `descBatchReview` |
| `batchEmptyTitle` | `emptyBatchTitle` |
| `batchEmptySubtitle` | `emptyBatchBody` |
| `batchExport` | `titleBatchExport` |
| `batchClear` | `actionBatchClear` |
| `batchClearConfirmTitle` | `titleBatchClearConfirm` |
| `batchClearConfirmContent` | `bodyBatchClearConfirm` |
| `batchPreventDuplicates` | `labelBatchPreventDuplicates` |
| `batchScannedToast` | `bodyBatchScanned` |
| `batchAnalyzingUrl` | `bodyBatchAnalyzingUrl` |
| `batchUrlSafetySummary` | `bodyBatchUrlSafetySummary` |
| `batchItemDetailsTitle` | `titleBatchItemDetails` |
| `scanFromClipboard` | `tooltipScanFromClipboard` |
| `clipboardBannerTitle` | `bodyClipboardBanner` |
| `clipboardActionScan` | `actionClipboardScan` |
| `clipboardDismiss` | `tooltipClipboardDismiss` |
| `clipboardNoValidContent` | `errorClipboardNoValidContent` |
| `clipboardTypeUrl` | `labelClipboardTypeUrl` |
| `clipboardTypeBarcode` | `labelClipboardTypeBarcode` |
| `clipboardTypeImage` | `labelClipboardTypeImage` |
| `clipboardTypeText` | `labelClipboardTypeText` |
| `multiCodeDetectedBanner` | `bodyMultiCodeDetected` |
| `multiCodeTapToScan` | `tooltipMultiCodeTapToScan` |
| `multiCodeSelectionTitle` | `labelMultiCodeSelection` |
| `multiCodeSelectionSubtitle` | `descMultiCodeSelection` |
| `multiCodeDismissTooltip` | `tooltipMultiCodeDismiss` |
| `ghostScanTitle` | `labelGhostScan` |
| `ghostScanSubtitle` | `descGhostScan` |
| `ghostScanDescription` | `bodyGhostScan` |
| `ghostScanActionScanNow` | `actionGhostScanNow` |
| `ghostScanActionAddTile` | `actionGhostScanAddTile` |
| `ghostScanTileAdded` | `bodyGhostScanTileAdded` |
| `ghostScanHowItWorksTitle` | `titleGhostScanHowItWorks` |
| `ghostScanStep1` | `helpGhostScanStep1` |
| `ghostScanStep2` | `helpGhostScanStep2` |
| `ghostScanStep3` | `helpGhostScanStep3` |
| `ghostScanAnalyzing` | `bodyGhostScanAnalyzing` |
| `scanBubbleTitle` | `labelScanBubble` |
| `scanBubbleSettingsSubtitle` | `descScanBubbleSettings` |
| `scanBubbleSwitchTitle` | `labelScanBubbleSwitch` |
| `scanBubbleSwitchSubtitle` | `descScanBubbleSwitch` |
| `scanBubblePermissionGranted` | `descScanBubblePermissionGranted` |
| `scanBubblePermissionMissing` | `descScanBubblePermissionMissing` |
| `scanBubbleAllowButton` | `actionScanBubbleAllow` |
| `scanBubbleStartOnBootTitle` | `labelScanBubbleStartOnBoot` |
| `scanBubbleStartOnBootSubtitle` | `descScanBubbleStartOnBoot` |
| `scanBubbleAddTileButton` | `actionScanBubbleAddTile` |
| `scanBubbleTileAdded` | `bodyScanBubbleTileAdded` |
| `scanBubbleTileManual` | `bodyScanBubbleTileManual` |
| `scanBubblePermissionDialogTitle` | `titleScanBubblePermissionDialog` |
| `scanBubblePermissionDialogBody` | `bodyScanBubblePermissionDialog` |
| `scanBubbleOpenSettings` | `actionScanBubbleOpenSettings` |
| `scanBubbleStartFailed` | `errorScanBubbleStartFailed` |
| `scanBubbleBlockedCapture` | `errorScanBubbleBlockedCapture` |
| `scanPauseTooltip` | `tooltipScanPause` |
| `scanResumeTooltip` | `tooltipScanResume` |

## Deleted unused keys (13)

- `scanTorchTooltip` (not used anywhere in the code)
- `scanFlashAutoSensorUnavailable` (not used anywhere in the code)
- `cameraFocusTapHint` (not used anywhere in the code)
- `batchScanMode` (not used anywhere in the code)
- `batchSafeUrl` (not used anywhere in the code)
- `batchSuspiciousUrl` (not used anywhere in the code)
- `batchFormatLabel` (not used anywhere in the code)
- `batchTimeLabel` (not used anywhere in the code)
- `scanDistanceModeTooltip` (not used anywhere in the code)
- `scanDistanceModeActive` (not used anywhere in the code)
- `clipboardEmptyMessage` (not used anywhere in the code)
- `ghostScanTileLabel` (not used anywhere in the code)
- `ghostScanNoCodeFound` (not used anywhere in the code)

## Changed values

| Key | Language | Before | After |
|---|---|---|---|
| `titlePdfResults` | en | PDF Scan Results ({count}) | PDF codes ({count}) |
| `actionPdfSaveAll` | en | Save All ({count}) to History | Save all ({count}) |
| `tooltipScanFromGallery` | en | Scan Image from Gallery | Scan from gallery |
| `tooltipScanFlipCamera` | en | Flip Camera (Front/Back) | Switch camera |
| `labelCameraInvert` | en | Invert Colors (Negative Scan) | Invert colors |
| `tooltipCameraResolutionFullHd` | en | Full HD (1080p - Recommended) | 1080p, recommended |
| `tooltipCameraResolutionHd` | en | HD (720p - Battery Saver) | 720p, saves battery |
| `tooltipBatchMode` | en | Toggle Continuous Batch Scan | Batch scan mode |
| `actionGhostScanAddTile` | en | Add Quick Settings Tile | Add Settings tile |
| `actionScanBubbleAddTile` | en | Add to Quick Settings | Add Settings tile |
| `actionPdfSaveAll` | en | Save All ({count}) to History | Save all ({count}) |
| `actionPdfSaveAll` | ml | എല്ലാം ചരിത്രത്തിലേക്ക് സൂക്ഷിക്കുക ({count}) | എല്ലാം സൂക്ഷിക്കുക ({count}) |
| `actionPdfSaveAll` | sa | सर्वाणि इतिहासे रक्ष्यताम् ({count}) | सर्वं रक्ष्यताम् ({count}) |
| `titlePdfResults` | en | PDF Scan Results ({count}) | PDF codes ({count}) |
| `titlePdfResults` | ml | പിഡിഎഫ് സ്കാൻ ഫലങ്ങൾ ({count}) | പിഡിഎഫ് കോഡുകൾ ({count}) |
| `titlePdfResults` | sa | पि-डि-एफ् संवीक्षा-फलानि ({count}) | पि-डि-एफ्-सङ्केताः ({count}) |
| `tooltipCameraResolutionFullHd` | en | Full HD (1080p - Recommended) | 1080p, recommended |
| `tooltipCameraResolutionFullHd` | ml | ഫുൾ HD (1080p - ശുപാർശ ചെയ്യുന്നത്) | 1080p, ശുപാർശ |
| `tooltipCameraResolutionFullHd` | sa | पूर्ण-HD (१०८०p - संस्तुतम्) | १०८०p, संस्तुतम् |
| `tooltipCameraResolutionHd` | en | HD (720p - Battery Saver) | 720p, saves battery |
| `tooltipCameraResolutionHd` | ml | HD (720p - ബാറ്ററി ലാഭിക്കാം) | 720p, ബാറ്ററി ലാഭം |
| `tooltipCameraResolutionHd` | sa | HD (७२०p - मन्दशक्तिः) | ७२०p, मन्दशक्तिः |
