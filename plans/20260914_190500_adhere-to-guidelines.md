# Plan: Strictly Adhere to Project Guidelines

**Status:** Completed

## Problem Statement

A thorough audit of the project against `docs/guidelines/guideline.md`, `docs/guidelines/flutter_project_engineering_standard.md`, `docs/guidelines/AGENTS_MD_GUIDELINE.md`, and `docs/guidelines/CLAUDE_MD_GUIDELINE.md` revealed several deviations from the mandatory standards:

1. **`assets/config/app_config.json`**:
   - `description` is a raw string instead of a localized map (`{"en": ..., "ml": ..., "sa": ...}`) as required for prose.
   - `details` map uses Title Case keys with spaces (`"Author"`, `"Email"`, `"License"`, `"AI used"`, `"IDE used"`) instead of `lowerCamelCase` identifiers (`author`, `email`, `license`, `aiUsed`, `ideUsed`).
   - `license` in `details` is prose and must use the localized map format (`{"en": ..., "ml": ..., "sa": ...}`).

2. **`lib/core/config/app_config.dart`**:
   - Missing `LocalizedText` value type for multilingual resolution.
   - `AppConfig` fields `description` and `details` should hold `LocalizedText` instances rather than plain strings.
   - Fallback and `fromJson` must support locale map resolution and safe defaults without crashing.

3. **`lib/widgets/made_with_love.dart`**:
   - Missing the mandatory "Made with ❤️ from India" badge widget specified in `guideline.md` §1.7 (using `WidgetSpan`, `Icon(Icons.favorite, color: Color(0xFFE53935))`, and `Semantics(label: l10n.madeWithLoveA11y)`).

4. **`lib/screens/about_screen.dart`**:
   - Does not map `details` keys to translated labels (`aboutDetail<Key>`).
   - Does not resolve localized text with `LocalizedText.resolve(lang)`.
   - Uses an inline text footer instead of the standard `MadeWithLove` widget.

5. **`lib/l10n/app_en.arb`**:
   - Missing `aboutDetailAuthor`, `aboutDetailEmail`, `aboutDetailLicense`, `aboutDetailAiUsed`, `aboutDetailIdeUsed`.
   - Missing `madeWithLove` (with `{heart}` placeholder) and `madeWithLoveA11y`.

6. **`android/app/build.gradle`**:
   - Missing `bundle { language { enableSplit = false } }` required by engineering standard §8.1 to prevent language asset stripping on Google Play.

7. **`test/core/config/app_config_test.dart`**:
   - Unit tests must be updated to test `LocalizedText` and the new `AppConfig` parsing and fallback.

8. **`CLAUDE.md` and `AGENTS.md`**:
   - Keep both files fully aligned and in sync with `CLAUDE_MD_GUIDELINE.md` and `AGENTS_MD_GUIDELINE.md`.

## Proposed Fixes

### 1. Update `assets/config/app_config.json`
- Convert `description` to a locale map with English, Malayalam, and Sanskrit translations.
- Convert `details` keys to `lowerCamelCase` (`author`, `email`, `license`, `aiUsed`, `ideUsed`).
- Convert `license` to a locale map with English, Malayalam, and Sanskrit translations.

### 2. Update `lib/core/config/app_config.dart`
- Implement `LocalizedText` class matching `guideline.md` §1.4.
- Update `AppConfig` to use `LocalizedText` for `description` and `details`.
- Update `AppConfig.fallback` and `AppConfig.fromJson`.

### 3. Create `lib/widgets/made_with_love.dart`
- Implement the reference `MadeWithLove` widget with red vector heart and accessible semantics.

### 4. Update `lib/screens/about_screen.dart`
- Add `aboutDetailLabel(AppLocalizations l10n, String key)` helper.
- Render details dynamically with localized labels and active-locale resolution.
- Replace inline text with `const MadeWithLove()`.

### 5. Update `lib/l10n/app_en.arb` & Regenerate Localizations
- Add `aboutDetailAuthor`, `aboutDetailEmail`, `aboutDetailLicense`, `aboutDetailAiUsed`, `aboutDetailIdeUsed`.
- Add `madeWithLove` and `madeWithLoveA11y`.
- Run `flutter gen-l10n` to regenerate `lib/l10n/gen/`.

### 6. Update `android/app/build.gradle`
- Add `bundle { language { enableSplit = false } }` within `android { ... }`.

### 7. Update Unit & Widget Tests
- Update `test/core/config/app_config_test.dart` to verify `LocalizedText`, locale map parsing, and fallbacks.
- Verify that all existing unit tests and static analysis pass.

### 8. Align `CLAUDE.md` & `AGENTS.md`
- Ensure consistency with guidelines and rules.

## Files to Modify
- `assets/config/app_config.json`
- `lib/core/config/app_config.dart`
- `lib/screens/about_screen.dart`
- `lib/l10n/app_en.arb`
- `android/app/build.gradle`
- `test/core/config/app_config_test.dart`
- `CLAUDE.md`
- `AGENTS.md`

## Files to Create
- `lib/widgets/made_with_love.dart`

## Verification Plan
- Run `flutter gen-l10n`
- Run `dart format .`
- Run `flutter analyze`
- Run `flutter test`
