# Fix stale ML Kit reference in the roadmap doc

Implements plan: `plans/20261010_194536_fix_stale_mlkit_doc_reference.md`

## What changed

`docs/feature_improvements_and_roadmap.md`, row 2.1.2 ("Distance-Enhanced Scanning Pipeline"):

- Status column: "camera autoZoom & Viewport controls" is now
  "camera zoom & Viewport controls".
- Description column: "leverages MLKit autoZoom" is now
  "uses the app's own camera zoom control (`camera` plugin)".

## Why

Google ML Kit was removed from the app. Barcodes are decoded by the app's own zxing-cpp
engine, and camera zoom is set by the app through the `camera` plugin. The old text said
the feature still used ML Kit.

## Checks

- Searched `docs/` for `MLKit`, `ML Kit` and `mlkit`. The only matches left are notes that
  say ML Kit was removed or is blocked, plus an unrelated note about ML Kit translation models
  in the same roadmap file.
- Docs-only change. No code changed, so `flutter analyze` and `flutter test` were not run.

## Not done (out of scope)

- The "auto zoom" setting (`CameraSettingsProvider.autoZoomEnabled`) is not read by the
  camera code, so it has no effect. This needs its own plan.
