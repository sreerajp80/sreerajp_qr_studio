# Phase 10 batch 4 — link safety keys

Implements batch 4 (link safety keys) of `plans/20261013_071846_phase10_arb_key_prefixes.md`.

## What changed

- Renamed the link-safety ARB keys (check names, check results, pattern names, safety
  sheet, API key, URL-safety settings, providers, OpenPhish/PhishTank, verdict, DOM sandbox)
  to the standard prefixes, in `lib/l10n/app_en.arb`, `app_ml.arb` and `app_sa.arb`, and
  in every Dart file that uses them. Regenerated `lib/l10n/gen/`.
- Deleted 30 unused `api*` keys (an old API key screen that no longer exists).
- Shortened labels that were over the length budget (see the table below).
- `test/l10n/label_length_test.dart` now checks each plural/select branch on its own
  instead of the whole ICU string.
- `test/screens/result_screen_test.dart` uses the new, shorter English texts.
- Fix during the batch: the rename tool also renamed the model field
  `DomSandboxResult.sslValid`, which shares a name with an ARB key. This was put back.
  The tool now renames only `l10n.` uses.

## Checks

`flutter analyze` clean, all 687 tests pass, `dart format` clean, Sanskrit Hindi-marker
gate passes.

## Native-reader review

Please check these new ml/sa texts:

- `labelOpenPhishToggle` — ml "OpenPhish ഫീഡ് ഉപയോഗിക്കുക", sa "OpenPhish-सूचिः उपयुज्यताम्"
- `actionSafetyShowPassed` — ml "1 വിജയിച്ചത് കാണിക്കുക" / "{count} വിജയിച്ചവ കാണിക്കുക"

## Renamed keys (120)

