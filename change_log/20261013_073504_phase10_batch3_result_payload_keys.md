# Phase 10, batch 3 — ARB key prefixes: result and payload cards

Plan: [plans/20261013_071846_phase10_arb_key_prefixes.md](../plans/20261013_071846_phase10_arb_key_prefixes.md) — batch 3 of 10
(result screen and smart payload cards: Wi-Fi, location, calendar, contact, TOTP, payment / UPI,
email, phone, SMS, app link, product barcode, ISBN; the open-risk dialog).

## What changed

- Keys renamed to the standard prefixes in all three ARB files and every Dart use (17 files);
  `flutter gen-l10n` re-run. Card headings → `title…`; card buttons and result actions →
  `action…`; icon-button tooltips → `tooltip…`; field and row labels, scheme and fallback
  names → `label…`; snackbars and lines with placeholders → `body…`; "could not open …"
  messages → `error…`.
- `urlSafety…` and `json…` keys were left for batches 4 and 6.
- Shortened values: 6 English labels/buttons over 20 characters, and the UPI pay button in
  Malayalam and Sanskrit (it listed the app names) — **needs native-reader review** for the
  ml/sa values.
- No unused keys in this batch.

## Checks

- `flutter analyze` — no issues; `flutter test` — all 687 passed; `dart format` check — no
  changes; Sanskrit gate — passed. No `AppMessageKey` reference was touched.

## Renamed keys (101)

