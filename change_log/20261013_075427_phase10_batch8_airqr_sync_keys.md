# Phase 10 batch 8 — AirQR and sync keys

Implements batch 8 (AirQR and device sync keys) of `plans/20261013_071846_phase10_arb_key_prefixes.md`.

## What changed

- Renamed the `airQr*` ARB keys (transmitter, receiver, stream status, encrypted transfer,
  device sync) to the standard prefixes in all three ARB files and in the Dart code.
  Regenerated `lib/l10n/gen/`.
- Deleted the unused key `airQrSyncBeamButton`.
- Shortened titles, buttons and field labels that were over the label budget, in all three
  languages (see "Changed values").
- History glossary: the sa sync switches used अवलोकनवृत्तम् for "history"; they now use
  इतिवृत्तम्. (`bodyAirQrSyncPackageSummary` keeps अवलोकनवृत्तानि, because there it means
  "scan records", not "history".)

## Checks

`flutter analyze` clean, all 687 tests pass, `dart format` applied, Sanskrit Hindi-marker
gate passes.

## Native-reader review

Please check the new ml/sa texts in the "Changed values" table, especially
`labelAirQrSyncEnterPassphrase` (ml "സിങ്ക് പാസ്‌ഫ്രെയ്സ്", sa "समन्वय-गुप्तपदम्") and
`labelAirQrPayload` (ml "അയയ്ക്കേണ്ട വിവരങ്ങൾ").

## Renamed keys (47)

| Old key | New key |
|---|---|
| `airQrTransmitterTitle` | `titleAirQrTransmitter` |
| `airQrSamplePayload` | `bodyAirQrSamplePayload` |
| `airQrPayloadLabel` | `labelAirQrPayload` |
| `airQrPayloadHint` | `helpAirQrPayload` |
| `airQrStreamSpeed` | `labelAirQrStreamSpeed` |
| `airQrFps` | `labelAirQrFps` |
| `airQrStartStream` | `actionAirQrStartStream` |
| `airQrStopStream` | `actionAirQrStopStream` |
| `airQrFrameParity` | `bodyAirQrFrameParity` |
| `airQrFrameBlock` | `bodyAirQrFrameBlock` |
| `airQrTotalFrames` | `bodyAirQrTotalFrames` |
| `airQrReceiverTitle` | `titleAirQrReceiver` |
| `airQrTransmitterTooltip` | `tooltipAirQrTransmitter` |
| `airQrResetStream` | `tooltipAirQrResetStream` |
| `airQrInitializing` | `bodyAirQrInitializing` |
| `airQrStatusReassembled` | `bodyAirQrStatusReassembled` |
| `airQrStatusCapturing` | `bodyAirQrStatusCapturing` |
| `airQrStatusIdle` | `bodyAirQrStatusIdle` |
| `airQrCaptured` | `bodyAirQrCaptured` |
| `airQrMissing` | `bodyAirQrMissing` |
| `airQrTransferComplete` | `titleAirQrTransferComplete` |
| `airQrTransferCompleteDetail` | `bodyAirQrTransferComplete` |
| `airQrPayloadCopied` | `bodyAirQrPayloadCopied` |
| `airQrChecksumFailed` | `errorAirQrChecksumFailed` |
| `airQrCodeLabel` | `labelAirQrCode` |
| `airQrCodeHint` | `helpAirQrCode` |
| `airQrDetectedTitle` | `titleAirQrDetected` |
| `airQrDetectedSubtitle` | `bodyAirQrDetected` |
| `airQrModeText` | `labelAirQrModeText` |
| `airQrModeSync` | `labelAirQrModeSync` |
| `airQrSyncIncludeHistory` | `labelAirQrSyncIncludeHistory` |
| `airQrSyncIncludeSettings` | `labelAirQrSyncIncludeSettings` |
| `airQrSyncPassphraseLabel` | `labelAirQrSyncPassphrase` |
| `airQrSyncPassphraseHint` | `helpAirQrSyncPassphrase` |
| `airQrSyncGeneratePin` | `tooltipAirQrSyncGeneratePin` |
| `airQrSyncNoDataWarning` | `errorAirQrSyncNoData` |
| `airQrSyncPackageDetected` | `titleAirQrSyncPackage` |
| `airQrSyncPackageSummary` | `bodyAirQrSyncPackageSummary` |
| `airQrSyncEnterPassphrase` | `labelAirQrSyncEnterPassphrase` |
| `airQrSyncRestoreHistory` | `labelAirQrSyncRestoreHistory` |
| `airQrSyncApplySettings` | `labelAirQrSyncApplySettings` |
| `airQrSyncDecryptButton` | `actionAirQrSyncDecrypt` |
| `airQrSyncSuccess` | `bodyAirQrSyncSuccess` |
| `airQrSyncBeamAction` | `actionAirQrSyncBeam` |
| `airQrSyncSettingsTitle` | `titleAirQrSyncSettings` |
| `airQrSyncSettingsSubtitle` | `descAirQrSyncSettings` |
| `airQrUnlockedTitle` | `titleAirQrUnlocked` |

