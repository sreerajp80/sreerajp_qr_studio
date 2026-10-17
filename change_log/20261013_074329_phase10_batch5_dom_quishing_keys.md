# Phase 10 batch 5 — DOM sandbox and QuishingGuard keys

Implements batch 5 (DOM sandbox and QuishingGuard keys) of `plans/20261013_071846_phase10_arb_key_prefixes.md`.

## What changed

- Renamed the `dom*` and `quishing*` ARB keys to the standard prefixes in all three ARB
  files and in the Dart code. Status, signal and summary lines became `body…`; detail
  field names `label…`; headings `title…`; buttons `action…`. Regenerated `lib/l10n/gen/`.
- `AppMessageKey` enum names were not changed.
- Shortened some headings and buttons so they fit the label budget (table below). The
  new short wording was written in all three languages.

## Checks

`flutter analyze` clean, all 687 tests pass, `dart format` applied, Sanskrit Hindi-marker
gate passes.

## Native-reader review

Please check the new ml/sa texts in the "Changed values" table: `actionQuishingViewSignals`,
`actionQuishingHideSignals`, `titleQuishingSignals`, `labelQuishingCompactGenuine`,
`actionDomInspect`, `titleDomInspect`.

## Renamed keys (67)

| Old key | New key |
|---|---|
| `quishingGuardTitle` | `titleQuishingGuard` |
| `quishingTamperBadge` | `labelQuishingTamperBadge` |
| `quishingRiskScoreLabel` | `labelQuishingRiskScore` |
| `quishingViewSignals` | `actionQuishingViewSignals` |
| `quishingHideSignals` | `actionQuishingHideSignals` |
| `quishingMetricEdgeLabel` | `labelQuishingMetricEdge` |
| `quishingMetricEdgeDescription` | `descQuishingMetricEdge` |
| `quishingMetricGrainLabel` | `labelQuishingMetricGrain` |
| `quishingMetricGrainDescription` | `descQuishingMetricGrain` |
| `quishingSignalsHeading` | `titleQuishingSignals` |
| `domSandboxedBadge` | `labelDomSandboxedBadge` |
| `domTitleInitialFallback` | `labelDomTitleInitialFallback` |
| `domUntitledPage` | `labelDomUntitledPage` |
| `domThumbnailCaption` | `bodyDomThumbnailCaption` |
| `domBlockedBadge` | `bodyDomBlockedBadge` |
| `domNewlyRegistered` | `bodyDomNewlyRegistered` |
| `domDomainAge` | `bodyDomDomainAge` |
| `domOpenRedirectFound` | `bodyDomOpenRedirectFound` |
| `domNoOpenRedirect` | `bodyDomNoOpenRedirect` |
| `domInspectButton` | `actionDomInspect` |
| `domInspectTitle` | `titleDomInspect` |
| `domDetailPageTitle` | `labelDomDetailPageTitle` |
| `domDetailNotSpecified` | `labelDomDetailNotSpecified` |
| `domDetailMetaDescription` | `labelDomDetailMetaDescription` |
| `domDetailNoneFound` | `labelDomDetailNoneFound` |
| `domDetailHeadingsCount` | `labelDomDetailHeadingsCount` |
| `domDetailHeadingsValue` | `bodyDomDetailHeadingsValue` |
| `domDetailLinksFound` | `labelDomDetailLinksFound` |
| `domDetailLinksValue` | `bodyDomDetailLinksValue` |
| `domDetailBlockedScripts` | `labelDomDetailBlockedScripts` |
| `domDetailBlockedScriptsValue` | `bodyDomDetailBlockedScriptsValue` |
| `domDetailBlockedTrackers` | `labelDomDetailBlockedTrackers` |
| `domDetailBlockedTrackersValue` | `bodyDomDetailBlockedTrackersValue` |
| `domDetailBlockedIframes` | `labelDomDetailBlockedIframes` |
| `domDetailBlockedIframesValue` | `bodyDomDetailBlockedIframesValue` |
| `domSanitizedSnippetHeading` | `titleDomSanitizedSnippet` |
| `quishingSummaryAuthentic` | `bodyQuishingSummaryAuthentic` |
| `quishingSummaryWearAndTear` | `bodyQuishingSummaryWearAndTear` |
| `quishingSummaryHighWarning` | `bodyQuishingSummaryHighWarning` |
| `quishingStatusAuthentic` | `bodyQuishingStatusAuthentic` |
| `quishingStatusWearAndTear` | `bodyQuishingStatusWearAndTear` |
| `quishingStatusHighWarning` | `bodyQuishingStatusHighWarning` |
| `quishingSignalMicroShadowPerimeter` | `bodyQuishingSignalMicroShadowPerimeter` |
| `quishingSignalGrainAberration` | `bodyQuishingSignalGrainAberration` |
| `quishingSignalUniformReflection` | `bodyQuishingSignalUniformReflection` |
| `quishingSignalConsistentDotsQrMatrix` | `bodyQuishingSignalConsistentDotsQrMatrix` |
| `quishingSignalReflectionVerified` | `bodyQuishingSignalReflectionVerified` |
| `quishingSignalHalftoneConsistentQrMatrix` | `bodyQuishingSignalHalftoneConsistentQrMatrix` |
| `quishingSignalHalftoneConsistentMatrix` | `bodyQuishingSignalHalftoneConsistentMatrix` |
| `quishingSignalDoubleEdgeAroundMatrix` | `bodyQuishingSignalDoubleEdgeAroundMatrix` |
| `quishingSignalMicroShadowStickerBorder` | `bodyQuishingSignalMicroShadowStickerBorder` |
| `quishingSignalGrainMismatchBase` | `bodyQuishingSignalGrainMismatchBase` |
| `quishingSignalMinorScratch` | `bodyQuishingSignalMinorScratch` |
| `quishingSignalSlightDotIrregularity` | `bodyQuishingSignalSlightDotIrregularity` |
| `quishingSignalConsistentDotsMatrixPerimeter` | `bodyQuishingSignalConsistentDotsMatrixPerimeter` |
| `quishingSignalPerimeterDoubleEdge` | `bodyQuishingSignalPerimeterDoubleEdge` |
| `quishingSignalDotDensityVariance` | `bodyQuishingSignalDotDensityVariance` |
| `domSslInvalidScheme` | `bodyDomSslInvalidScheme` |
| `domSslHttps` | `bodyDomSslHttps` |
| `domSslHttp` | `bodyDomSslHttp` |
| `domStatusInvalidUrl` | `bodyDomStatusInvalidUrl` |
| `domStatusHttpCaution` | `bodyDomStatusHttpCaution` |
| `domStatusSafe` | `bodyDomStatusSafe` |
| `domStatusOpenRedirect` | `bodyDomStatusOpenRedirect` |
| `domStatusNewDomain` | `bodyDomStatusNewDomain` |
| `quishingCompactGenuine` | `labelQuishingCompactGenuine` |
| `domFetchFailedTitle` | `bodyDomFetchFailed` |

