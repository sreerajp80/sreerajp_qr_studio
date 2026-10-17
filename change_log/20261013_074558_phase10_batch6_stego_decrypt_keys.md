# Phase 10 batch 6 — StegoQR and decrypt keys

Implements batch 6 (StegoQR, decrypt, cipher and encrypted-JSON keys) of `plans/20261013_071846_phase10_arb_key_prefixes.md`.

## What changed

- Renamed the `stego*`, `decrypt*`, `cipher*`, `jsonEnvelope*` and `decrypted*` ARB keys to
  the standard prefixes in all three ARB files and in the Dart code. Regenerated
  `lib/l10n/gen/`.
- Shortened titles and labels that were over the label budget (table below).
- The rename tool now renames only `l10n.` and `AppLocalizations.of(context).` uses, so
  enum constants and model fields that share a key's name are never touched.

## Checks

`flutter analyze` clean, all 687 tests pass, `dart format` applied, Sanskrit Hindi-marker
gate passes.

## Native-reader review

Please check: `titleStegoDetected` (ml "StegoQR കണ്ടെത്തി", sa "StegoQR-विषयः प्राप्तः"),
`titleStegoDialogBiometric` (ml "ബയോമെട്രിക് അൺലോക്ക്", sa "जैविक-उद्घाटनम्"), and the
transliterations `labelDecryptSalt` (ml "സോൾട്ട്", sa "साल्ट्") and `labelDecryptIv`
(ml "നോൺസ്", sa "नोन्स्").

## Renamed keys (34)

| Old key | New key |
|---|---|
| `stegoUnlockedMessage` | `bodyStegoUnlocked` |
| `stegoLockedMessage` | `bodyStegoLocked` |
| `stegoBiometricUnlock` | `actionStegoBiometricUnlock` |
| `stegoPassphrase` | `labelStegoPassphrase` |
| `stegoSecretPayload` | `labelStegoSecretPayload` |
| `stegoCopySecret` | `actionStegoCopySecret` |
| `stegoShareSecret` | `actionStegoShareSecret` |
| `stegoSecretCopied` | `bodyStegoSecretCopied` |
| `stegoDialogTitleBiometric` | `titleStegoDialogBiometric` |
| `stegoDialogTitlePassphrase` | `titleStegoDialogPassphrase` |
| `stegoDialogMessageBiometric` | `bodyStegoDialogBiometric` |
| `stegoDialogMessagePassphrase` | `bodyStegoDialogPassphrase` |
| `stegoUnlockButton` | `actionStegoUnlock` |
| `stegoWrongPassphrase` | `errorStegoWrongPassphrase` |
| `stegoPassphraseEmpty` | `errorStegoPassphraseEmpty` |
| `stegoBiometricReason` | `bodyStegoBiometricReason` |
| `stegoBiometricCanceled` | `errorStegoBiometricCanceled` |
| `decryptPayloadAction` | `actionDecryptPayload` |
| `decryptPayloadTitle` | `titleDecryptPayload` |
| `decryptPayloadDescription` | `descDecryptPayload` |
| `cipherModeLabel` | `labelCipherMode` |
| `cipherModeAuto` | `labelCipherModeAuto` |
| `cipherModeAesGcm` | `labelCipherModeAesGcm` |
| `cipherModeAesCbc` | `labelCipherModeAesCbc` |
| `jsonEnvelopeDetectedTitle` | `titleJsonEnvelopeDetected` |
| `jsonEnvelopeDetectedSubtitle` | `bodyJsonEnvelopeDetected` |
| `decryptedContentLabel` | `labelDecryptedContent` |
| `jsonEnvelopeUnlockedTitle` | `titleJsonEnvelopeUnlocked` |
| `stegoUnlockedTitle` | `titleStegoUnlocked` |
| `stegoDetectedTitle` | `titleStegoDetected` |
| `decryptShowAdvanced` | `actionDecryptShowAdvanced` |
| `decryptHideAdvanced` | `actionDecryptHideAdvanced` |
| `decryptSaltLabel` | `labelDecryptSalt` |
| `decryptIvLabel` | `labelDecryptIv` |

## Changed values

| Key | Language | Before | After |
|---|---|---|---|
| `titleDecryptPayload` | en | Decrypt Scanned Content | Decrypt content |
| `labelCipherModeAesGcm` | en | AES-256-GCM (PBKDF2 SHA-256) | AES-256-GCM (PBKDF2) |
| `titleJsonEnvelopeDetected` | en | Encrypted JSON Container | Encrypted JSON |
| `titleJsonEnvelopeUnlocked` | en | JSON payload unlocked | JSON unlocked |
| `titleStegoUnlocked` | en | StegoQR payload unlocked | StegoQR unlocked |
| `titleStegoDetected` | en | StegoQR encrypted payload found | StegoQR found |
| `labelDecryptSalt` | en | Salt (Base64, optional) | Salt (Base64) |
| `labelDecryptIv` | en | IV / Nonce (Base64, optional) | IV / Nonce (Base64) |
| `labelCipherModeAuto` | en | Auto-detect / Standard | Auto / Standard |
| `labelCipherModeAesGcm` | en | AES-256-GCM (PBKDF2 SHA-256) | AES-256-GCM (PBKDF2) |
| `labelCipherModeAesGcm` | ml | AES-256-GCM (PBKDF2 SHA-256) | AES-256-GCM (PBKDF2) |
| `labelCipherModeAesGcm` | sa | AES-256-GCM (PBKDF2 SHA-256) | AES-256-GCM (PBKDF2) |
| `labelDecryptSalt` | en | Salt (Base64, optional) | Salt (Base64) |
| `labelDecryptSalt` | ml | Salt (Base64, ഐച്ഛികം) | സോൾട്ട് (Base64) |
| `labelDecryptSalt` | sa | Salt (Base64, ऐच्छिकम्) | साल्ट् (Base64) |
| `labelDecryptIv` | en | IV / Nonce (Base64, optional) | IV / Nonce (Base64) |
| `labelDecryptIv` | ml | IV / Nonce (Base64, ഐച്ഛികം) | IV / നോൺസ് (Base64) |
| `labelDecryptIv` | sa | IV / Nonce (Base64, ऐच्छिकम्) | IV / नोन्स् (Base64) |
| `titleStegoDetected` | en | StegoQR encrypted payload found | StegoQR found |
| `titleStegoDetected` | ml | എൻക്രിപ്റ്റ് ചെയ്ത StegoQR ഉള്ളടക്കം കണ്ടെത്തി | StegoQR കണ്ടെത്തി |
| `titleStegoDetected` | sa | गूढः StegoQR-विषयः प्राप्तः | StegoQR-विषयः प्राप्तः |
| `titleStegoDialogBiometric` | en | Biometric + Passphrase | Biometric unlock |
| `titleStegoDialogBiometric` | ml | ബയോമെട്രിക് + രഹസ്യവാക്ക് | ബയോമെട്രിക് അൺലോക്ക് |
| `titleStegoDialogBiometric` | sa | जैविकम् + कूटवाक्यम् | जैविक-उद्घाटनम् |