| Old key | New key |
|---|---|
| `safetyCheckInProgress` | `titleSafetyCheckInProgress` |
| `safetyAnalysisTitle` | `titleSafetyAnalysis` |
| `safetyAnalyzing` | `bodySafetyAnalyzing` |
| `safetyIssuesDetected` | `bodySafetyIssuesDetected` |
| `safetyNoIssues` | `bodySafetyNoIssues` |
| `safetyTrustSourceHint` | `helpSafetyTrustSource` |
| `safetyResultsHeading` | `titleSafetyResults` |
| `apiKeyConfigured` | `labelApiKeyConfigured` |
| `apiKeyNotConfigured` | `labelApiKeyNotConfigured` |
| `apiKeyDeleteTitle` | `titleApiKeyDelete` |
| `apiKeySaveButton` | `actionApiKeySave` |
| `apiKeyDeleteMessage` | `bodyApiKeyDelete` |
| `checkNameHttps` | `labelCheckNameHttps` |
| `checkNameSsl` | `labelCheckNameSsl` |
| `checkNameRedirect` | `labelCheckNameRedirect` |
| `checkNamePattern` | `labelCheckNamePattern` |
| `checkNameShortener` | `labelCheckNameShortener` |
| `checkNameHomograph` | `labelCheckNameHomograph` |
| `checkNameMalicious` | `labelCheckNameMalicious` |
| `httpsNotUsed` | `bodyHttpsNotUsed` |
| `sslPrivateModeOk` | `bodySslPrivateModeOk` |
| `sslValid` | `bodySslValid` |
| `sslExpired` | `bodySslExpired` |
| `sslNotYetValid` | `bodySslNotYetValid` |
| `sslUnverifiable` | `bodySslUnverifiable` |
| `sslCheckFailed` | `bodySslCheckFailed` |
| `redirectSkippedPrivate` | `bodyRedirectSkippedPrivate` |
| `redirectLoop` | `bodyRedirectLoop` |
| `redirectNone` | `bodyRedirectNone` |
| `redirectUnavailable` | `bodyRedirectUnavailable` |
| `patternNone` | `bodyPatternNone` |
| `patternUnavailable` | `bodyPatternUnavailable` |
| `shortenerOfflineHeuristics` | `bodyShortenerOfflineHeuristics` |
| `shortenerNone` | `bodyShortenerNone` |
| `shortenerUnavailable` | `bodyShortenerUnavailable` |
| `homographMixedScripts` | `bodyHomographMixedScripts` |
| `homographNone` | `bodyHomographNone` |
| `homographUnavailable` | `bodyHomographUnavailable` |
| `maliciousSkippedNoKey` | `bodyMaliciousSkippedNoKey` |
| `maliciousDailyLimit` | `bodyMaliciousDailyLimit` |
| `maliciousNone` | `bodyMaliciousNone` |
| `maliciousInvalidKey` | `bodyMaliciousInvalidKey` |
| `maliciousRateLimited` | `bodyMaliciousRateLimited` |
| `maliciousUnavailable` | `bodyMaliciousUnavailable` |
| `redirectSuspiciousChain` | `bodyRedirectSuspiciousChain` |
| `redirectWithinRange` | `bodyRedirectWithinRange` |
| `patternDetected` | `bodyPatternDetected` |
| `shortenerKnown` | `bodyShortenerKnown` |
| `shortenerRedirect` | `bodyShortenerRedirect` |
| `homographLookalikes` | `bodyHomographLookalikes` |
| `maliciousThreats` | `bodyMaliciousThreats` |
| `maliciousApiError` | `bodyMaliciousApiError` |
| `checkNameVirusTotal` | `labelCheckNameVirusTotal` |
| `virusTotalSkippedNoKey` | `bodyVirusTotalSkippedNoKey` |
| `virusTotalDailyLimit` | `bodyVirusTotalDailyLimit` |
| `virusTotalThreats` | `bodyVirusTotalThreats` |
| `virusTotalNone` | `bodyVirusTotalNone` |
| `virusTotalInvalidKey` | `bodyVirusTotalInvalidKey` |
| `virusTotalRateLimited` | `bodyVirusTotalRateLimited` |
| `virusTotalApiError` | `bodyVirusTotalApiError` |
| `virusTotalUnavailable` | `bodyVirusTotalUnavailable` |
| `checkNameUrlhaus` | `labelCheckNameUrlhaus` |
| `urlhausSkippedNoKey` | `bodyUrlhausSkippedNoKey` |
| `urlhausMalware` | `bodyUrlhausMalware` |
| `urlhausClean` | `bodyUrlhausClean` |
| `urlhausNotFound` | `bodyUrlhausNotFound` |
| `urlhausInvalidKey` | `bodyUrlhausInvalidKey` |
| `urlhausApiError` | `bodyUrlhausApiError` |
| `urlhausUnavailable` | `bodyUrlhausUnavailable` |
| `checkNamePhishTank` | `labelCheckNamePhishTank` |
| `phishTankSkippedDisabled` | `bodyPhishTankSkippedDisabled` |
| `phishTankPhishing` | `bodyPhishTankPhishing` |
| `phishTankClean` | `bodyPhishTankClean` |
| `phishTankNotInDatabase` | `bodyPhishTankNotInDatabase` |
| `phishTankApiError` | `bodyPhishTankApiError` |
| `phishTankUnavailable` | `bodyPhishTankUnavailable` |
| `checkNameOpenPhish` | `labelCheckNameOpenPhish` |
| `openPhishSkippedDisabled` | `bodyOpenPhishSkippedDisabled` |
| `openPhishPhishing` | `bodyOpenPhishPhishing` |
| `openPhishClean` | `bodyOpenPhishClean` |
| `openPhishFeedStale` | `bodyOpenPhishFeedStale` |
| `openPhishUnavailable` | `bodyOpenPhishUnavailable` |
| `urlSafetyProvidersHelpText` | `helpUrlSafetyProviders` |
| `urlSafetyUserSuppliedHeader` | `titleUrlSafetyUserSupplied` |
| `urlSafetyUserSuppliedNote` | `descUrlSafetyUserSupplied` |
| `urlSafetyBuiltInHeader` | `titleUrlSafetyBuiltIn` |
| `urlSafetyBuiltInNote` | `descUrlSafetyBuiltIn` |
| `providerEndpointLabel` | `labelProviderEndpoint` |
| `providerApiKeyHint` | `labelProviderApiKey` |
| `providerGetKeyAt` | `bodyProviderGetKeyAt` |
| `providerDailyUsage` | `bodyProviderDailyUsage` |
| `openPhishLastUpdated` | `bodyOpenPhishLastUpdated` |
| `openPhishRefreshNow` | `actionOpenPhishRefresh` |
| `openPhishFeedRefreshed` | `bodyOpenPhishFeedRefreshed` |
| `openPhishFeedFailed` | `errorOpenPhishFeedFailed` |
| `phishTankToggleLabel` | `labelPhishTankToggle` |
| `openPhishToggleLabel` | `labelOpenPhishToggle` |
| `patternIpAddress` | `labelPatternIpAddress` |
| `patternLongNumbers` | `labelPatternLongNumbers` |
| `patternManyDashes` | `labelPatternManyDashes` |
| `patternPhishingKeywords` | `labelPatternPhishingKeywords` |
| `patternDataUri` | `labelPatternDataUri` |
| `patternManySubdomains` | `labelPatternManySubdomains` |
| `shortenerPossibleShortDomain` | `bodyShortenerPossibleShortDomain` |
| `shortenerPossibleRandomPath` | `bodyShortenerPossibleRandomPath` |
| `shortenerPossibleTld` | `bodyShortenerPossibleTld` |
| `verdictChecking` | `bodyVerdictChecking` |
| `verdictNoIssues` | `bodyVerdictNoIssues` |
| `verdictIssuesFound` | `bodyVerdictIssuesFound` |
| `verdictChecksPassed` | `bodyVerdictChecksPassed` |
| `verdictSeeDetails` | `actionVerdictSeeDetails` |
| `verdictModePrivate` | `labelVerdictModePrivate` |
| `verdictModeActive` | `labelVerdictModeActive` |
| `safetyShowPassed` | `actionSafetyShowPassed` |
| `safetyHidePassed` | `actionSafetyHidePassed` |
| `safetySkippedGroup` | `actionSafetySkippedGroup` |
| `safetySkippedSetup` | `actionSafetySkippedSetup` |
| `sandboxShowPreview` | `tooltipSandboxShowPreview` |
| `sandboxHidePreview` | `tooltipSandboxHidePreview` |
| `openPhishFeedNotDownloaded` | `bodyOpenPhishFeedNotDownloaded` |

