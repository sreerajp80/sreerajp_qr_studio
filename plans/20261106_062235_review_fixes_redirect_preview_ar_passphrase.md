# Fix four review findings: redirects, page preview limits, AR open warning, passphrase length

**Status:** completed

## Files to change

- `lib/services/url_safety_service.dart` — redirect-chain check and shortener network check.
- `lib/services/dom_sandbox_service.dart` — redirect detection and capped, timed body read.
- `lib/screens/widgets/ar_action_sheet.dart` — confirm before opening a link that is not "safe".
- `lib/screens/widgets/export_import_dialog.dart` — minimum passphrase length for a new backup.
- `lib/screens/air_qr_transmitter_screen.dart` — minimum passphrase length when sending.
- `lib/core/constants/app_constants.dart` — new `minBackupPassphraseLength = 8`.
- `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` (+ `flutter gen-l10n`) — one new key
  `errorPassphraseTooShort` with a `{min}` placeholder.
- Tests: `test/services/url_safety_service_test.dart`, `test/services/dom_sandbox_service_test.dart`
  (add or extend).

## Issue 2 (MEDIUM): redirect checks never see a 3xx on a real phone

**Problem.** `_httpClient.head(...)` and `_httpClient.send(...)` use `package:http`, which
follows redirects by itself (`followRedirects` is `true` by default on a `Request`). So the
real client hands back the final page (200), never the 3xx. Only `MockClient` returns the
3xx, so the tests pass while the phone does not.

**Fix.**
- `checkUrlRedirects` (url_safety_service.dart ~234): build `http.Request('HEAD', uri)` with
  `followRedirects = false`, call `_httpClient.send(...)`, drain the body, then read
  `statusCode` and the `location` header. Resolve the next URL with
  `Uri.parse(currentUrl).resolve(location)` (today's code drops the port and breaks relative
  paths like `../x`).
- Shortener network check (~422): same one-hop `HEAD` with `followRedirects = false`;
  replace `response.isRedirect` with a 3xx status test, and resolve `location` the same way.
- DOM sandbox (dom_sandbox_service.dart ~89): keep following redirects here, because the
  preview should show the final page. To detect a redirect, compare the final URL
  (`BaseResponseWithUrl.url`, which `IOClient` gives in `package:http` 1.6) with the
  request URL. If they differ, set `hasOpenRedirect` and `redirectTarget` to the final URL.
  Keep the existing 3xx check for clients that do return a 3xx (MockClient).

## Issue 3 (MEDIUM): page preview reads the whole body with no size cap or timeout

**Problem.** `response.stream.bytesToString()` reads everything into memory first, then cuts
to 500 KB. The 5-second timeout covers only the headers. A huge or very slow page can use up
memory or hang the preview.

**Fix.** Add a private helper in `DomSandboxService` that reads the byte stream:
- stops (and cancels the stream) as soon as 512,000 bytes are read;
- has a per-chunk stall timeout (5 s) — a stall throws, so the fetch counts as failed;
- has an overall deadline (10 s) — when reached it stops and uses what was read so far.
Decode with `utf8.decode(..., allowMalformed: true)`. Small change: today the charset is
taken from the `Content-Type` header (default Latin-1); after this it is always UTF-8 with
bad bytes replaced. Almost all web pages are UTF-8, and the text is only a preview.

## Issue 4 (LOW): AR "Open" skips the warning

**Problem.** `ar_action_sheet.dart:121` opens the link for any verdict, including `warning`
and `unknown` (check not finished).

**Fix.** If the status is not `safe`, show a confirm dialog first, using the strings the
result screen already has: `titleWarningDialog` / `bodyWarningDialog` for `warning`,
`titleCautionDialog` / `bodyCautionDialog` for `unknown`, plus `actionCancel` and
`actionOpenAnyway`. For `warning`, "Open Anyway" is a plain red text button so Cancel is the
easy choice (same as the result screen). Also open with `LaunchMode.externalApplication`, as
the result screen does. No new strings.

## Issue 5 (LOW): one-character backup passphrases

**Problem.** Only a non-empty check exists. Backups and AirQR sync packages can hold Wi-Fi
passwords and TOTP seeds.

**Fix.** Minimum length 8 characters (`AppConstants.minBackupPassphraseLength`) when
**creating**: encrypted backup export and AirQR transmit. The **restore / receive** paths keep
only the non-empty check, so old backups made with a short passphrase can still be opened.
New ARB key `errorPassphraseTooShort` ("Use a password of at least {min} characters.") in
en, ml and sa, with an `@` description. The check is in the screens only; the services do not
enforce it.

## Tests

- url_safety: assert that the redirect check and the shortener check send requests with
  `followRedirects == false` (MockClient sees the `BaseRequest`), and that a relative
  `location` resolves correctly.
- dom_sandbox: a mock body larger than 512,000 bytes is cut at the cap; a stream that stalls
  makes the fetch fail instead of hanging.
- Then `flutter analyze`, `flutter test`, `dart format .`.

## Security impact

Network code changes only make the online checks stricter (no new hosts, no new data sent,
HTTPS rules unchanged). The passphrase rule makes new backups harder to brute-force.

## Translations to flag for native-reader review

The one new Malayalam and Sanskrit string.
