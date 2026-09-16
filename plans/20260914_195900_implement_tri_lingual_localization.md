# Plan: Comprehensive Tri-Lingual Localization & 100% Guideline Adherence

**Status:** Completed

## Overview & Scope Assessment

To achieve 100% strict adherence with `docs/guidelines/guideline.md` and `docs/guidelines/flutter_project_engineering_standard.md`, here is the exact scope of work:

| Component / Step | Status | Scope / Volume |
|---|---|---|
| **1. Fix `CLAUDE.md` and `AGENTS.md`** | Completed | Mandatory tri-lingual rule, Sanskrit delegates, and language persistence codified |
| **2. Create Sanskrit Fallback Delegates** | To Implement | 1 new file (`lib/l10n/sa_material_localizations.dart`) with Material, Cupertino, and Widgets delegates |
| **3. Implement Locale Provider & `main.dart` Wiring** | To Implement | 1 new provider (`lib/providers/locale_provider.dart`), update `lib/main.dart` with delegates and `localeResolutionCallback` |
| **4. Add Language Selector in Settings** | To Implement | `lib/screens/settings_screen.dart` Appearance card with selection modal (System / English / മലയാളം / संस्कृतम्) |
| **5. Create `app_ml.arb` & `app_sa.arb`** | To Implement | **616 keys** in Malayalam (`app_ml.arb`) and **616 keys** in pure classical Sanskrit (`app_sa.arb`) with 100% key and placeholder parity |
| **6. Add Missing Tooltips to Icon Buttons** | To Implement | 14 icon-only buttons across 5 screen files (`scanner_screen`, `air_qr_screen`, `ar_codevision_screen`, `result_screen`, `settings_screen`) |
| **7. Residual Hardcoded Strings & Font Fallback** | To Implement | Add `fontFamilyFallback` in `theme_provider.dart`; externalize remaining literals in `about_screen.dart` and `settings_screen.dart` |
| **8. Automated Verification Tests** | To Implement | 3 new test files: ARB key parity test, Sanskrit widget smoke test, and LocaleProvider unit test |

---

## Detailed Step-by-Step Implementation

### Step 1: Sanskrit Fallback Delegates (`lib/l10n/sa_material_localizations.dart`)
- Create `SaMaterialLocalizationsDelegate`, `SaCupertinoLocalizationsDelegate`, and `SaWidgetsLocalizationsDelegate`.
- Answer for `Locale('sa')` by delegating to English framework translations, preventing runtime crashes in Material widgets (dialogs, date pickers, text selection).

### Step 2: Locale State Management (`lib/providers/locale_provider.dart` & `lib/main.dart`)
- Implement `LocaleProvider` extending `ChangeNotifier`:
  - Default: `null` (system locale).
  - Supported locales: `en`, `ml`, `sa`.
  - Persistence: read and write to `SharedPreferences` key `app_language` (`system`, `en`, `ml`, `sa`).
  - Method: `setLanguage(String value)`.
- Wire into `lib/main.dart`:
  - Register `LocaleProvider` in `MultiProvider`.
  - Wrap `MaterialApp` with `Consumer2<ThemeProvider, LocaleProvider>`.
  - Pass `locale: localeProvider.locale`.
  - Register Sanskrit delegates ahead of `GlobalMaterialLocalizations.delegate`.
  - Provide `localeResolutionCallback` checking device locale against `en`, `ml`, `sa` (fallback to `en`).

### Step 3: In-App Language Picker in Settings (`lib/screens/settings_screen.dart`)
- Add a "Language" ListTile to the Appearance card in `settings_screen.dart`.
- Subtitle displays the current active language in its own native endonym:
  - System default: localized (e.g. `സിസ്റ്റം സ്വതവേ` / `तन्त्रसिद्धम्` / `System default`).
  - English: `English`
  - Malayalam: `മലയാളം`
  - Sanskrit: `संस्कृतम्`
- Tapping opens a radio selection dialog. Selecting a language persists immediately and rebuilds the app with no restart needed.

### Step 4: Full Translation Generation with 100% Key Parity
- **Total Keys:** 616 keys in `app_en.arb`.
- **`lib/l10n/app_ml.arb`**:
  - Full translations for all 616 keys into natural Malayalam.
  - Strict compliance with §8.5.2: authentic Malayalam vocabulary (`സൂക്ഷിക്കുക`, `അച്ചടിക്കുക`, `ക്രമീകരണങ്ങൾ`, `പകർത്തുക`, `തിരയുക`, `റദ്ദാക്കുക`), verbal `-ക്കുക` forms for action buttons, correct `അതെ / ഇല്ല` negation.
  - Placeholder preservation: all `{placeholder}` tokens match `app_en.arb` character-for-character.
