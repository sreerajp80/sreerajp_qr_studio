# Change log: redirects, page preview limits, AR open warning, passphrase length

Implements plan: `plans/20261106_062235_review_fixes_redirect_preview_ar_passphrase.md`

## What changed

### Redirect checks now see 3xx replies on a real device (MEDIUM)
- `lib/services/url_safety_service.dart`
  - New private helper `_headNoRedirect(uri)`: sends one `HEAD` with
    `followRedirects = false` (5 s timeout for the headers and 5 s for draining the body).
  - `checkUrlRedirects` uses it, and finds the next hop with `Uri.resolve(location)`. This also
    fixes relative locations such as `../b` and keeps the port number.
  - The `checkUrlShorteners` network probe uses it too. It checks the status code for a 3xx
    instead of `isRedirect`, and resolves `location` the same way.
- `lib/services/dom_sandbox_service.dart`
  - Still follows redirects, so the preview shows the final page. If the response reports a
    final URL (`BaseResponseWithUrl`, given by the real `IOClient`) on a **different host**,
    `hasOpenRedirect` is set and `redirectTarget` is that URL.
  - Different from the plan: only a move to another host counts. The plan said "if they
    differ", but then every `http → https` upgrade or same-site path change would show as an
    open redirect.
  - The old 3xx check is kept for clients that hand back the 3xx itself.

### Page preview body is capped and timed (MEDIUM)
- `lib/services/dom_sandbox_service.dart`: new `readCappedBody(...)`. It reads at most
  512,000 bytes and cancels the stream at the cap.
  - If no chunk arrives within 5 s, it throws, and the fetch counts as failed.
  - After 10 s in total, it stops and keeps what it has read.
  - It decodes as UTF-8 and replaces bad bytes. Before, it used the charset from
    `Content-Type`, with Latin-1 as the default.

### AR "Open" asks first unless the verdict is safe (LOW)
- `lib/screens/widgets/ar_action_sheet.dart`
  - "Warning": shows the result screen's warning dialog. "Open Anyway" is a plain red text
    button, so Cancel is the easy choice.
  - "Not checked yet": shows the caution dialog.
  - Reuses existing strings. Links now open with `LaunchMode.externalApplication`, as on the
    result screen.

### Minimum passphrase length for new backups (LOW)
- `lib/core/constants/app_constants.dart`: `minBackupPassphraseLength = 8`.
- `lib/screens/widgets/export_import_dialog.dart` (encrypted backup) and
  `lib/screens/air_qr_transmitter_screen.dart` (AirQR send): refuse shorter passphrases.
- Restore and receive paths are unchanged (non-empty only), so older backups still open.
- New ARB key `errorPassphraseTooShort` (`{min}`, int) in `app_en.arb` (with `@` entry),
  `app_ml.arb`, `app_sa.arb`. Ran `flutter gen-l10n`.

### Tests
- `test/services/url_safety_service_test.dart`: the redirect check sends
  `followRedirects == false`; a relative location resolves and keeps the port; the shortener
  probe flags a cross-host 301 and does not follow it.
- `test/services/dom_sandbox_service_test.dart`: byte cap; a stalled stream throws; the total
  time limit keeps partial text; a cut multi-byte character decodes; a followed cross-host
  redirect is flagged; a same-host redirect is not.

## Checks
- `dart format`: clean. `flutter analyze`: no issues. `flutter test`: all 918 tests passed.
- Not tested on a device.

## Known limits
- The passphrase rule is checked in the screens only. The services do not enforce it.

## Native-reader review needed
- `app_ml.arb` `errorPassphraseTooShort`: "കുറഞ്ഞത് {min} അക്ഷരങ്ങളുള്ള രഹസ്യവാക്ക് ഉപയോഗിക്കുക."
- `app_sa.arb` `errorPassphraseTooShort`: "न्यूनातिन्यूनं {min} अक्षरात्मकं कूटवाक्यं प्रयुङ्क्ष्व।"
