# Phase 10, batch 1 — ARB key prefixes: app-wide and settings

Plan: [plans/20261013_071846_phase10_arb_key_prefixes.md](../plans/20261013_071846_phase10_arb_key_prefixes.md) — batch 1 of 10
(app-wide, About, Settings, permissions, privacy, appearance, theme, scan feedback, language).

## What changed

- **125 keys renamed** to the standard prefixes (engineering standard §8.6) in `app_en.arb`,
  `app_ml.arb` and `app_sa.arb` (text edits — layout and line endings kept), with every use in
  `lib/` and `test/` (41 Dart files; every renamed use goes through `l10n` or
  `AppLocalizations.of(context)`). `flutter gen-l10n` re-run.
- Prefix chosen by real use: app-bar and dialog titles → `title…`; buttons, menu items, dialog
  actions → `action…`; icon-button tooltips → `tooltip…`; list-row, switch, chip and card labels
  → `label…`; subtitles → `desc…`; snackbars, dialog bodies, banners → `body…`.
- The **Permissions overview** rows (for example "Camera Access (android.permission.CAMERA)")
  are explanatory and quote Android's permission names, so they use `help…` rather than being
  shortened. `helpPermissionOverlayTitle` ("Display over other apps") is also shown as a row in
  the Scan bubble screen; it keeps Android's own wording on purpose.
- `labelAboutVersion` → `bodyAboutVersion`: the version line is text with placeholders, not a
  label.
- **4 unused keys deleted** (listed below).
- **9 English values shortened** — they are labels or titles that were over the 20-character
  budget. The Malayalam and Sanskrit values of these keys were already within 22 characters and
  keep their meaning, so they are unchanged.
- **Import order:** the `app_logger.dart` import was moved into the sorted `package:` imports in
  the 15 files where the Phase 5 script had put it first (the 16th was fixed in Phase 6).
- Tests that matched the old English wording (`settings_screen_test.dart`) now match the new
  wording.

## Checks

- `flutter analyze` — no issues (an unrenamed use would not compile).
- `flutter test` — all 687 passed, including the label-length test, which now covers every key
  of this batch.
- `dart format` check — no changes; Sanskrit Hindi-marker gate — passed.
- No Android build needed (Dart and ARB only).

## Renamed keys (125)

