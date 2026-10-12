# Implementation Plan — SreerajP QR Studio

This document outlines the phase-by-phase build roadmap and implementation targets for SreerajP QR Studio. Read this to understand current development objectives.

**Date:** 2026-07-31 (status updated 2026-10-10)

> This is the early build roadmap, kept as history. For what the app does
> today see [features.md](features.md); for later work see the dated files in
> `plans/` and `change_log/`.

**Read first:**
- [CLAUDE.md](../CLAUDE.md)
- [architecture.md](architecture.md)
- [workflow_rules.md](workflow_rules.md)

---

## 1. Phase 1: Core Scanning and URL Safety Engine (Completed)

- **Objective:** Build robust QR/barcode scanner with multi-heuristic URL safety verification.
- **Action Steps:**
  - Implement camera scanning in `ScannerScreen` (first with `mobile_scanner`; replaced on 2026-09-28 by the app's own zxing-cpp decoder — see `change_log/20260928_120846_replace_mlkit_with_own_zxing_decoder.md`).
  - Implement 6-layer URL safety engine in `UrlSafetyService` (SSL, Redirects, Phishing, Shorteners, Homographs, Google Safe Browsing).
  - Implement `ScanProvider` state management using Provider.
  - Implement secure storage for Google Safe Browsing API key via `flutter_secure_storage`.

---

## 2. Phase 2: Standards & Guidelines Compliance (Completed)

- **Objective:** Align application documentation, structure, and configuration strictly with shared Flutter Guidelines.
- **Action Steps:**
  - Add `docs/guidelines` submodule (`https://github.com/sreerajp80/Flutter_Guidelines`).
  - Create complete baseline doc suite (`workflow_rules.md`, `dependencies.md`, `project_structure.md`, `architecture.md`, `security.md`, `release_process.md`, `implementation_plan.md`, `implementation_progress.md`).
  - Update root `CLAUDE.md` to follow Thin profile canonical section order.
  - Standardize build flavor configurations (`dev` and `prod`).

---

## 3. Phase 3: Testing & UI Refinement (Completed)

- **Objective:** Expand test coverage and refine Material Design 3 user experience.
- **Action Steps:**
  - Add widget tests for `ScannerScreen`, `ResultScreen`, and `SettingsScreen` (done; every top-level screen has a widget test since 2026-10-10).
  - Implement scan history screen (done: encrypted history with search, filters, export and backup).
  - Enhance visual feedback and accessibility semantics.