## Changed values

| Key | Language | Before | After |
|---|---|---|---|
| `titleDomSanitizedSnippet` | en | Sanitized HTML Preview Snippet: | Clean HTML preview: |
| `actionQuishingViewSignals` | en | View Forensic Analysis | Show signals |
| `actionQuishingViewSignals` | ml | ഫോറൻസിക് വിശകലനം കാണുക | സിഗ്നലുകൾ കാണിക്കുക |
| `actionQuishingViewSignals` | sa | सूक्ष्म-विश्लेषणं दृश्यताम् | संकेताः दृश्यन्ताम् |
| `actionQuishingHideSignals` | en | Hide Forensic Signals | Hide signals |
| `actionQuishingHideSignals` | ml | ഫോറൻസിക് സിഗ്നലുകൾ മറയ്ക്കുക | സിഗ്നലുകൾ മറയ്ക്കുക |
| `actionQuishingHideSignals` | sa | संकेताः गोप्यन्ताम् | संकेताः गोप्यन्ताम् |
| `titleQuishingSignals` | en | Detected Computer Vision Signals: | Detected signals: |
| `titleQuishingSignals` | ml | കണ്ടെത്തിയ കമ്പ്യൂട്ടർ വിഷൻ സിഗ്നലുകൾ: | കണ്ടെത്തിയ സിഗ്നലുകൾ: |
| `titleQuishingSignals` | sa | दृष्टाः सङ्गणक-दृष्टि-संकेताः: | दृष्टाः संकेताः: |
| `labelQuishingCompactGenuine` | en | Genuine print · {percent}% | Genuine · {percent}% |
| `labelQuishingCompactGenuine` | ml | യഥാർത്ഥ പ്രിന്റ് · {percent}% | യഥാർത്ഥം · {percent}% |
| `labelQuishingCompactGenuine` | sa | यथार्थ-मुद्रणम् · {percent}% | यथार्थम् · {percent}% |
| `actionDomInspect` | en | Inspect DOM Sandbox Structure | Inspect page |
| `actionDomInspect` | ml | സാൻഡ്‌ബോക്സ് ഘടന പരിശോധിക്കുക | പേജ് പരിശോധിക്കുക |
| `actionDomInspect` | sa | कक्षा-संरचना परीक्ष्यताम् | पृष्ठं परीक्ष्यताम् |
| `titleDomInspect` | en | Zero-Trust DOM Sandbox Hierarchy | Page structure |
| `titleDomInspect` | ml | DOM സാൻഡ്‌ബോക്സ് ശ്രേണി | പേജ് ഘടന |
| `titleDomInspect` | sa | विश्वस्त-कक्षा-संरचना | पृष्ठ-संरचना |
