# Phase 1 — Add docs/PROJECT_PROFILE.md

Plan: [plans/20261012_192229_phase1_project_profile.md](../plans/20261012_192229_phase1_project_profile.md)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gap A1)

## What changed

- **New `docs/PROJECT_PROFILE.md`**, from `docs/guidelines/PROJECT_PROFILE_TEMPLATE.md`:
  - Identity: name, publisher, app id `in.sreerajp.qr_studio`, Dart package, the public support
    contact already shown on the About screen, the GitHub repository as website, the GitHub
    link to `PRIVACY_POLICY.md` as the privacy policy URL, copyright, MIT license.
  - Profiles: Core Baseline, Production App Extension, Sensitive Data Extension.
  - Platforms: Android only (`minSdk 24`, `targetSdk 36`, `compileSdk 37`); channels Google
    Play and direct split APKs; flavors dev + prod.
  - Languages: `en` (template), `ml`, `sa`, with the Sanskrit/Malayalam language pack; `sa`
    needs the framework fallback; Sanskrit ships in the app only (not a Play listing language).
  - About: current `details` rows; signature badge on.
  - Optional values: Provider, Tier 1, default size budget.
- **`docs/project_structure.md`**: added `PROJECT_PROFILE.md` to the `docs/` tree.

## Follow-ups noted

- The About screen has no `privacyPolicy` row yet; it is needed before the next store release
  (`platform_store_readiness.md` §1). To be planned in a later phase.

No code changed, so no analyze or test run was needed.