| Old key | New key |
|---|---|
| `appTitle` | `titleApp` |
| `percentValue` | `labelPercentValue` |
| `copiedToClipboard` | `bodyCopiedToClipboard` |
| `closeButton` | `actionClose` |
| `aboutTitle` | `titleAbout` |
| `aboutVersion` | `bodyAboutVersion` |
| `aboutBuildDate` | `labelAboutBuildDate` |
| `aboutOpenSourceLicenses` | `labelAboutOpenSourceLicenses` |
| `aboutOpenSourceLicensesDetail` | `descAboutOpenSourceLicenses` |
| `aboutCopyright` | `bodyAboutCopyright` |
| `toggleFlashlight` | `tooltipToggleFlashlight` |
| `grantCameraPermission` | `actionGrantCameraPermission` |
| `doneButton` | `actionDone` |
| `cancelButton` | `actionCancel` |
| `moreOptions` | `tooltipMoreOptions` |
| `menuHistory` | `actionMenuHistory` |
| `menuSettings` | `actionMenuSettings` |
| `grantPermission` | `actionGrantPermission` |
| `copiedLabel` | `labelCopied` |
| `hideAction` | `actionHide` |
| `revealAction` | `actionReveal` |
| `deleteButton` | `actionDelete` |
| `onLabel` | `labelOn` |
| `offLabel` | `labelOff` |
| `optionalFieldHint` | `labelOptionalField` |
| `probingBannerActive` | `bodyProbingBannerActive` |
| `probingBannerPrivate` | `bodyProbingBannerPrivate` |
| `warningDialogTitle` | `titleWarningDialog` |
| `warningDialogMessage` | `bodyWarningDialog` |
| `cautionDialogTitle` | `titleCautionDialog` |
| `cautionDialogMessage` | `bodyCautionDialog` |
| `overlayLaserLine` | `labelOverlayLaserLine` |
| `overlayPulsingCorners` | `labelOverlayPulsingCorners` |
| `overlayCyberneticGrid` | `labelOverlayCyberneticGrid` |
| `overlaySubtleDotMatrix` | `labelOverlaySubtleDotMatrix` |
| `overlayLaserLineDesc` | `descOverlayLaserLine` |
| `overlayPulsingCornersDesc` | `descOverlayPulsingCorners` |
| `overlayCyberneticGridDesc` | `descOverlayCyberneticGrid` |
| `overlaySubtleDotMatrixDesc` | `descOverlaySubtleDotMatrix` |
| `themeSystemDefault` | `labelThemeSystemDefault` |
| `themeLight` | `labelThemeLight` |
| `themeDark` | `labelThemeDark` |
| `themeOled` | `labelThemeOled` |
| `themeModeHeading` | `titleThemeMode` |
| `themeChipSystem` | `labelThemeChipSystem` |
| `themeChipLight` | `labelThemeChipLight` |
| `themeChipDark` | `labelThemeChipDark` |
| `themeChipOled` | `labelThemeChipOled` |
| `themeDynamicColorsTitle` | `labelThemeDynamicColors` |
| `themeDynamicColorsSubtitle` | `descThemeDynamicColors` |
| `themeDescSystem` | `descThemeSystem` |
| `themeDescLight` | `descThemeLight` |
| `themeDescDark` | `descThemeDark` |
| `themeDescOled` | `descThemeOled` |
| `settingsTitle` | `titleSettings` |
| `settingsFeedbackTitle` | `labelSettingsFeedback` |
| `settingsPrivacyTitle` | `labelSettingsPrivacy` |
| `settingsPermissionsTitle` | `labelSettingsPermissions` |
| `settingsPermissionsSubtitle` | `descSettingsPermissions` |
| `settingsHelpTitle` | `labelSettingsHelp` |
| `settingsHelpSubtitle` | `descSettingsHelp` |
| `settingsAboutSubtitle` | `descSettingsAbout` |
| `settingsUrlSafetyProvidersTitle` | `labelSettingsUrlSafetyProviders` |
| `settingsUrlSafetyProvidersSubtitle` | `descSettingsUrlSafetyProviders` |
| `settingsFeaturesTitle` | `titleSettingsFeatures` |
| `settingsFeaturesSubtitle` | `descSettingsFeatures` |
| `settingsLanguageTitle` | `labelSettingsLanguage` |
| `settingsOnboardingTourTitle` | `labelSettingsOnboardingTour` |
| `settingsOnboardingTourSubtitle` | `descSettingsOnboardingTour` |
| `settingsAppearanceSummary` | `descSettingsAppearanceSummary` |
| `feedbackVibrationTitle` | `labelFeedbackVibration` |
| `feedbackVibrationSubtitle` | `descFeedbackVibration` |
| `feedbackSoundTitle` | `labelFeedbackSound` |
| `feedbackSoundSubtitle` | `descFeedbackSound` |
| `feedbackAnimationTitle` | `labelFeedbackAnimation` |
| `feedbackAnimationSubtitle` | `descFeedbackAnimation` |
| `feedbackSummary` | `descFeedbackSummary` |
| `privacyScreenTitle` | `titlePrivacyScreen` |
| `privacyActiveChecksTitle` | `labelPrivacyActiveChecks` |
| `privacyActiveChecksSubtitle` | `descPrivacyActiveChecks` |
| `privacySummaryOn` | `descPrivacySummaryOn` |
| `privacySummaryOff` | `descPrivacySummaryOff` |
| `privacyExplainerOn` | `bodyPrivacyExplainerOn` |
| `privacyExplainerOff` | `bodyPrivacyExplainerOff` |
| `permissionsScreenTitle` | `titlePermissionsScreen` |
| `permissionsExplicitHeading` | `helpPermissionsExplicitHeading` |
| `permissionsImplicitHeading` | `helpPermissionsImplicitHeading` |
| `permissionsSettingHeading` | `helpPermissionsSettingHeading` |
| `permissionCameraTitle` | `helpPermissionCameraTitle` |
| `permissionCameraDesc` | `helpPermissionCameraDesc` |
| `permissionBiometricTitle` | `helpPermissionBiometricTitle` |
| `permissionBiometricDesc` | `helpPermissionBiometricDesc` |
| `permissionInternetTitle` | `helpPermissionInternetTitle` |
| `permissionInternetDesc` | `helpPermissionInternetDesc` |
| `permissionVibrateTitle` | `helpPermissionVibrateTitle` |
| `permissionVibrateDesc` | `helpPermissionVibrateDesc` |
| `permissionPhotoPickerTitle` | `helpPermissionPhotoPickerTitle` |
| `permissionPhotoPickerDesc` | `helpPermissionPhotoPickerDesc` |
| `permissionProbingTitle` | `helpPermissionProbingTitle` |
| `permissionProbingDesc` | `helpPermissionProbingDesc` |
| `permissionSafeBrowsingTitle` | `helpPermissionSafeBrowsingTitle` |
| `permissionSafeBrowsingDesc` | `helpPermissionSafeBrowsingDesc` |
| `permissionFeedbackTitle` | `helpPermissionFeedbackTitle` |
| `permissionFeedbackDesc` | `helpPermissionFeedbackDesc` |
| `permissionOverlayTitle` | `helpPermissionOverlayTitle` |
| `permissionOverlayDesc` | `helpPermissionOverlayDesc` |
| `permissionNotificationTitle` | `helpPermissionNotificationTitle` |
| `permissionNotificationDesc` | `helpPermissionNotificationDesc` |
| `appearanceHubTitle` | `titleAppearanceHub` |
| `appearanceThemeModeCardTitle` | `labelAppearanceThemeModeCard` |
| `appearanceThemeModeCardSubtitle` | `descAppearanceThemeModeCard` |
| `appearanceOverlayCardTitle` | `labelAppearanceOverlayCard` |
| `appearanceOverlayCardSubtitle` | `descAppearanceOverlayCard` |
| `appearanceAccentCardTitle` | `labelAppearanceAccentCard` |
| `appearanceAccentCardSubtitle` | `descAppearanceAccentCard` |
| `appearanceTypographyCardTitle` | `labelAppearanceTypographyCard` |
| `appearanceTypographyCardSubtitle` | `descAppearanceTypographyCard` |
| `languageSystemDefault` | `labelLanguageSystemDefault` |
| `languageEnglish` | `labelLanguageEnglish` |
| `languageMalayalam` | `labelLanguageMalayalam` |
| `languageSanskrit` | `labelLanguageSanskrit` |
| `accentDynamicColorInfo` | `helpAccentDynamicColor` |
| `typographySampleLine` | `bodyTypographySample` |
| `typographyScaleTitle` | `labelTypographyScale` |
| `typographyScaleInfo` | `helpTypographyScale` |

## Deleted unused keys (4)

- `settingsSafeBrowsingTitle` (not used anywhere in the code)
- `unknownLabel` (not used anywhere in the code)
- `settingsApiKeySubtitle` (not used anywhere in the code)
- `settingsLanguageSubtitle` (not used anywhere in the code)

## Changed values

| Key | Language | Before | After |
|---|---|---|---|
| `actionGrantCameraPermission` | en | Grant Camera Permission | Allow camera |
| `labelThemeDynamicColors` | en | Material You Dynamic Colors | Dynamic colors |
| `labelSettingsFeedback` | en | Scan Feedback & Alerts | Scan feedback |
| `labelSettingsPrivacy` | en | Privacy & Online Probing | Privacy & probing |
| `labelSettingsHelp` | en | Help & Feature Guides | Help & guides |
| `labelFeedbackAnimation` | en | Confirmation Animation | Success animation |
| `titlePrivacyScreen` | en | Privacy & Network Probing | Privacy & probing |
| `labelAppearanceAccentCard` | en | Accent Color & Dynamic Colors | Accent & colors |
| `labelAppearanceTypographyCard` | en | Typography & Text Size | Text size & font |
