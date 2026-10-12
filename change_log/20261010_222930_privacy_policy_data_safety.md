# Change log: privacy policy and Play Data safety answers

**Plan:** [plans/20261010_221546_privacy_policy_data_safety.md](../plans/20261010_221546_privacy_policy_data_safety.md)

## What changed

| File | Change |
| --- | --- |
| `PRIVACY_POLICY.md` (new) | Public privacy policy in simple English. Covers: no account, no analytics/ads/tracking; each permission and why; data kept on the phone (encrypted history, settings, API keys in secure storage, clipboard check); how to delete data; the optional features that send a scanned link off the phone (link safety providers, active online checks, page preview with rdap.org, smart actions), all off by default or needing a tap; children; security; contact. |
| `.gitignore` | Added `play_store_private/` so local Play Console notes are never committed. |
| `play_store_private/data_safety_answers.md` (new, not committed) | Answers for the Play Console Data safety form. Kept local on purpose; its content is not repeated here. |
| `docs/release_process.md` | Two new checklist items under "Google Play Declarations": privacy policy URL entered, Data safety form filled (answers kept locally). |

## Notes

- No app code, ARB files, or manifest were changed.
- While writing the policy, the wording about HTTPS was made exact: requests
  to the safety services and rdap.org use HTTPS, but a scanned website is
  contacted using the address in the code (which may be `http`).
- `git check-ignore` confirms the private answers file is ignored.

## Still to do (outside this plan)

- Host `PRIVACY_POLICY.md` at a public URL and enter it in Play Console.
- Add an in-app "Privacy policy" link (About screen), which Google's User Data
  policy expects. Needs its own plan once the URL is known.
