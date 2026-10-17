# Phase 9 — Move the living docs to the new templates; CHANGELOG; extra docs

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gaps A6, A7, A8). Docs only — no code, build or ARB change.

## What the issue is

1. **Templates not followed (`DOCS_FOLDER_GUIDELINE.md` §2, §6; engineering standard §21.1).**
   `docs/architecture.md`, `docs/security.md` and `docs/release_process.md` are this app's
   copies of the guideline templates, but they use an older, shorter section list:
   - `security.md` has 11 sections; the template has 18. Missing in full: §8 Binary Protections,
     §12 OWASP Mobile Top 10 (a **MUST sign-off under the Sensitive Data Extension**, §15.3),
     §14 Backup/Import/Export/Recovery, §16 Incident Response, §17 Open Risks, §18 Review
     Checklist. (§13 Data Retention was added in Phase 8.)
   - `release_process.md` has 7 sections; the template has 15. Missing: Branch/Merge Policy,
     Release Build Hardening (§6: obfuscation and symbols, R8, debuggable/cleartext/backup/
     exported checks, 16 KB pages), §9 Android Release Steps, Distribution Channels, Rollback
     and Hotfix, Release Evidence, Post-Release Checks, and the full §8 checklist.
   - `architecture.md` has 11 numbered sections (+4a, 6a); the template has 22. Missing:
     Lifecycle, Offline Behavior, Error Handling, Dependency Injection, Environment/Build
     Model, UI System, Logging, Operational Constraints, Decisions and Tradeoffs, Known Risks,
     Related Documents. `docs/features.md` itself says the older docs "describe an earlier,
     simpler version of the app".
2. **No `CHANGELOG.md` (§21.2, recommended; §5.3 upgrade step writes to it).** The repo has
   three release tags: `Release_20260919` (3.1.2+27), `Release_20260921` (3.2.0+28),
   `Release_20261012` (4.1.0+34).
3. **Three docs outside the recognized types (`DOCS_FOLDER_GUIDELINE.md` §4, §5, §7, §8):**
   `features.md` (living feature catalog, 371 lines), `feature_analysis_and_roadmap.md` (an
   analysis written at app v1.4.3, no date line) and `feature_improvements_and_roadmap.md`
   (roadmap, "Last updated 2026-09-14" but not in the `**Date:**` form).

### Gaps found while preparing this plan (code/build — NOT fixed here)

These came up while checking what the security and release docs must say. They need code or
build changes, so I propose a separate **Phase 9b** (see the end). Phase 9 records them
honestly in the new "Open risks" / "Known risks" sections.

- **Screenshot protection is claimed but missing.** The Features screen and the History help
  screen tell users the app "blocks screen captures (FLAG_SECURE)", but no code sets
  `FLAG_SECURE`. Under the Sensitive Data Extension it is a MUST (§15.2). The same text says
  history is protected with fingerprint/face, but biometrics are only used to reveal StegoQR
  secrets.
- **Release signing falls back to the debug key.** `android/app/build.gradle` uses
  `signingConfigs.debug` for release when `android/key.properties` is missing, so a release
  APK could be built and shipped with the debug key. The guideline example only signs with
  the release config.
- **No `proguard-rules.pro`.** `release_process.md` §6.2 says to verify it is present and
  covers the native plugins (R8 full mode is on by default).

## Files to be changed

- `docs/security.md` — rewritten to the 18-section template.
- `docs/release_process.md` — rewritten to the 15-section template (Android only).
- `docs/architecture.md` — rewritten to the 22-section template.
- `CHANGELOG.md` — new, at the project root.
- `docs/features.md`, `docs/feature_analysis_and_roadmap.md`,
  `docs/feature_improvements_and_roadmap.md` — see step 5 (your choice).
- `docs/project_structure.md`, `README.md` — links, if a doc is renamed or moved.
- `change_log/<timestamp>_phase9_docs_to_templates.md` — new.

## Plan for the fix

General rules for every rewritten doc: keep **all** true, current content (moved into the right
section, not deleted); every statement checked against the code as it is now; no `<...>`
placeholders left; standard anatomy (H1 + app name, purpose paragraph, "Read first" links,
numbered `##` sections with `---`); simple English; relative links; no personal data beyond what
`docs/PROJECT_PROFILE.md` publishes. Where the template asks for a person, use a role
("app maintainer"). Sections that do not apply say so in one line (for example iOS/desktop
steps: "Not a declared platform").

