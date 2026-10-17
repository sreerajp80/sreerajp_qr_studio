# Phase 10 batch 9 — AR CodeVision and CodeForge keys

Implements batch 9 (AR CodeVision and CodeForge keys) of `plans/20261013_071846_phase10_arb_key_prefixes.md`.

## What changed

- Renamed the `ar*` and `codeForge*` ARB keys to the standard prefixes in all three ARB
  files and in the Dart code. Section headers became `title…`; chips, fields and presets
  `label…`; field hints `help…`; input checks `error…`; messages `body…`. Regenerated
  `lib/l10n/gen/`.
- Deleted 6 unused keys (see below).
- Shortened three tooltips that were over the label budget, in all three languages.

## Checks

`flutter analyze` clean, all 687 tests pass, `dart format` applied, Sanskrit Hindi-marker
gate passes.

## Native-reader review

Please check the new ml/sa tooltip texts in the "Changed values" table.

## Renamed keys (106)

| Old key | New key |
|---|---|
| `arCloseSheet` | `tooltipArCloseSheet` |
| `arItemPriceTag` | `bodyArItemPriceTag` |
| `arContentCopied` | `bodyArContentCopied` |
| `arCopyButton` | `actionArCopy` |
| `arOpenUrlButton` | `actionArOpenUrl` |
| `arSelectButton` | `actionArSelect` |
| `arDeselectButton` | `actionArDeselect` |
| `arSafetyStatusSafe` | `bodyArSafetyStatusSafe` |
| `arSafetyStatusWarning` | `bodyArSafetyStatusWarning` |
| `arSafetyStatusUnknown` | `bodyArSafetyStatusUnknown` |
| `arScreenTitle` | `titleArScreen` |
| `arInitializing` | `bodyArInitializing` |
| `arClearSelection` | `actionArClearSelection` |
| `arBatchCopy` | `actionArBatchCopy` |
| `arBatchCopied` | `bodyArBatchCopied` |
| `arCameraPermissionMessage` | `bodyArCameraPermission` |
| `codeForgeTitle` | `titleCodeForge` |
| `codeForgeSubtitle` | `labelCodeForgeSubtitle` |
| `codeForgePresetText` | `labelCodeForgePresetText` |
| `codeForgeTextHint` | `helpCodeForgeText` |
| `codeForgeLoadFromFile` | `actionCodeForgeLoadFromFile` |
| `codeForgeLoadFromFileTooltip` | `tooltipCodeForgeLoadFromFile` |
| `codeForgeFileEmpty` | `errorCodeForgeFileEmpty` |
| `codeForgeFileTruncated` | `bodyCodeForgeFileTruncated` |
| `codeForgeFileLoaded` | `bodyCodeForgeFileLoaded` |
| `codeForgeFileReadError` | `errorCodeForgeFileReadError` |
| `codeForgePresetUrl` | `labelCodeForgePresetUrl` |
| `codeForgePresetWifi` | `labelCodeForgePresetWifi` |
| `codeForgePresetContact` | `labelCodeForgePresetContact` |
| `codeForgePresetUpi` | `labelCodeForgePresetUpi` |
| `codeForgePresetSms` | `labelCodeForgePresetSms` |
| `codeForgePresetEmail` | `labelCodeForgePresetEmail` |
| `codeForgePresetGeo` | `labelCodeForgePresetGeo` |
| `codeForgeWifiSsid` | `labelCodeForgeWifiSsid` |
| `codeForgeWifiPassword` | `labelCodeForgeWifiPassword` |
| `codeForgeWifiSecurity` | `labelCodeForgeWifiSecurity` |
| `codeForgeWifiHidden` | `labelCodeForgeWifiHidden` |
| `codeForgeContactName` | `labelCodeForgeContactName` |
| `codeForgeContactPhone` | `labelCodeForgeContactPhone` |
| `codeForgeContactEmail` | `labelCodeForgeContactEmail` |
| `codeForgeContactOrg` | `labelCodeForgeContactOrg` |
| `codeForgeUpiVpa` | `labelCodeForgeUpiVpa` |
| `codeForgeUpiName` | `labelCodeForgeUpiName` |
| `codeForgeUpiAmount` | `labelCodeForgeUpiAmount` |
| `codeForgeUpiNote` | `labelCodeForgeUpiNote` |
| `codeForgeSmsPhone` | `labelCodeForgeSmsPhone` |
| `codeForgeSmsMessage` | `labelCodeForgeSmsMessage` |
| `codeForgeEmailTo` | `labelCodeForgeEmailTo` |
| `codeForgeEmailSubject` | `labelCodeForgeEmailSubject` |
| `codeForgeEmailBody` | `labelCodeForgeEmailBody` |
| `codeForgeGeoLat` | `labelCodeForgeGeoLat` |
| `codeForgeGeoLng` | `labelCodeForgeGeoLng` |
| `codeForgeGeoUseMyLocation` | `actionCodeForgeGeoUseMyLocation` |
| `codeForgeGeoFetching` | `labelCodeForgeGeoFetching` |
| `codeForgeGeoFailed` | `errorCodeForgeGeoFailed` |
| `codeForgeGeoPermissionDenied` | `errorCodeForgeGeoPermissionDenied` |
| `codeForgeDesignStudio` | `titleCodeForgeDesignStudio` |
| `codeForgeEyeShape` | `titleCodeForgeEyeShape` |
| `codeForgeEyeBallShape` | `titleCodeForgeEyeBallShape` |
| `codeForgePatternShape` | `titleCodeForgePatternShape` |
| `codeForgeShapeSquare` | `labelCodeForgeShapeSquare` |
| `codeForgeShapeDots` | `labelCodeForgeShapeDots` |
| `codeForgeShapeRounded` | `labelCodeForgeShapeRounded` |
| `codeForgeShapeClassy` | `labelCodeForgeShapeClassy` |
| `codeForgeShapeDiamond` | `labelCodeForgeShapeDiamond` |
| `codeForgeShapeLeaf` | `labelCodeForgeShapeLeaf` |
| `codeForgeShapeCircle` | `labelCodeForgeShapeCircle` |
| `codeForgeColorStudio` | `titleCodeForgeColorStudio` |
| `codeForgeFgColor` | `titleCodeForgeFgColor` |
| `codeForgeBgColor` | `titleCodeForgeBgColor` |
| `codeForgeGradientNone` | `labelCodeForgeGradientNone` |
| `codeForgeGradientSunset` | `labelCodeForgeGradientSunset` |
| `codeForgeGradientOcean` | `labelCodeForgeGradientOcean` |
| `codeForgeGradientNeon` | `labelCodeForgeGradientNeon` |
| `codeForgeGradientGold` | `labelCodeForgeGradientGold` |
| `codeForgeErrorCorrection` | `titleCodeForgeErrorCorrection` |
| `codeForgeCenterBadge` | `titleCodeForgeCenterBadge` |
| `codeForgeBadgeNone` | `labelCodeForgeBadgeNone` |
| `codeForgeBadgeIcon` | `labelCodeForgeBadgeIcon` |
| `codeForgeBadgeShield` | `labelCodeForgeBadgeShield` |
| `codeForgeExportPng` | `actionCodeForgeExportPng` |
| `codeForgeExportSvg` | `actionCodeForgeExportSvg` |
| `codeForgeCopyPayload` | `tooltipCodeForgeCopyPayload` |
| `codeForgeCopied` | `bodyCodeForgeCopied` |
| `codeForgeSafeVerified` | `bodyCodeForgeSafeVerified` |
| `codeForgeResetStyle` | `tooltipCodeForgeResetStyle` |
| `codeForgeIncludeText` | `labelCodeForgeIncludeText` |
| `codeForgePreview` | `titleCodeForgePreview` |
| `codeForgeBarcodeContent` | `labelCodeForgeBarcodeContent` |
| `codeForgeBarcodeContentHint` | `helpCodeForgeBarcodeContent` |
| `codeForgeWifiSecurityNone` | `labelCodeForgeWifiSecurityNone` |
| `codeForgeUpiVpaHint` | `helpCodeForgeUpiVpa` |
| `codeForgeContentEmpty` | `errorCodeForgeContentEmpty` |
| `codeForgeTextTooLong` | `errorCodeForgeTextTooLong` |
| `codeForgeWifiSsidRequired` | `errorCodeForgeWifiSsidRequired` |
| `codeForgeUpiVpaRequired` | `errorCodeForgeUpiVpaRequired` |
| `codeForgeBarcodeInvalid` | `errorCodeForgeBarcodeInvalid` |
| `arItemsSelected` | `bodyArItemsSelected` |
| `arModeWarehouse` | `labelArModeWarehouse` |
| `arModeSafety` | `labelArModeSafety` |
| `arModeWarehouseTooltip` | `tooltipArModeWarehouse` |
| `arModeSafetyTooltip` | `tooltipArModeSafety` |
| `codeForgeSafetyPrompt` | `bodyCodeForgeSafetyPrompt` |
| `codeForgeSafetyCheckButton` | `actionCodeForgeSafetyCheck` |
| `codeForgeSafetyProblems` | `bodyCodeForgeSafetyProblems` |
| `codeForgeSafetyCheckAgain` | `actionCodeForgeSafetyCheckAgain` |

