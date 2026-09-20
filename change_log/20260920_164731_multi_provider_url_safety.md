# Change log — Multi-Provider URL Safety Integration

Implements plan: `plans/20260920_164731_multi_provider_url_safety.md`

## What changed

Added support for four free URL safety providers in addition to Google Safe Browsing:

1. **VirusTotal**:
   - Free personal API key required (non-commercial only).
   - Allows custom endpoint URL override.
   - Enforces 500 requests/day free tier quota with daily reset tracking.
   - Converts URLs to base64Url IDs and checks against VirusTotal v3 analysis engine statistics.

2. **URLhaus (abuse.ch)**:
   - Free Auth-Key required (non-commercial research/personal use).
   - Allows custom endpoint URL override.
   - Queries malicious URL status and flags malware campaigns with tags.

3. **PhishTank**:
   - Built-in provider (commercial-friendly).
   - Simple on/off toggle without needing an API key or account.
   - Direct check against PhishTank phishing verification database.

4. **OpenPhish**:
   - Built-in provider (commercial-friendly).
   - Simple on/off toggle with 12-hour local caching of the community feed.
   - Works offline once feed is cached.

5. **Settings UI**:
   - Replaced single Safe Browsing settings screen with unified `UrlSafetyProvidersScreen`.
   - Categorized into "Your API Keys" (for keys and custom endpoints) and "Built-In Providers" (simple toggles).
   - Main settings card now shows active provider count dynamically.

6. **Localization**:
   - Complete tri-lingual key parity across English (`app_en.arb`), Malayalam (`app_ml.arb`), and Sanskrit (`app_sa.arb`).
   - Integrated with `AppMessage` and `app_message_text.dart`.

7. **Tests**:
   - Updated `test/screens/settings_screen_test.dart` for the updated settings card title.
   - Added unit test coverage for all 4 new providers in `test/services/url_safety_service_test.dart`.

## Files modified

- `lib/models/app_message.dart`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ml.arb`
- `lib/l10n/app_sa.arb`
- `lib/l10n/app_message_text.dart`
- `lib/services/url_safety_service.dart`
- `lib/screens/settings_screen.dart`
- `test/screens/settings_screen_test.dart`
- `test/services/url_safety_service_test.dart`

## Verification

- `flutter gen-l10n` ran successfully with tri-lingual key parity.
- `flutter analyze` passed with 0 warnings and 0 errors.
- `flutter test` passed all 362 unit and widget tests.
- `dart format .` applied cleanly.
