# Project Profile — SreerajP QR Studio

This file records the choices the shared guidelines leave open for this app: identity,
applicability profiles, platforms, stores, languages and About options. Every rule that depends
on a platform, store or language applies **only** to what this file declares (engineering
standard §1.2.1). Read it before writing code.

Read first: [../CLAUDE.md](../CLAUDE.md) / [../AGENTS.md](../AGENTS.md). Template:
[guidelines/PROJECT_PROFILE_TEMPLATE.md](guidelines/PROJECT_PROFILE_TEMPLATE.md).

> **Privacy:** this file is committed and public. It holds only public information. Never put
> passwords, keys or keystore details here.

---

## 0. Product brief

| Item | Value |
|---|---|
| What the app does | A privacy-first QR and barcode scanner with link safety checks (one line in §1) |
| Main features | Scanner with 6-layer link safety; QuishingGuard fake-sticker reminders; StegoQR hidden content; smart actions (Wi-Fi, contacts, payments, 2FA); encrypted scan history; AR CodeVision; AirQR optical transfer; CodeForge generator; GhostScan and Scan bubble |
| Who uses it | Anyone who scans QR codes and barcodes on an Android phone |
| Out of scope for now | Other platforms; user accounts; cloud sync |

### 0.1 Data and privacy

Every app follows the Security Baseline (engineering standard §15.1) whatever the answers are.
If you are not sure whether some data is sensitive, treat it as sensitive.

| Item | Value |
|---|---|
| Works offline / needs the network | Both — offline by default; optional online link checks the user turns on |
| Backend or third-party API | No own backend. Optional: Google Safe Browsing, VirusTotal, URLhaus, PhishTank, OpenPhish |
| User accounts / sign-in | None |
| Data the app stores, and where | Scan history (encrypted), settings, user API keys — device only |
| Personal, health, finance or secret data | Scanned content can hold personal data, Wi-Fi passwords, payment links and 2FA seeds; StegoQR secrets; user API keys — Sensitive Data Extension applies |
| Analytics | None |
| Crash reporting | None |
| Ads | None |
| Other third-party SDKs that send data | None (listed in `docs/security.md` §4) |
| In-app purchases or subscriptions | None |
| Device permissions | Listed with reasons in `docs/security.md` §11 |

---

## 1. Identity

| Item | Value |
|---|---|
| App display name | `SreerajP QR Studio` (dev flavor: `SreerajP QR Studio Dev`). Comes from `appName` in `assets/config/app_config.json`; the Android launcher names in each `values-<code>/strings.xml` match it (`guideline.md` §1.8) |
| Short description (one line) | `A privacy-first QR/barcode scanner with link safety checks, fake-sticker reminders, StegoQR, AR CodeVision, and offline smart tools` |
| Organization / publisher | `Sreeraj P` |
| Reverse-DNS app id | `in.sreerajp.qr_studio` — permanent once published (dev flavor adds `.dev`) |
| Dart package name (`pubspec.yaml` `name`) | `sreerajp_qr_studio` |
| Public support contact | `sreerajp@zohomail.in` (the address already shown on the About screen) |
| Website | `https://github.com/sreerajp80/sreerajp_qr_studio` |
| Privacy policy URL | `https://github.com/sreerajp80/sreerajp_qr_studio/blob/main/PRIVACY_POLICY.md` — the same URL in `app_config.json` (`privacyPolicy`) and the Play Console (`platform_store_readiness.md` §1) |
| Copyright line | `© 2026 Sreeraj P` |
| License of the app's own code | `MIT` (see [../LICENSE](../LICENSE)) |

---

## 2. Applicability profiles (engineering standard §1.2)

- [x] `Core Baseline` (always)
- [x] `Production App Extension` — shipped to real users and stores
- [x] `Sensitive Data Extension` — encrypted scan history, StegoQR encrypted payloads, and the
      optional Safe Browsing API key in secure storage

---

## 3. Target platforms and distribution

Only Android is declared. Do not create or edit other platform folders. For every ticked
channel, the matching gate in
[guidelines/platform_store_readiness.md](guidelines/platform_store_readiness.md) MUST pass before
the first release to it.

| Platform | Ship? | Minimum OS | Distribution channels |
|---|---|---|---|
| Android | yes | `minSdk 24` (wide device reach; camera and the FFI barcode decoder work there). `targetSdk 36`, `compileSdk 37` | Google Play (`.aab`); direct download (split APKs, `--split-per-abi`) |
| iOS | no | — | — |
| Windows | no | — | — |
| macOS | no | — | — |
| Linux | no | — | — |
| Web | no | — | — |

Build flavors: `dev + prod` (engineering standard §5.1).

---

## 4. Languages (engineering standard §8)

| Locale | Language | Script | Role | Language pack |
|---|---|---|---|---|
| `en` | English | Latin | Template ARB, ultimate fallback | — |
| `ml` | Malayalam | Malayalam | Full UI translation | [guidelines/language_packs/sanskrit_malayalam.md](guidelines/language_packs/sanskrit_malayalam.md) |
| `sa` | Sanskrit | Devanagari | Full UI translation | [guidelines/language_packs/sanskrit_malayalam.md](guidelines/language_packs/sanskrit_malayalam.md) |

- In-app language picker: required (3 languages). Options: System default, then the endonyms
  `English`, `മലയാളം`, `संस्कृतम्`.
- Languages without a Flutter framework translation (need the fallback delegate, §8.3.1): `sa`.
- Store-listing languages: Google Play `en-US` and `ml-IN`. Sanskrit is not a Google Play
  listing language, so it ships inside the app only.
- Native-reader review: a fluent Malayalam reader and a fluent Sanskrit reader before each
  release.

---

## 5. About screen (`guideline.md` §1)

| Item | Value |
|---|---|
| `details` rows to show | `author`, `email`, `privacyPolicy`, `license`, `aiUsed`, `ideUsed` |
| Signature badge (§1.7) | **on** |
| Badge text — English | `Made with {heart} from India` |
| Badge text — Malayalam and Sanskrit | As in `madeWithLove` in `lib/l10n/app_ml.arb` and `lib/l10n/app_sa.arb` |
| Badge screen-reader text | `madeWithLoveA11y` in each ARB file |

---

## 6. Optional project-specific values

| Item | Value |
|---|---|
| App size budget override (§10.7) | default |
| State management | Provider (`ChangeNotifier`) |
| Structure tier (§3.1) | Tier 1 layer-first |
| Release owner (role) | app maintainer |

---

## 7. Tools and workflow

| Item | Value |
|---|---|
| AI agents used on the project | Claude Code, Gemini, ChatGPT — instruction files `CLAUDE.md` and `AGENTS.md` |
| IDE | VS Code, Gemini Antigravity IDE |
| Can build iOS / macOS locally | Not needed (Android only) |
| Git hosting | GitHub |
| CI checks | GitHub CI — format, analyze and test only (required on GitHub, engineering standard §19), plus Dependabot |
| Release owner (role) | app maintainer |