## Deleted unused keys (30)

- `apiKeySaved` (not used anywhere in the code)
- `apiKeyDeleted` (not used anywhere in the code)
- `apiAboutHeading` (not used anywhere in the code)
- `apiKeyConfiguredTitle` (not used anywhere in the code)
- `apiKeyConfiguredSubtitle` (not used anywhere in the code)
- `apiLimitReached` (not used anywhere in the code)
- `apiLimitApproaching` (not used anywhere in the code)
- `apiKeyFieldLabel` (not used anywhere in the code)
- `apiKeyFieldHint` (not used anywhere in the code)
- `apiKeyRequired` (not used anywhere in the code)
- `apiKeyTooShort` (not used anywhere in the code)
- `apiHowToHeading` (not used anywhere in the code)
- `apiStep1Title` (not used anywhere in the code)
- `apiStep1Desc` (not used anywhere in the code)
- `apiStep2Title` (not used anywhere in the code)
- `apiStep2Desc` (not used anywhere in the code)
- `apiStep3Title` (not used anywhere in the code)
- `apiStep4Title` (not used anywhere in the code)
- `apiStep4Desc` (not used anywhere in the code)
- `apiStep5Title` (not used anywhere in the code)
- `apiStep5Desc` (not used anywhere in the code)
- `apiFreeTierNote` (not used anywhere in the code)
- `apiAboutBody` (not used anywhere in the code)
- `apiTodaysUsage` (not used anywhere in the code)
- `apiStep3Desc` (not used anywhere in the code)
- `apiKeySaveFailed` (not used anywhere in the code)
- `apiKeyDeleteFailed` (not used anywhere in the code)
- `apiDailyLimit` (not used anywhere in the code)
- `apiResets` (not used anywhere in the code)
- `apiQuotaPercentageUsed` (not used anywhere in the code)

## Changed values

| Key | Language | Before | After |
|---|---|---|---|
| `titleSafetyCheckInProgress` | en | Security Check In Progress | Checking security |
| `titleSafetyAnalysis` | en | URL Security Analysis | Link security |
| `titleSafetyResults` | en | Security Analysis Results: | Check results: |
| `labelOpenPhishToggle` | en | Enable OpenPhish feed | Use OpenPhish feed |
| `labelCheckNameHomograph` | en | Homograph Attack Check | Homograph check |
| `labelCheckNameMalicious` | en | Malicious Content Check | Malicious content |
| `labelPatternManyDashes` | en | Multiple Dashes/Underscores | Many dashes |
| `actionSafetyShowPassed` | en | {count, plural, =1{Show 1 passed check} other{Show {count} passed checks}} | {count, plural, =1{Show 1 passed} other{Show {count} passed}} |
| `actionSafetySkippedGroup` | en | {count, plural, =1{1 check skipped} other{{count} checks skipped}} | {count, plural, =1{1 check skipped} other{{count} skipped}} |
| `labelOpenPhishToggle` | en | Enable OpenPhish feed | Use OpenPhish feed |
| `labelOpenPhishToggle` | ml | OpenPhish ഫീഡ് പ്രവർത്തനക്ഷമമാക്കുക | OpenPhish ഫീഡ് ഉപയോഗിക്കുക |
| `labelOpenPhishToggle` | sa | OpenPhish-सूचिः सक्रियीकरणम् | OpenPhish-सूचिः उपयुज्यताम् |
| `actionSafetyShowPassed` | en | {count, plural, =1{Show 1 passed check} other{Show {count} passed checks}} | {count, plural, =1{Show 1 passed} other{Show {count} passed}} |
| `actionSafetyShowPassed` | ml | {count, plural, =1{വിജയിച്ച 1 പരിശോധന കാണിക്കുക} other{വിജയിച്ച {count} പരിശോധനകൾ കാണിക്കുക}} | {count, plural, =1{1 വിജയിച്ചത് കാണിക്കുക} other{{count} വിജയിച്ചവ കാണിക്കുക}} |
| `actionSafetyShowPassed` | sa | {count, plural, =1{1 सफल-परीक्षा दृश्यताम्} other{{count} सफल-परीक्षाः दृश्यन्ताम्}} | {count, plural, =1{1 सफल-परीक्षा दृश्यताम्} other{{count} सफल-परीक्षाः दृश्यन्ताम्}} |
