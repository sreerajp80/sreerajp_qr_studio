# Change log: Warn when an old, weak encryption format is unlocked

Plan: [plans/20261106_063624_legacy_crypto_format_notice.md](../plans/20261106_063624_legacy_crypto_format_notice.md)

## Why

A security review (LOW) found that the app still reads old, weak encrypted formats: StegoQR v1
(AES-CBC, no tamper check, 10,000 PBKDF2 rounds), JSON envelopes with no salt or with CBC, and
generic ciphertext keyed by plain SHA-256 of the passphrase. The reader cannot make old files
stronger, and refusing them would lock users out of their own data. So the app now tells the
user honestly when content came from such a format, and app code can no longer write the
weak StegoQR v1 format.

## What changed

### Models
- `lib/models/encrypted_payload_data.dart`, `lib/models/stego_qr_data.dart`: new
  `isLegacyFormat` field (default `false`), with a `copyWith` parameter.

### Services
- `lib/services/stego_qr_service.dart`
  - `decryptPayload` sets `isLegacyFormat: true` on success.
  - `createStegoPayload` is now `@visibleForTesting`, with a doc comment saying it writes the
    weak v1 format and must not be used by app code. Only tests call it.
- `lib/services/encrypted_payload_service.dart`
  - `_decryptStegoQr`: flags success as legacy.
  - `_decryptJsonEnvelope`: flags success as legacy when there is no salt or the mode is CBC.
    Salted AES-GCM is not flagged.
  - `_decryptGeneric`: flags success as legacy.
  - AirQR is not flagged. Decryption logic itself is unchanged.

### Screen
- `lib/screens/result_screen.dart`: new `_buildLegacyFormatNote` (amber note with a warning
  icon). It shows in the StegoQR / encrypted card after a legacy unlock, and in the manual
  decrypt sheet whenever a result is shown (that path always uses an unsalted SHA-256 key).

### Localization
- New key `bodyLegacyCryptoFormat` in `app_en.arb` (with `@` description), `app_ml.arb` and
  `app_sa.arb`. Regenerated `lib/l10n/gen/*` with `flutter gen-l10n`.
- **Needs native-reader review:**
  - ml: "പഴയ എൻക്രിപ്ഷൻ രീതി. ഇത് ദുർബലമാണ്; ഉള്ളടക്കത്തിൽ വരുത്തിയ മാറ്റങ്ങൾ കണ്ടെത്താൻ കഴിയില്ല."
  - sa: "पुरातनी गूढलेखनपद्धतिः। एषा दुर्बला अस्ति; विषये कृताः परिवर्तनाः ज्ञातुं न शक्यन्ते।"

### Tests
- `test/services/stego_qr_service_test.dart`: v1 unlock is flagged; failed unlock is not.
- `test/services/encrypted_payload_service_test.dart`: AirQR not flagged; StegoQR flagged; new
  "Legacy format flag" group (salted GCM envelope → not flagged; unsalted envelope → flagged;
  salted CBC envelope → flagged; generic ciphertext → flagged; failed unlock → not flagged).
- `test/models/stego_qr_data_test.dart`: default value and `copyWith` for the new field.
- `test/screens/result_screen_test.dart`: note hidden while locked, shown after unlocking v1.

### Docs
- `docs/security.md`: §6.1 now says correctly that StegoQR v1 uses AES-CBC (the old text said
  GCM, which was wrong), and adds a bullet on read-only, labelled legacy formats. The goals
  line and the §17 risk row were updated to match.
- `CHANGELOG.md`: one line under Unreleased → Security.

## Checks

- `dart format`: no changes needed.
- `flutter analyze`: no issues.
- `flutter test`: all tests passed.
- Sanskrit Hindi-marker gate (`tool/check_sanskrit_hindi_markers.sh`): passed.
- Not checked on a device.

## Not done (as planned)

- No StegoQR v2 writer (no writer screen exists).
- No setting to turn old formats off.
- Separate bug noted: the manual decrypt sheet passes `salt`, but `decryptRaw` ignores it.