## Deleted unused keys (6)

- `codeForgeBarcodeType` (not used anywhere in the code)
- `codeForgePayloadType` (not used anywhere in the code)
- `codeForgeContactTitle` (not used anywhere in the code)
- `codeForgeContactUrl` (not used anywhere in the code)
- `codeForgeEyeOuterColor` (not used anywhere in the code)
- `codeForgeEyeInnerColor` (not used anywhere in the code)

## Changed values

| Key | Language | Before | After |
|---|---|---|---|
| `tooltipArModeWarehouse` | en | Show item info and select codes | Item info & select |
| `tooltipArModeWarehouse` | ml | ഇന വിവരം കാണിക്കുക, കോഡുകൾ തിരഞ്ഞെടുക്കുക | വിവരം, തിരഞ്ഞെടുപ്പ് |
| `tooltipArModeWarehouse` | sa | वस्तु-विवरणं दृश्यताम्, सङ्केताः चीयन्ताम् | वस्तु-विवरणं चयनं च |
| `tooltipArModeSafety` | en | Show a safety badge on each link | Link safety badges |
| `tooltipArModeSafety` | ml | ഓരോ ലിങ്കിലും സുരക്ഷാ അടയാളം കാണിക്കുക | ലിങ്ക് സുരക്ഷാ ബാഡ്ജ് |
| `tooltipArModeSafety` | sa | प्रतिसम्पर्के सुरक्षाचिह्नं दृश्यताम् | सेतु-सुरक्षा-चिह्नानि |
| `tooltipCodeForgeLoadFromFile` | en | Read text from a file into the QR code generator | Read text from file |
| `tooltipCodeForgeLoadFromFile` | ml | QR കോഡ് നിർമ്മിക്കാൻ ഫയലിൽ നിന്ന് വിവരങ്ങൾ എടുക്കുക | ഫയലിൽ നിന്ന് വായിക്കുക |
| `tooltipCodeForgeLoadFromFile` | sa | QR-संकेत-निर्माणाय सञ्चिकातः पाठं स्वीकरोतु | सञ्चिकातः पठ्यताम् |
