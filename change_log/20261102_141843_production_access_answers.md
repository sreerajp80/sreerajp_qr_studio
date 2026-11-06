# Change log — Record the "Apply for access to production" answers

Implements plan: `plans/20261102_141732_production_access_answers.md`

## What changed

Only files in `play_store_private/` were changed. That folder is git-ignored and local only.
No app code, ARB, or committed doc was changed.

- **New:** `play_store_private/PRODUCTION_ACCESS_APPLICATION.md`
  - All 8 questions of the Play Console form (3 steps), word for word, each with its drafted
    answer (each at most 300 characters).
  - Radio questions: recruiting ease = Neither difficult nor easy (as selected); installs in
    first year = suggested 0 – 10K, final choice not recorded yet.
  - Parts the maintainer must still fill in are kept in `[brackets]` (tester count, how
    feedback was collected, phones and Android versions tested, Android vitals result).
  - Rules for the answers (true, worldwide, 13+, only changes that came from the test).
  - A Result table (not recorded yet) and next steps after approval (promote 4.1.9_43,
    all countries, staged rollout, first-release notes).
- **Updated:** `play_store_private/SUBMISSION_RECORD.md`
  - New block "Production access application — 2 November 2026" with the closed-track
    release (4.1.9+43) and a pointer to the new file.
  - Note that the Submission blocks for 4.1.7, 4.1.8 and 4.1.9 are still not recorded.

## Not done

- The application is not submitted yet; the bracketed facts must be filled in first.
- The 4.1.7–4.1.9 Submission blocks need dates and results from the maintainer.