## Deleted unused keys (1)

- `airQrSyncBeamButton` (not used anywhere in the code)

## Changed values

| Key | Language | Before | After |
|---|---|---|---|
| `titleAirQrTransmitter` | en | AirQR Stream Transmitter | AirQR transmitter |
| `labelAirQrPayload` | en | Payload Data to Broadcast | Data to send |
| `actionAirQrStartStream` | en | Broadcast Optical Stream | Start stream |
| `actionAirQrStopStream` | en | Stop Optical Stream | Stop stream |
| `titleAirQrReceiver` | en | AirQR Stream Receiver | AirQR receiver |
| `titleAirQrTransferComplete` | en | Air-Gap Transfer Complete! | Transfer complete! |
| `titleAirQrDetected` | en | AirQR Encrypted Transfer | AirQR transfer |
| `labelAirQrSyncIncludeHistory` | en | Include scan history ({count}) | History ({count}) |
| `titleAirQrSyncPackage` | en | AirQR Encrypted Sync Package | AirQR sync package |
| `labelAirQrSyncEnterPassphrase` | en | Enter Passphrase to Decrypt | Sync passphrase |
| `titleAirQrUnlocked` | en | AirQR payload unlocked | AirQR unlocked |
| `labelAirQrSyncPassphrase` | en | Sync Passphrase / PIN | Passphrase / PIN |
| `labelAirQrSyncIncludeHistory` | en | Include scan history ({count}) | History ({count}) |
| `labelAirQrSyncIncludeHistory` | ml | സ്കാൻ ഹിസ്റ്ററി ഉൾപ്പെടുത്തുക ({count}) | നാൾവഴി ({count}) |
| `labelAirQrSyncIncludeHistory` | sa | अवलोकनवृत्तं योजयतु ({count}) | इतिवृत्तम् ({count}) |
| `labelAirQrSyncRestoreHistory` | en | Restore scan history | Restore scan history |
| `labelAirQrSyncRestoreHistory` | ml | സ്കാൻ ഹിസ്റ്ററി പുനഃസ്ഥാപിക്കുക | സ്കാൻ നാൾവഴി പുനഃസ്ഥാപിക്കുക |
| `labelAirQrSyncRestoreHistory` | sa | अवलोकनवृत्तं पुनस्स्थापयतु | इतिवृत्तं पुनःस्थापयतु |
| `labelAirQrSyncEnterPassphrase` | en | Enter Passphrase to Decrypt | Sync passphrase |
| `labelAirQrSyncEnterPassphrase` | ml | ഡീക്രിപ്റ്റ് ചെയ്യാൻ പാസ്‌ഫ്രെയ്സ് നൽകുക | സിങ്ക് പാസ്‌ഫ്രെയ്സ് |
| `labelAirQrSyncEnterPassphrase` | sa | उद्घाटयितुं गुप्तपदं लिखतु | समन्वय-गुप्तपदम् |
| `titleAirQrDetected` | en | AirQR Encrypted Transfer | AirQR transfer |
| `titleAirQrDetected` | ml | എയർ ക്യുആർ എൻക്രിപ്റ്റ് ചെയ്ത കൈമാറ്റം | എയർ ക്യുആർ കൈമാറ്റം |
| `titleAirQrDetected` | sa | वायु-क्यूआर गूढ-हस्तान्तरणम् | वायु-क्यूआर हस्तान्तरणम् |
| `labelAirQrPayload` | en | Payload Data to Broadcast | Data to send |
| `labelAirQrPayload` | ml | പ്രക്ഷേപണം ചെയ്യേണ്ട വിവരങ്ങൾ | അയയ്ക്കേണ്ട വിവരങ്ങൾ |
| `labelAirQrPayload` | sa | प्रसारणीयः विषयः | प्रसारणीयः विषयः |
| `titleAirQrTransferComplete` | en | Air-Gap Transfer Complete! | Transfer complete! |
| `titleAirQrTransferComplete` | ml | ഡാറ്റാ കൈമാറ്റം പൂർത്തിയായി! | കൈമാറ്റം പൂർത്തിയായി! |
| `titleAirQrTransferComplete` | sa | हस्तान्तरणं सम्पूर्णम्! | हस्तान्तरणं सम्पूर्णम्! |
