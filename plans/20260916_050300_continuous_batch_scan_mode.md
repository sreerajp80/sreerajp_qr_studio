# Continuous Batch Scan Mode Plan

**Status:** Approved

## Problem
In `docs/feature_improvements_and_roadmap.md` item 2.1.1, the scanner only supports a single scan flow:
When any barcode is scanned, the camera immediately stops and navigates to the result screen.
Warehouse workers, retail staff, and inventory professionals need to scan multiple barcodes in rapid succession without leaving the camera viewport.
Furthermore, no existing competitor combines continuous batch scanning with 6-layer URL safety verification.

## Proposed Fix
Implement Continuous Batch Scan Mode allowing rapid, uninterrupted scanning with queuing, floating counter feedback, batch review, and batch export:

1. **Domain Model (`lib/models/batch_scan_item.dart`)**:
   - Create immutable `BatchScanItem` model (`id`, `timestamp`, `rawValue`, `format`, `parsedPayload`, `isUrl`, `isSafeUrl`, `safetyScore`, `safetyChecks`, `isAnalyzing`).
   - Implement `toScanRecord()` to bridge to `HistoryExportService` and `HistoryProvider`.

2. **State Management (`lib/providers/batch_scan_provider.dart`)**:
   - Create `BatchScanProvider extends ChangeNotifier`:
     - Toggle batch mode on/off (`isBatchMode`).
     - In-memory queue of scanned items (`items`, `count`).
     - Cooldown / debounce logic (prevents rapid duplicate scans of the same barcode within 1.5 seconds).
     - Configurable duplicate prevention toggle (`preventDuplicates`).
     - Background 6-layer URL safety engine triggering: for each scanned URL, executes `UrlSafetyService.runAllChecks(url)` asynchronously and updates the item's safety score and status without blocking the camera viewport.
     - Batch export bridge using `HistoryExportService` for CSV, JSON, TXT, and PDF.
     - Register `BatchScanProvider` in `lib/main.dart` with `MultiProvider`.

3. **Scanner Viewport Integration (`lib/screens/scanner_screen.dart`)**:
   - Add a Batch Scan Mode toggle button in the AppBar actions.
   - When batch mode is enabled:
     - Render a floating counter pill badge in the camera viewport showing scan count and a "Review" action.
     - On barcode detection, if batch mode is active:
       - Validate cooldown / duplicate rules.
       - Fire haptic and audio feedback.
       - Trigger a brief non-blocking reticle pulse (250ms).
       - Enqueue item via `batchScanProvider.addBarcode(...)`.
       - Persist to encrypted SQLite history via `HistoryProvider`.
       - Show an animated toast HUD in the viewport with the scanned item summary.
       - Do NOT navigate away or stop the camera.

4. **Batch Review Sheet (`lib/screens/widgets/batch_review_sheet.dart`)**:
   - Modal bottom sheet displaying all items in the active batch.
   - Header with total count and dismiss/continue scanning button.
   - 6-layer URL safety summary bar showing count of safe vs suspicious links.
   - Actions bar: "Export Batch" (CSV/JSON/TXT/PDF), "Clear Batch" with confirmation, and duplicate prevention toggle.
   - List of items with format badge, content, parsed payload chip, timestamp, 6-layer safety badge, delete action, and item detail dialog.

5. **Tri-Lingual Localization**:
   - Add all batch scanning keys with descriptive `@key` entries in `lib/l10n/app_en.arb`.
   - Add natural Malayalam translations in `lib/l10n/app_ml.arb`.
   - Add grammatically correct Sanskrit translations in `lib/l10n/app_sa.arb` (guaranteed zero Hindi markers).
   - Run `flutter gen-l10n`.

6. **Documentation & Roadmap**:
   - Update `docs/feature_improvements_and_roadmap.md` item 2.1.1 to `✅ Implemented`.
   - Update `docs/features.md` to document Continuous Batch Scan Mode.

7. **Test Suite**:
   - Unit tests for `BatchScanItem` (`test/models/batch_scan_item_test.dart`).
   - Unit tests for `BatchScanProvider` (`test/providers/batch_scan_provider_test.dart`).
   - Widget tests for `BatchReviewSheet` (`test/screens/widgets/batch_review_sheet_test.dart`).
   - Verify ARB key parity and Sanskrit Hindi marker gate (`test/l10n/l10n_parity_test.dart`).

## Files to Change
- `lib/models/batch_scan_item.dart` (NEW)
- `lib/providers/batch_scan_provider.dart` (NEW)
- `lib/screens/widgets/batch_review_sheet.dart` (NEW)
- `lib/screens/scanner_screen.dart` (MODIFY)
- `lib/main.dart` (MODIFY)
- `lib/l10n/app_en.arb` (MODIFY)
- `lib/l10n/app_ml.arb` (MODIFY)
- `lib/l10n/app_sa.arb` (MODIFY)
- `docs/feature_improvements_and_roadmap.md` (MODIFY)
- `docs/features.md` (MODIFY)
- `test/models/batch_scan_item_test.dart` (NEW)
- `test/providers/batch_scan_provider_test.dart` (NEW)
- `test/screens/widgets/batch_review_sheet_test.dart` (NEW)

## Verification Plan
1. `flutter gen-l10n` to regenerate localization code.
2. `flutter test` to ensure all existing and new unit, widget, and ARB parity tests pass.
3. `flutter analyze` to ensure 0 warnings and clean static analysis.