1. **`docs/security.md`** (Sensitive Data Extension in force → filled in full):
   §1 Scope · §2 Objectives · §3 Threat model · §4 Data inventory · §5 Storage model ·
   §6 Cryptography (StegoQR + history field encryption) · §7 Authentication (biometrics for
   StegoQR only; no app lock — state it as a decision) · §8 Binary protections (obfuscation,
   symbols path, R8 status) · §9 Logging policy (AppLogger rules from Phase 5) · §10 Platform
   controls (manifest flags, exported components, `allowBackup=false`, the FLAG_SECURE gap) ·
   §11 Permissions (existing table) · §12 **OWASP M1–M10 table**, each item marked verified /
   n/a / risk-accepted / **open** with evidence (FLAG_SECURE and signing items open) ·
   §13 Data retention (from Phase 8) · §14 Backup/import/export/recovery (history export
   format, `allowBackup=false`) · §15 Testing (existing table) · §16 Incident response (owner:
   app maintainer; containment: halt rollout in Play Console, hotfix via release_process §13) ·
   §17 Open risks (the Phase 9b items, legacy plain-text ambiguity, native code) · §18 Review
   checklist. Keep the "Native code safety" content (today §10a) inside §10.
2. **`docs/release_process.md`**: §1 Scope (Android; Google Play + direct APK; dev/prod) ·
   §2 Roles (app maintainer) · §3 Versioning (`pubspec.yaml`, build number +1 per upload, tag
   format **`Release_YYYYMMDD`** as used today) · §4 Branch/merge (`main`, CI checks must pass) ·
   §5 Flavor matrix (existing table) · §6 Hardening (obfuscation + `build/symbols/android-prod-
   <version>/`, R8/ProGuard status, debuggable/cleartext/backup/exported checks, 16 KB page
   check) · §7 Signing (existing + the debug-fallback risk) · §8 Release checklist (template
   items for Android + project items: language review, Sanskrit gate, the release items
   collected in Phases 6b, 8, 8b) · §9 Android steps (`tool/build_release.sh appbundle` / `apk`,
   verify signature with `apksigner`, upload, staged rollout) · §10–§11B "Not a declared
   platform" · §12 Channels · §13 Rollback/hotfix · §14 Evidence · §15 Post-release checks.
3. **`docs/architecture.md`**: the 22 template sections, filled from the current code — keeping
   today's §4a (init sequence → template §5), §6a (barcode engine), §8 (persistence → §14),
   §9 (localization), the launcher icon note (→ §16 UI System). New content: lifecycle (camera
   screens' observers), offline behavior (what works offline, what is optional online), error
   handling (global handlers, typed `StorageException`, screen states), DI (Provider +
   constructor injection for tests), environment/build model (flavors, `AppFlavorConfig`),
   logging, operational constraints (portrait, minSdk 24, 16 KB), decisions and tradeoffs
   (Provider, own zxing-cpp decoder, AES-GCM fields not SQLCipher, console-only logs, no
   Impeller opt-out), known risks (Phase 9b items, Phase 10 key rename), related documents.
4. **`CHANGELOG.md`** — "Keep a Changelog" style, user-facing only: an **Unreleased** section
   for the compliance work that users notice (history encryption upgrade, Delete all data,
   history error screen, privacy policy link, adaptive/themed icon, translation fixes), then
   one short entry per tag (4.1.0+34 on 2026-10-12, 3.2.0+28 on 2026-09-20, 3.1.2+27 on
   2026-09-19) summarized from `change_log/` files of that period. Linked from `README.md`.
5. **The three extra docs — user chose (b) strict merge on 2026-10-12:**
   - **(a) Recommended:** keep `features.md` as a living doc (it is the most current
     description of the app and is meant to be shared) — give it the standard anatomy and
     remove its "older docs are out of date" note once step 3 is done. Turn the two roadmap
     files into point-in-time records: add `**Date:**` / `**Scope:**` lines and a note that
     they are not kept current; no content change.
   - (b) Strict merge: move the feature catalog into `README.md`/`architecture.md` and the two
     roadmaps into `implementation_plan.md`, then delete the three files.
6. **Links** — update `docs/project_structure.md` and `README.md` if anything moves.
7. **Verify** — every relative link in the changed docs points to a file that exists; no
   `<...>` left; privacy check on the plan/change log; `flutter analyze` and `flutter test`
   still pass (no code touched).

## New roadmap phase (added with the user's yes on 2026-10-12)

**Phase 9b — Sensitive-data and release-build controls** (its own plan and approval):
`FLAG_SECURE` on the app window (or on the sensitive screens, your choice), correct the
user-visible claims about history biometrics, make release builds **fail** without
`android/key.properties` instead of using the debug key, and add `proguard-rules.pro` with any
keep rules the native plugins need — then a release build check.
