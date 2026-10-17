# Phase 8b — Android adaptive launcher icon, monochrome layer, dev badge (option B)

Plan: [plans/20261012_204410_phase8b_adaptive_icons.md](../plans/20261012_204410_phase8b_adaptive_icons.md)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gap G2)

## What changed

- **New `tool/generate_launcher_icons.py`** (Python 3 + Pillow, build-time only). From
  `assets/app_icon.png` it:
  - turns the black pixels outside the rounded corners white;
  - finds the emblem by its coloured pixels (the grey shadow is not used for the size) and
    centres it on a white 108 dp canvas, scaled to 64 dp so it sits inside the 66 dp safe
    circle with a small margin → `ic_launcher_foreground.png`;
  - makes `ic_launcher_monochrome.png`: solid where the emblem is coloured (circle, ticks),
    clear where it is white (QR modules, ring), with soft edges;
  - draws a red rounded "DEV" label (letters made of plain shapes, no font file) on a copy of the
    foreground and on the legacy square icon for the dev flavor.
- **Generated files** (5 densities each: 108/162/216/324/432 px, legacy 48–192 px):
  - `android/app/src/main/res/mipmap-*/ic_launcher_foreground.png`
  - `android/app/src/main/res/mipmap-*/ic_launcher_monochrome.png`
  - `android/app/src/dev/res/mipmap-*/ic_launcher_foreground.png` (DEV badge)
  - `android/app/src/dev/res/mipmap-*/ic_launcher.png` (DEV badge, Android 7)
- **New `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml`** — adaptive icon with
  background `@color/ic_launcher_background`, foreground and monochrome layers.
- **New `android/app/src/main/res/values/ic_launcher_background.xml`** — `#FFFFFF`.
- `android/app/src/main/res/mipmap-*/ic_launcher.png` (prod legacy) and the manifest are
  unchanged.
- Docs: `docs/architecture.md` §4 "Launcher icons" (source, layers, how to make them again);
  `docs/project_structure.md` lists the `tool/` scripts.

## Checks

- Preview of the layers in circle and squircle masks, the themed (monochrome) look, and both
  dev icons was made and shown to the user before building.
- `flutter build apk --flavor dev --debug` and `--flavor prod --debug` — both built; not
  installed on any device.
- `aapt2 dump resources` on both APKs: `mipmap/ic_launcher` has the `anydpi-v26` XML plus the
  five PNG densities; `ic_launcher_foreground`, `ic_launcher_monochrome` and
  `color/ic_launcher_background` are present. The dev APK's foreground and legacy icon differ
  from prod (the badge); the adaptive XML is the same in both.
- `flutter analyze` — no issues; `flutter test` — all 654 tests passed (no Dart change).
- Gradle daemon stopped; no `GradleDaemon` or `KotlinCompileDaemon` process left.

## Notes

- The monochrome edges come from a colour threshold; they looked clean in the preview, but check
  them once on an Android 13+ phone with themed icons on (release item; installing needs the
  user's approval).
- The 512 × 512 Play Store listing icon is not part of this change.
