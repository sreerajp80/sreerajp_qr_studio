# Phase 1 — Add docs/PROJECT_PROFILE.md

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gap A1).

## What the issue is

Every app must have `docs/PROJECT_PROFILE.md`, filled in from
`docs/guidelines/PROJECT_PROFILE_TEMPLATE.md` (engineering standard §1.2.1,
`DOCS_FOLDER_GUIDELINE.md` §6). It records the platforms, stores, languages, identity and About
options in one place. Every platform-, store- and language-specific rule applies only to what
this file declares. The project does not have it.

## Files to be changed

- `docs/PROJECT_PROFILE.md` — new.
- `docs/project_structure.md` — add the new file to the `docs/` tree.
- `change_log/<timestamp>_phase1_project_profile.md` — new change log.

No code changes. No change to `CLAUDE.md` / `AGENTS.md` yet (that is Phase 2, where the docs
table will link the profile).

## Plan for the fix

Create `docs/PROJECT_PROFILE.md` with the template's sections, filled from the code and the
user's answers:

1. **Identity**
   - App display name: SreerajP QR Studio
   - Short description: from `pubspec.yaml` `description`
   - Organization / publisher: Sreeraj P
   - Reverse-DNS app id: `in.sreerajp.qr_studio` (dev flavor adds `.dev`)
   - Dart package name: `sreerajp_qr_studio`
   - Public support contact: **to confirm** (see question below)
   - Website: the public GitHub repository, or `none` — **to confirm**
   - Privacy policy URL: **to confirm** (the repo has `PRIVACY_POLICY.md`; a public URL is needed
     before a store release)
   - Copyright line: `© 2026 Sreeraj P` (matches `LICENSE`)
   - License of the app's own code: MIT
2. **Profiles**: Core Baseline, Production App Extension, Sensitive Data Extension (all ticked).
3. **Platforms**: Android only — `minSdk 24` (reason: wide device reach; the camera and FFI
   decoder work there), `targetSdk 36`, `compileSdk 37`; channels Google Play (`.aab`) and
   direct download (split APKs). iOS, Windows, macOS, Linux, Web: no. Build flavors: dev + prod.
4. **Languages**: `en` (template), `ml`, `sa`; language pack
   `language_packs/sanskrit_malayalam.md` for `ml` and `sa`; picker required, endonyms
   `English`, `മലയാളം`, `संस्कृतम्`; framework fallback needed for `sa`; store-listing languages:
   Google Play `en-US` and `ml-IN` (Sanskrit is not a Play listing language, so it ships in the
   app only); native-reader review: a fluent Malayalam reader and a fluent Sanskrit reader before
   each release.
5. **About screen**: `details` rows as in `assets/config/app_config.json` today (`author`,
   `email`, `license`, `aiUsed`, `ideUsed`). Signature badge **on**, text as in the ARB files
   (`madeWithLove`, `madeWithLoveA11y`). Note: a `privacyPolicy` row is needed before release
   (`platform_store_readiness.md` §1) — tracked for a later phase.
6. **Optional values**: size budget default; Provider (`ChangeNotifier`); Tier 1 layer-first;
   release owner: app maintainer.

The file uses the standard anatomy (`DOCS_FOLDER_GUIDELINE.md` §4) and contains only public
information.

## User decisions (2026-10-12)

- **Public support contact**: the email already shown on the About screen
  (`assets/config/app_config.json` `details.email`).
- **Website**: the public GitHub repository URL (as in `README.md`).
- **Privacy policy URL**: the GitHub link to `PRIVACY_POLICY.md` in the public repository
  (`main` branch).
