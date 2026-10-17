# Phase 10 — Rename ARB keys to the standard prefixes (in batches)

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gap F5, plus the follow-ups noted in Phases 5, 8 and 9: History glossary terms and the untidy
import order).

## What the issue is

Engineering standard §8.6: "Prefix every key so the budget can be enforced mechanically" —
`action…`, `label…`, `title…`, `tab…`, `nav…`, `tooltip…` (short: at most 20 visible characters in
English, 22 in Malayalam and Sanskrit, language pack §5) and `desc…`, `help…`, `empty…`, `error…`,
`body…`, `aboutDetail…` (prose, no limit).

Today **1,034 of 1,236 keys** have no standard prefix (for example `wifiCopyPassword`,
`historyEmptyTitle`, `featureAirQrChip2`), so the label-length test checks only about 200 keys.
The keys are used about 1,600 times in 72 Dart files.

A dry run of a simple suffix rule (`…Title` → `title`, `…Button` → `action`, `…Desc` →
`desc`, `…Failed` → `error`, …) classifies about 560 keys; **about 470 need a decision by use**
(for example `historyDelete`, `wifiShowPassword`). Of the keys that would become short-label keys,
about **114 English, 39 Malayalam and 26 Sanskrit** values are longer than the budget. Each of
these is either a real layout problem (a button or title that is too long → shorter wording) or
prose that is used as a heading or text (→ a prose prefix).

Also found earlier:
- Some History words differ from the language-pack glossary: `tabHistory` in Malayalam is the
  transliteration "ഹിസ്റ്ററി"; other keys use ചരിത്രം / इतिहासः, while the glossary (§4.4) says
  നാൾവഴി / इतिवृत्तम्. New strings from Phases 8–9b already use the glossary.
- The Phase 5 logging script left the `app_logger.dart` import above the `dart:` imports in
  16 files.

## How each key is classified

1. **By use in the code** (looked up for every key): `AppBar` title or dialog title → `title`;
   button, menu item or dialog action label → `action`; `tooltip:` → `tooltip`;
   `NavigationDestination` / tab label → `tab` (or `nav`); field label, chip, list-row label,
   switch title, badge → `label`; subtitle, explanation, help bullet → `desc` / `help`; empty
   state → `empty`; error or failure text → `error`; snackbar, dialog body, other prose → `body`.
2. **New name:** prefix + the rest of the old name with the area kept and the role word dropped,
   for example `historyEmptyTitle` → `titleHistoryEmpty`, `wifiCopyPassword` →
   `actionWifiCopyPassword`, `featureAirQrChip2` → `labelFeatureAirQrChip2`,
   `paymentAmountInvalid` → `errorPaymentAmountInvalid`.
3. **Exceptions:** `madeWithLove` and `madeWithLoveA11y` keep their names (the guideline's
   parity test looks for `madeWithLove`); the `aboutDetail…` keys are already standard. Special
   cases that are renamed but keep their values: `appTitle` → `titleApp`, and the language
   endonyms → `labelLanguageEnglish`, `labelLanguageMalayalam`, `labelLanguageSanskrit`.
4. **Over the budget:** if a short-label value is too long in any language, write a shorter
   value in that language (English first, then ml/sa with the glossary); never solve it by
   shrinking the font or cutting text (§8.6). Every changed ml/sa value is listed as "needs
   native-reader review".
5. **Placeholders, plurals and `@` descriptions** move with the key unchanged; the `@`
   description gets a short note when a value was shortened.

## How the rename is done (per batch)

- A scratch script (kept outside the project) reads a reviewed old → new table for the batch and
  renames the key in all three ARB files (text edit, so the files' layout and line endings stay
  the same), renames every Dart use (`l10n.oldKey`, `AppLocalizations.of(context).oldKey`,
  `lookupAppLocalizations(...).oldKey`, test allow-lists), then runs `flutter gen-l10n`.