| Old key | New key |
|---|---|
| `wifiCardTitle` | `titleWifiCard` |
| `wifiShowPassword` | `tooltipWifiShowPassword` |
| `wifiHidePassword` | `tooltipWifiHidePassword` |
| `wifiCopyPassword` | `tooltipWifiCopyPassword` |
| `wifiConnectButton` | `actionWifiConnect` |
| `wifiPasswordCopied` | `bodyWifiPasswordCopied` |
| `wifiOpenSettingsHint` | `bodyWifiOpenSettings` |
| `wifiConnectSuccess` | `bodyWifiConnectSuccess` |
| `wifiHiddenNetwork` | `labelWifiHiddenNetwork` |
| `geoLatLng` | `bodyGeoLatLng` |
| `geoQuery` | `bodyGeoQuery` |
| `geoNavigateButton` | `actionGeoNavigate` |
| `geoLaunchFailed` | `errorGeoLaunchFailed` |
| `calendarCardTitle` | `titleCalendarCard` |
| `calendarNoDate` | `labelCalendarNoDate` |
| `calendarStart` | `labelCalendarStart` |
| `calendarEnd` | `labelCalendarEnd` |
| `calendarAddButton` | `actionCalendarAdd` |
| `calendarLaunchFailed` | `errorCalendarLaunchFailed` |
| `contactCardTitle` | `titleContactCard` |
| `contactInitialFallback` | `labelContactInitialFallback` |
| `contactSaveButton` | `actionContactSave` |
| `contactLaunchFailed` | `errorContactLaunchFailed` |
| `contactCallFailed` | `errorContactCallFailed` |
| `contactEmailFailed` | `errorContactEmailFailed` |
| `totpDefaultIssuer` | `labelTotpDefaultIssuer` |
| `totpLivePasscode` | `bodyTotpLivePasscode` |
| `totpSecondsLeft` | `labelTotpSecondsLeft` |
| `totpCopyToken` | `tooltipTotpCopyToken` |
| `totpSecretLabel` | `labelTotpSecret` |
| `totpImportButton` | `actionTotpImport` |
| `totpLaunchFailed` | `errorTotpLaunchFailed` |
| `totpTokenCopied` | `bodyTotpTokenCopied` |
| `totpSecretCopied` | `bodyTotpSecretCopied` |
| `totpDefaultAccount` | `labelTotpDefaultAccount` |
| `paymentSchemeUpi` | `labelPaymentSchemeUpi` |
| `paymentSchemeSepa` | `labelPaymentSchemeSepa` |
| `paymentSchemeCrypto` | `labelPaymentSchemeCrypto` |
| `paymentPayeeFallback` | `labelPaymentPayeeFallback` |
| `paymentAddressLabelUpi` | `labelPaymentAddressUpi` |
| `paymentAddressLabelSepa` | `labelPaymentAddressSepa` |
| `paymentAddressLabelCrypto` | `labelPaymentAddressCrypto` |
| `paymentCopyAction` | `actionPaymentCopy` |
| `paymentUpiIdCopied` | `bodyPaymentUpiIdCopied` |
| `paymentAddressCopied` | `bodyPaymentAddressCopied` |
| `paymentNote` | `bodyPaymentNote` |
| `paymentPayButtonUpi` | `actionPaymentPayUpi` |
| `paymentPayButton` | `actionPaymentPay` |
| `paymentUpiLaunchFailed` | `errorPaymentUpiLaunchFailed` |
| `paymentLaunchFailed` | `errorPaymentLaunchFailed` |
| `paymentCopyIdAction` | `actionPaymentCopyId` |
| `paymentAmountDialogTitle` | `titlePaymentAmountDialog` |
| `paymentAmountDialogBody` | `bodyPaymentAmountDialog` |
| `paymentAmountFieldLabel` | `labelPaymentAmountField` |
| `paymentAmountInvalid` | `errorPaymentAmountInvalid` |
| `paymentAmountPayButton` | `actionPaymentAmountPay` |
| `resultScreenTitle` | `titleResultScreen` |
| `resultNoResult` | `bodyResultNoResult` |
| `resultContentLabel` | `labelResultContent` |
| `resultDecoyContentLabel` | `labelResultDecoyContent` |
| `resultDetectedType` | `labelResultDetectedType` |
| `resultTypeStego` | `labelResultTypeStego` |
| `resultRecheckButton` | `actionResultRecheck` |
| `resultOpenInBrowser` | `actionResultOpenInBrowser` |
| `resultCopyText` | `actionResultCopyText` |
| `resultCopyDecoyText` | `actionResultCopyDecoyText` |
| `resultShareText` | `actionResultShareText` |
| `resultShareDecoyText` | `actionResultShareDecoyText` |
| `resultScanAnother` | `actionResultScanAnother` |
| `resultLaunchFailed` | `errorResultLaunchFailed` |
| `resultTypeTextFallback` | `labelResultTypeTextFallback` |
| `resultMoreActions` | `tooltipResultMoreActions` |
| `openRiskDialogIssues` | `bodyOpenRiskDialogIssues` |
| `emailCardTitle` | `titleEmailCard` |
| `emailSendButton` | `actionEmailSend` |
| `emailCopyButton` | `actionEmailCopy` |
| `emailLaunchFailed` | `errorEmailLaunchFailed` |
| `emailSubjectLabel` | `labelEmailSubject` |
| `emailBodyLabel` | `labelEmailBody` |
| `phoneCardTitle` | `titlePhoneCard` |
| `phoneCallButton` | `actionPhoneCall` |
| `phoneCopyButton` | `actionPhoneCopy` |
| `phoneLaunchFailed` | `errorPhoneLaunchFailed` |
| `smsCardTitle` | `titleSmsCard` |
| `smsSendButton` | `actionSmsSend` |
| `smsCopyButton` | `actionSmsCopy` |
| `smsLaunchFailed` | `errorSmsLaunchFailed` |
| `smsBodyLabel` | `labelSmsBody` |
| `appLinkCardTitle` | `titleAppLinkCard` |
| `appLinkOpenButton` | `actionAppLinkOpen` |
| `appLinkLaunchFailed` | `errorAppLinkLaunchFailed` |
| `productBarcodeCardTitle` | `titleProductBarcodeCard` |
| `productSearchFoodButton` | `actionProductSearchFood` |
| `productSearchWebButton` | `actionProductSearchWeb` |
| `productCopyButton` | `actionProductCopy` |
| `productLaunchFailed` | `errorProductLaunchFailed` |
| `isbnCardTitle` | `titleIsbnCard` |
| `isbnGoogleBooksButton` | `actionIsbnGoogleBooks` |
| `isbnOpenLibraryButton` | `actionIsbnOpenLibrary` |
| `isbnCopyButton` | `actionIsbnCopy` |
| `isbnLaunchFailed` | `errorIsbnLaunchFailed` |

## Changed values

| Key | Language | Before | After |
|---|---|---|---|
| `actionCalendarAdd` | en | Add to Device Calendar | Add to calendar |
| `actionGeoNavigate` | en | Navigate in Google Maps | Open in Maps |
| `actionTotpImport` | en | Import into Authenticator App | Add to authenticator |
| `actionPaymentPayUpi` | en | Pay via App (GPay / PhonePe / Paytm) | Pay with UPI app |
| `labelResultDecoyContent` | en | Public Decoy Content: | Decoy content: |
| `labelResultTypeStego` | en | STEGO-QR (Encrypted Dual-Layer) | StegoQR (encrypted) |
| `actionPaymentPayUpi` | en | Pay via App (GPay / PhonePe / Paytm) | Pay with UPI app |
| `actionPaymentPayUpi` | ml | ആപ്പ് വഴി പണം നൽകുക (GPay / PhonePe / Paytm) | UPI ആപ്പ് വഴി നൽകുക |
| `actionPaymentPayUpi` | sa | अनुप्रयोगेन दीयताम् (GPay / PhonePe / Paytm) | UPI-अनुप्रयोगेन दीयताम् |