- **`lib/l10n/app_sa.arb`**:
  - Full translations for all 616 keys into classical Sanskrit.
  - Strict compliance with §8.5.1: polite imperative `-ताम्` forms for buttons (`रक्ष्यताम्`, `प्रतिलिख्यताम्`, `निरस्यताम्`, `अन्विष्यताम्`, `पिधीयताम्`), abstract nouns for titles/labels (`विन्यासः`, `अन्वेषणम्`), zero forbidden Hindi markers.
  - Placeholder preservation: all `{placeholder}` tokens match `app_en.arb` character-for-character.
- Run `flutter gen-l10n` to regenerate typed accessors in `lib/l10n/gen/`.

### Step 5: Missing Tooltips Coverage (§7.8)
Add localized tooltips to all icon-only buttons across screens:
- `lib/screens/scanner_screen.dart`:
  - Flash button (`l10n.tooltipToggleFlash`)
  - Adjustments button (`l10n.tooltipCameraAdjustments`)
  - Zoom button (`l10n.tooltipZoomControls`)
  - Flip camera button (`l10n.tooltipSwitchCamera`)
- `lib/screens/air_qr_screen.dart`:
  - Switch to transmitter button
  - Reset stream button
  - Flashlight toggle button
  - Flip camera button
- `lib/screens/ar_codevision_screen.dart`:
  - Back button
  - Torch toggle button
- `lib/screens/result_screen.dart`:
  - Back button
  - Stego secret password visibility toggle
- `lib/screens/settings_screen.dart`:
  - Safe Browsing API key visibility toggle

### Step 6: Font Fallback Chain & Residual Literals
- In `lib/providers/theme_provider.dart`, add `fontFamilyFallback: const ['Noto Sans Malayalam', 'Noto Sans Devanagari', 'sans-serif']` to `ThemeData`.
- In `lib/screens/about_screen.dart`, externalize copyright string to ARB key `aboutCopyright`.
- In `lib/screens/settings_screen.dart`, externalize percentage label to ARB key `apiQuotaPercentageUsed`.

### Step 7: Automated Verification Tests
1. **`test/l10n/l10n_parity_test.dart`**:
   - Compares JSON keys of `app_en.arb`, `app_ml.arb`, and `app_sa.arb`.
   - Asserts 100% key parity (every key in `en` exists in `ml` and `sa`).
   - Asserts exact placeholder match across files.
   - Executes the automated PCRE Hindi marker regex check on `app_sa.arb`.
2. **`test/l10n/sa_localizations_test.dart`**:
   - Widget test that pumps the app with `Locale('sa')` and opens a Material dialog / date picker to verify zero delegate crashes.
3. **`test/providers/locale_provider_test.dart`**:
   - Unit tests covering `LocaleProvider` initialization, language switching, and persistence to `SharedPreferences`.

---

## Files to Create

1. `lib/l10n/app_ml.arb` (616 Malayalam keys)
2. `lib/l10n/app_sa.arb` (616 Sanskrit keys)
3. `lib/l10n/sa_material_localizations.dart`
4. `lib/providers/locale_provider.dart`
5. `test/l10n/l10n_parity_test.dart`
6. `test/l10n/sa_localizations_test.dart`
7. `test/providers/locale_provider_test.dart`

## Files to Modify

1. `lib/l10n/app_en.arb` (add tooltip/residual keys: `aboutCopyright`, `apiQuotaPercentageUsed`, etc.)
2. `lib/main.dart`
3. `lib/screens/settings_screen.dart`
4. `lib/providers/theme_provider.dart`
5. `lib/screens/scanner_screen.dart`
6. `lib/screens/air_qr_screen.dart`
7. `lib/screens/ar_codevision_screen.dart`
8. `lib/screens/result_screen.dart`
9. `lib/screens/about_screen.dart`

---

## Verification Plan

### Automated Tests
- `flutter gen-l10n`
- `flutter test test/l10n/l10n_parity_test.dart`
- `flutter test test/l10n/sa_localizations_test.dart`
- `flutter test test/providers/locale_provider_test.dart`
- `flutter test` (all tests passing)
- `flutter analyze` (0 warnings)
- `dart format .`
