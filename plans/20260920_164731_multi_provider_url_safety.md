# Plan: Multi-Provider URL Safety Integration

**Status:** Implemented

**Slug:** `20260920_164731_multi_provider_url_safety`

## Problem

The app only supports Google Safe Browsing as an optional URL safety check. Users who want broader coverage have no way to add more providers.

## Fix

Add four new free URL safety providers:

- **VirusTotal** (user-supplied key, non-commercial)
- **URLhaus / abuse.ch** (user-supplied key, non-commercial)
- **PhishTank** (built-in toggle, commercial-OK)
- **OpenPhish** (built-in toggle, offline-capable, commercial-OK)

Replace `SafeBrowsingSettingsScreen` with `UrlSafetyProvidersScreen` split into:

- **Your API Keys** — user signs up and enters personal key + optional custom endpoint URL
- **Built-In Providers** — simple on/off toggle, no account needed

## Files Changed

- `lib/models/app_message.dart`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ml.arb`
- `lib/l10n/app_sa.arb`
- `lib/l10n/app_message_text.dart`
- `lib/services/url_safety_service.dart`
- `lib/screens/settings_screen.dart`
- `test/services/url_safety_service_test.dart`
