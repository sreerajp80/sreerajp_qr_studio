# Change Log: Tri-Lingual Localization and Guideline Adherence

**Date:** 2026-09-14  
**Plan Reference:** [plans/20260914_195900_implement_tri_lingual_localization.md](plans/20260914_195900_implement_tri_lingual_localization.md)  
**Status:** Completed  

---

## Overview

Implemented full tri-lingual localization across English (`en`), Malayalam (`ml`), and Sanskrit (`sa`) to meet 100% adherence with the project engineering standards and localization guidelines.

---

## Summary of Changes

### 1. ARB Localization Catalogs
- **`lib/l10n/app_en.arb`**: Added 16 missing keys for language picker, about copyright, API quota percentage, and tooltips (total 632 keys).
- **`lib/l10n/app_ml.arb`**: Created complete Malayalam catalog (632 keys) adhering to natural Malayalam vocabulary, `-ക്കുക` action verbs for buttons, and proper negations.
- **`lib/l10n/app_sa.arb`**: Created complete Sanskrit catalog (632 keys) in classical Sanskrit, strictly passing the automated Hindi marker gate with zero forbidden postpositions or copulas.
- **`lib/l10n/gen/`**: Re-generated Dart accessor classes for all three languages via `flutter gen-l10n`.

### 2. Sanskrit Framework Delegates
- **`lib/l10n/sa_material_localizations.dart`**: Implemented `SaMaterialLocalizationsDelegate`, `SaCupertinoLocalizationsDelegate`, and `SaWidgetsLocalizationsDelegate` providing reliable fallback values for Material and Cupertino widgets under Sanskrit locale.

### 3. State Management & Language Switching
- **`lib/providers/locale_provider.dart`**: Created `LocaleProvider` with persistence to `SharedPreferences` (`app_language` key supporting `system`, `en`, `ml`, and `sa`).
- **`lib/main.dart`**: Wired `LocaleProvider` into `MultiProvider`, wrapped `MaterialApp` with `Consumer2<ThemeProvider, LocaleProvider>`, registered Sanskrit delegates, and added `localeResolutionCallback`.
- **`lib/screens/settings_screen.dart`**: Added a Language settings card with an interactive dialog allowing seamless switching between System Default, English, Malayalam, and Sanskrit without restarting the app.

### 4. Typography & Font Fallbacks
- **`lib/providers/theme_provider.dart`**: Configured `fontFamilyFallback` across all text themes to include `Noto Sans Malayalam` and `Noto Sans Devanagari` to prevent glyph clipping and tofu characters.

### 5. UI Tooltips & String Externalization
- **`lib/screens/about_screen.dart`**: Externalized the copyright text to `l10n.aboutCopyright`.
- **`lib/screens/settings_screen.dart`**: Externalized quota percentage to `l10n.apiQuotaPercentageUsed`.
- Added localized tooltips to all icon-only buttons across screens (`lib/screens/air_qr_screen.dart`, `lib/screens/ar_codevision_screen.dart`, `lib/screens/history_screen.dart`, `lib/screens/result_screen.dart`, `lib/screens/settings_screen.dart`, `lib/screens/widgets/history_detail_sheet.dart`, `lib/screens/widgets/pdf_scan_results_sheet.dart`, `lib/screens/widgets/totp_action_card.dart`, `lib/screens/widgets/export_import_dialog.dart`).

### 6. Automated Testing & Verification
- **`test/l10n/l10n_parity_test.dart`**: Automated test enforcing 100% key parity, placeholder parity, and the Sanskrit Hindi marker rejection regex gate.
- **`test/l10n/sa_localizations_test.dart`**: Unit tests verifying Sanskrit Material/Cupertino/Widgets delegates.
- **`test/providers/locale_provider_test.dart`**: Unit tests for language selection and persistence.
- **`test/screens/settings_screen_test.dart`**: Widget tests for language card and dialog rendering.
- All 199 unit and widget tests pass.
- `flutter analyze` is completely clean with 0 warnings.