- After each batch: `dart format` check, `flutter analyze` (an unrenamed use fails to compile),
  `flutter test` (parity, label length, every screen in en/ml/sa, tooltips), Sanskrit gate.
- No user-visible change except the shortened values. No change to `app_message_text.dart`
  behavior (only the getter names it calls).
- The batch's change log lists the full old → new table and every changed value.

## Batches (by feature area; about 100–170 keys each)

| # | Area | Main key families | Also |
|---|---|---|---|
| 1 | App-wide, About, Settings, permissions, privacy, appearance, theme, feedback, language | `app…`, `settings…`, `permission…`, `privacy…`, `theme…`, `appearance…`, `overlay…`, `feedback…`, `language…`, generic `copied…`, `cancel…`, `delete…` | Sort the logger import in the 16 files |
| 2 | Scanner and inputs | `scan…`, `camera…`, `clipboard…`, `ghost…`, `batch…`, `format…`, `open…`, `pdf…`, `multi…` | |
| 3 | Result and smart payload cards | `result…`, `wifi…`, `geo…`, `calendar…`, `contact…`, `payment…`, `totp…`, `isbn…`, `product…`, `sms…`, `email…`, `phone…`, `app link…` | |
| 4 | Link safety | `safety…`, `check…`, `pattern…`, `shortener…`, `malicious…`, `virus…`, `urlhaus…`, `phish…`, `verdict…`, `api…`, `sandbox…` | |
| 5 | Page preview and Quishing Guard | `dom…`, `quishing…` | |
| 6 | StegoQR and encrypted payloads | `stego…`, `decrypt…`, `cipher…`, `encrypted…` | |
| 7 | History, export, restore, reports | `history…`, `export…`, `restore…`, `report…`, `backup…` | **History glossary alignment** (ml നാൾവഴി, sa इतिवृत्तम्, including `tabHistory`) |
| 8 | AirQR and device sync | `airQr…`, `sync…` | |
| 9 | AR CodeVision and CodeForge | `ar…`, `code…`, `codeForge…` | |
| 10 | Features, onboarding, help | `feature…`, `features…`, `onboarding…`, `help…` | Last check: no unprefixed key left |

After batch 10, the parity test gets one more check: **every key** (except the listed
exceptions) starts with a standard prefix, so new keys cannot slip through.

## Files to be changed (across all batches)

- `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb`; `lib/l10n/gen/*` (generated).
- Every Dart file that reads a renamed key (about 72 files in `lib/` and `test/`), including
  `lib/l10n/app_message_text.dart` and `test/l10n/l10n_parity_test.dart` (allow-list names).
- Batch 1 only: the 16 files with the misplaced `app_logger.dart` import.
- `test/l10n/l10n_parity_test.dart` — new "every key is prefixed" check (batch 10).
- Docs at the end: `docs/architecture.md` §21 (remove the risk), `CLAUDE.md` / `AGENTS.md` (no
  change expected — the rule is already there).
- One change log per batch in `change_log/`.

## Approval (2026-10-13)

The user chose **(a)**: this plan is approved once; batches run in order, each with its own
change log, stopping only if a batch needs a decision. Phases 1–9b stay uncommitted (user's
choice).

## Approval question (as asked)

Each batch is a mechanical rename plus the reviewed table. Please choose how to approve:
- **(a)** approve this plan once; I run batch 1, show you its rename table and the shortened
  values, then continue batch by batch, stopping only if a batch needs a decision; or
- **(b)** a short separate approval before every batch.

## Before starting (recommended)

Commit Phases 1–9b first. Phase 10 touches about 1,600 lines in 72 files; a clean commit before
it keeps those changes easy to review, and easy to undo if needed.

## Risks

- A wrong classification changes only a key name, never what the user sees; the length test and
  screen tests catch real layout problems.
- Shortened Malayalam and Sanskrit wording needs a fluent reviewer before release.
- Merge conflicts with any other open work that touches the same strings.
