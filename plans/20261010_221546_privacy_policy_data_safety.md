# Add a privacy policy and the Google Play Data safety answers

**Status:** completed

## Issue

Before the app can go on Google Play, two things are needed in Play Console:

1. **A privacy policy link.** Google requires one because the app asks for
   camera, location, and screen capture permissions. The link must point to a
   public web page.
2. **The Data safety form.** Google asks what user data the app collects or
   shares, why, and whether it is encrypted and can be deleted.

The project has neither today. The answers must match what the code really
does, or Google may reject the app.

## What the code does with data (checked in this session)

| Area | What happens | Leaves the phone? |
| --- | --- | --- |
| Camera (`CAMERA`) | Frames are decoded on the phone by the app's own engine (`native/`). No images are saved or sent. | No |
| Screen capture (GhostScan, Scan bubble) | One frame, only after the user agrees in the Android dialog. Decoded on the phone, then thrown away. | No |
| Location (`lib/services/location_service.dart`) | Read once, only when the user asks CodeForge to make a location QR code. Goes into the code the user makes. | No |
| Scan history (`sqflite`) | Stored encrypted on the phone. Key kept in `flutter_secure_storage`. `allowBackup="false"`. User can delete it. | No |
| API keys (Safe Browsing, VirusTotal) | Stored in `flutter_secure_storage`, only if the user adds them. | Only to that provider |
| Link safety lookups (`lib/services/url_safety_service.dart`) | The scanned link is sent to Google Safe Browsing, VirusTotal, URLhaus, PhishTank, or OpenPhish **only if the user turns that provider on**. All off by default. | Yes, opt-in |
| "Active online checks" (redirects, shortener probe) | Contacts the scanned server. Off by default. | Yes, opt-in |
| Sandboxed page preview (`lib/services/dom_sandbox_service.dart`) | Fetches the page and asks `rdap.org` for the domain age, only when the user taps preview. | Yes, user action |
| Smart actions (`payload_action_service.dart`) | Opens Maps, Calendar, Open Food Facts, Google Books, etc. in the browser on a user tap. The app itself does not send data. | Via the browser |
| Analytics, ads, crash reports, accounts | None. | No |

## Files to change

| File | Change |
| --- | --- |
| `PRIVACY_POLICY.md` (new, repo root) | The privacy policy text, in simple English. Committed, because it must be public. |
| `.gitignore` | Add one line: `play_store_private/`, so the folder below is never committed. |
| `play_store_private/data_safety_answers.md` (new, **not committed**) | The answer to each question in the Play Console Data safety form, ready to copy. Kept local only. |
| `docs/release_process.md` | Add two checklist items under "Google Play Declarations": privacy policy URL entered, Data safety form filled (answers kept locally, not in git). No answers in this file. |
| `change_log/<timestamp>_privacy_policy_data_safety.md` (new) | The change log. It mentions the private file only by name, with no answers. |

No app code changes. No changes to `lib/`, ARB files, or the manifest.

Why the repo root for the policy: it is a public page, not an internal doc,
and GitHub shows root `.md` files nicely.

Why the Data safety answers are not committed: they are only needed to fill a
form in Play Console. They are internal release notes, so the user wants them
kept out of the public repository. For the same reason, this plan does not
list the answers either.

## Plan for the fix

### 1. `PRIVACY_POLICY.md`

Sections:

1. Who we are: app name, developer name, contact email (the same public email
   already shown on the app's About screen). Effective date: 10 October 2026.
2. Summary: no account, no analytics, no ads, no tracking; most work happens
   on the phone.
3. Permissions and why each is used: camera, location, screen capture /
   foreground services, "display over other apps" (Scan bubble), notifications,
   biometrics, Wi-Fi/network state, start at boot (to bring back the Scan bubble
   if the user left it on), internet.
4. Data stored on the phone: encrypted scan history, settings, saved API keys.
   How to delete it (clear history in the app, or clear app data / uninstall).
5. Data sent off the phone, and only when the user chooses: each link safety
   provider (with a link to its privacy policy), active online checks, page
   preview + RDAP, and links opened in the browser.
6. Children: the app is not aimed at children and collects nothing from them.
7. Security: HTTPS for all network calls, encrypted history, no backup.
8. Changes to this policy, and how to contact the developer.

### 2. Data safety answers in `play_store_private/data_safety_answers.md`

1. Add `play_store_private/` to `.gitignore` first, before the file is made.
2. Write the file as question → answer, following the order of the Play
   Console form, based on the data table above.
3. Run `git check-ignore play_store_private/data_safety_answers.md` and
   `git status` to confirm git does not see the file.

The answers themselves are agreed in chat, not written in this plan.

### 3. Where to host the policy URL

Play Console needs a public web link. Options (the user picks; no change to
code needed for any):

- The GitHub page for `PRIVACY_POLICY.md`, if the repository is public.
- A page on the developer's own website.
- GitHub Pages or a free site, if the repository is private.

### 4. Not in this plan (possible follow-up)

Google's User Data policy also asks for the privacy policy to be reachable
**inside the app**. Adding a "Privacy policy" link on the About screen needs a
new field in `assets/config/app_config.json`, new ARB keys in all three
languages, and a small screen change. That is a separate plan once the final
URL is known.

## Checks after the change

- `flutter analyze` and `flutter test` still pass (no code touched).
- The new committed files use relative links only and contain no local system
  details or secrets.
- `git status` does not list anything under `play_store_private/`.
