# Phase 9 — Move the living docs to the new templates; CHANGELOG; extra docs

Plan: [plans/20261012_205200_phase9_docs_to_templates.md](../plans/20261012_205200_phase9_docs_to_templates.md)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gaps A6, A7, A8; new gap G4 and Phase 9b added with the user's yes)

Docs only — no code, build or ARB file changed.

## What changed

### `docs/security.md` — rewritten to the 18-section template (filled in full)
- Kept all current content (objectives, threats, inventory, storage, StegoQR and history
  crypto, permissions table, screen-capture rules, native code safety, testing, data retention)
  and moved it into the template sections.
- New: data sensitivity level; §8 Binary protections (obfuscation, R8 status, debuggable);
  §9 logging rules updated to `AppLogger` (the old text still said `debugPrint` + `kDebugMode`);
  §10 manifest controls with the exported-component list; **§12 OWASP M1–M10 sign-off table**
  (M1, M2, M4, M5 verified; M3, M6, M7, M8, M9, M10 **open** with the reason);
  §14 backup/import/export; §16 incident response; §17 open risks table; §18 checklist.
- Recorded honestly: no `FLAG_SECURE` although the UI claims it; no app lock; release signing
  falls back to the debug key; no `proguard-rules.pro`; the `.sreerajqr` backup uses an unsalted
  SHA-256 key, a fixed IV and CBC; plain-text exports have no warning; StegoQR format uses 10,000
  PBKDF2 iterations (kept for compatibility).

### `docs/release_process.md` — rewritten to the 15-section template (Android only)
- Kept: secrets warning, flavor matrix, versioning, signing rules, and every Play Console
  declaration item (foreground services, privacy policy, Data safety, `play_store_private/`).
- Corrected: tag format is the real **`Release_YYYYMMDD`** (the old text said `vX.Y.Z`); the
  version in the doc no longer goes stale (points to `pubspec.yaml`); Play App Signing is
  written as a must-check item, not as a fact.
- New: roles (app maintainer), branch/merge policy, §6 hardening (symbols archive, R8 open item,
  size budgets, `aapt2` debuggable/backup checks in bash and PowerShell, cleartext, asset audit,
  exported components, no ML Kit classes, 16 KB pages), §7 signing with the debug-fallback
  warning, the full §8 checklist (including the release items from Phases 6b, 8 and 8b and an
  `apksigner` check), §9 Android steps using `tool/build_release.sh`, §10–§11B "not a declared
  platform", channels, rollback/hotfix, evidence, post-release checks.

### `docs/architecture.md` — rewritten to the 22-section template
- Rebuilt from the current code. The old text named files and routes that no longer exist
  (`scan_history_item.dart`, `smart_action.dart`, `HistoryDatabaseHelper`, `/` →
  `ScannerScreen`); now: real folder layout and ownership rules, `MainShellScreen` home and the
  real route list, all 12 providers, the real model list, channel names
  (`ghost_scan`, `scan_bubble`, `clipboard`, `ambient_light`, `wifi`).
- Kept and placed: init sequence (§5), data flow diagrams (§9), barcode engine (§14a),
  persistence and schema (§14), launcher icons (§4).
- New: lifecycle table (checked against the three camera screens: `inactive` is ignored;
  `paused`/`hidden`/`detached` stop the camera), offline behavior, error handling with the typed
  exceptions, DI and test replacement, environment/build model and toolchain, UI system,
  logging, testing, operational constraints, decisions and tradeoffs, known risks (Phase 9b
  items, no app lock, ARB key prefixes, about 31 hard-coded `Color(0x…)` literals in 16 files,
  import order), related documents.

### `CHANGELOG.md` — new (project root)
- Keep a Changelog style; **Unreleased** (user-visible results of this roadmap) and one entry
  per tag: 4.1.0+34 (`Release_20261012`), 3.2.0+28 (`Release_20260921`), 3.1.2+27
  (`Release_20260919`), summarized from `change_log/` file names of each period. Linked from
  `README.md`, `docs/release_process.md` and `docs/project_structure.md`.

### The three extra docs — strict merge (user's choice)
- `docs/features.md` → `README.md`, new section **"📚 Detailed Feature Reference"** (all
  feature sections kept, headings one level down, links fixed). Its old note that the other docs
  were out of date was dropped, because step 3 fixed that.
- `docs/feature_analysis_and_roadmap.md` and `docs/feature_improvements_and_roadmap.md` →
  `docs/implementation_plan.md` §4 and §5 as dated, point-in-time **roadmap records**
  (`**Date:**` and `**Scope:**` lines; content kept; the old table of contents dropped because
  its anchors no longer matched).
- The three files were deleted. References updated in `docs/implementation_progress.md` and
  `docs/project_structure.md` (tree now lists `implementation_plan.md`,
  `implementation_progress.md` and `CHANGELOG.md`).

## Checks

- Every relative link in `README.md`, `CHANGELOG.md` and the changed `docs/` files points to a
  file that exists (scripted check: 0 broken).
- No `<...>` template placeholders left in the three rewritten docs.
- `flutter analyze` — no issues; `flutter test` — all 654 tests passed.

## Notes

- Phase 9b (added to the roadmap as gap G4): `FLAG_SECURE`, correct the UI claims about
  screenshots and history biometrics, make release builds fail without the release key, add
  `proguard-rules.pro`. The weak backup format and the plain-text export warning are listed as
  proposed Phase 9b items in `docs/security.md` §17.
- The OWASP table must have no `open` item before the next production release.
