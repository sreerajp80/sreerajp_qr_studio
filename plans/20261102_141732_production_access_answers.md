# Plan — Record the "Apply for access to production" answers

**Status:** completed

## Files to change

- `play_store_private/PRODUCTION_ACCESS_APPLICATION.md` — **new** (git-ignored, local only).
- `play_store_private/SUBMISSION_RECORD.md` — add one short block that points to the new file
  (git-ignored, local only).

No app code, ARB file or committed doc is changed.

## Issue

The 14-day closed test is over and the maintainer is filling in the Play Console form
"Apply for access to production" (3 steps, 8 questions). The questions and the drafted
answers exist only in the chat. If Google rejects the application, or asks again later,
there is no record of what was sent.

Also, `SUBMISSION_RECORD.md` stops at 4.1.6+40, but the closed track now holds
4.1.9+43 (release `SreerajP_QRStudio-v4.1.9_43`). This plan only notes that fact; the
missing 4.1.7–4.1.9 submission blocks need dates from the maintainer and are not filled in.

## Fix

1. Create `PRODUCTION_ACCESS_APPLICATION.md` with:
   - Date started (2 November 2026), closed track version 4.1.9+43, status
     "not submitted yet".
   - Each of the 3 steps, every question word for word, and the drafted answer under it.
   - Radio-button questions: "How easy was it to recruit testers" = Neither difficult nor
     easy (as selected on the form); "Installs in first year" = suggested 0 – 10K, final
     choice "not recorded yet".
   - Text still in `[brackets]` kept as is, with a note that it must be replaced by the
     real facts before submitting (tester count, how feedback was collected, phones and
     Android versions tested, Android vitals result).
   - A short "Rules for these answers" note: every answer must be true and match Play's
     own tester data; keep only changes that came from the test; worldwide audience, 13+.
   - A "Result" table: date submitted, result, date of result — "not recorded yet".
   - "Next steps after approval": promote 4.1.9_43 to Production, set countries to all,
     consider a staged rollout, check release notes.
2. In `SUBMISSION_RECORD.md`, add a block "Production access application — 2 November
   2026" with the closed-track version (4.1.9+43), a link to the new file, and a note that
   the 4.1.7–4.1.9 submission blocks are still missing.

## Security impact

None. Local, git-ignored notes only. No tester names, emails, passwords or keys are written.
