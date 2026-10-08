# 💸 Commission Calculator

A Flutter app that loads a list of financial transactions, calculates the commission of each one with the weekly-allowance rules from the task, and explains every calculation step by step.

| Transactions (dark) | Details (dark) | Transactions (light) | Details (light) |
| :---: | :---: | :---: | :---: |
| <img src="docs/screenshots/list-dark.png" width="200"> | <img src="docs/screenshots/details-dark.png" width="200"> | <img src="docs/screenshots/list-light.png" width="200"> | <img src="docs/screenshots/details-light.png" width="200"> |

**Demo recordings:** [iOS (28 s)](docs/media/ios-demo.mp4) · [Android (27 s)](docs/media/android-demo.mp4)
**Release APK:** attached to the [GitHub release](../../releases) (`app-release.apk`).

---

## ✅ What is implemented

**Required**
- **Transactions screen** — the bundled `assets/data/transactions.json` with date, user, user type, operation type, amount and commission per row.
- **Summary** — total commission per currency in the header card.
- **Transaction details** — EUR equivalent and applied exchange rate, free allowance applied, weekly allowance left, charged amount, rate, raw and rounded commission, plus a one-line explanation of the rule that applied.
- **States** — shimmer loading, empty and error states. Malformed JSON, unknown currency, negative amount and invalid dates end in a readable error (`Transaction #3: invalid date "2025-02-30"`) with a retry button — never a crash or a red screen.
- **Tests** — all 12 sample results plus focused edge cases (see [Running tests](#-running-tests)).

**Bonus**
- Light / dark theme with an animated toggle; follows the system until changed, and the choice is persisted.
- Widget tests for the list, the details screen, the error state and the theme toggle.
- GitHub Actions pipeline: format check, `flutter analyze`, `flutter test`.

Not done: file-picker import (the domain and data layers already accept raw JSON, only the UI is missing), filters, localization.

---

## 🚀 Setup & run

Requirements: Flutter **stable 3.44+** (Dart `^3.12.2`), plus a current Xcode for iOS (deployment target 15.0) or the Android SDK.

```bash
flutter pub get
flutter run
```

Release APK:

```bash
flutter build apk --release
# → build/app/outputs/flutter-apk/app-release.apk
```

---

## 🧪 Running tests

```bash
flutter test
flutter analyze
```

81 tests, `flutter analyze` reports no issues. The most relevant ones:

| Test | What it proves |
| --- | --- |
| `test/features/commission/sample_input_test.dart` | Runs the bundled JSON through the real DI graph and asserts all 12 expected commissions and the per-currency totals. |
| `test/features/commission/domain/rules/commission_calculator_test.dart` | The 12 sample results plus edge cases: week across New Year, 4th withdrawal with allowance left, charging only the excess, rounding up, per-user allowance, one allowance shared across currencies, injected config. |
| `test/features/commission/data/…` | Parsing and validation of malformed JSON, missing fields, invalid dates, non-string amounts. |
| `test/features/commission/presentation/cubits/transactions_cubit_test.dart` | Loading → success / empty / error, no emit after close. |
| `test/features/commission/presentation/pages/transactions_page_test.dart` | Widget tests: the list shows commissions, tapping a row opens the breakdown, invalid input shows the error and retry works. |
| `test/core/theme/…` | Theme cubit (system / light / dark, persistence) and the toggle switching the whole app. |
| `test/architecture/domain_purity_test.dart` | The domain imports nothing from Flutter, data or presentation. |

---

## 🏛 Architecture

Feature-first Clean Architecture. Dependencies point inwards: `presentation → domain ← data`.

```
lib/
├── core/
│   ├── constants/      # design tokens: colors, typography, spacing, icons, strings
│   ├── di/             # get_it root
│   ├── enums/ errors/  # shared enums, exceptions → failures mapping
│   ├── extensions/     # Decimal / date / enum formatting for the UI
│   ├── navigation/     # fade-slide route used after the splash
│   └── theme/          # AppTheme, AppPalette (ThemeExtension), ThemeCubit, toggle
└── features/
    ├── commission/
    │   ├── data/           # JSON parser, models, local data sources, repository impls
    │   ├── domain/         # pure Dart: entities, repository contracts, rules, use cases
    │   ├── presentation/   # cubits/, pages/ (≤ 40 lines each), widgets/
    │   └── commission_locator.dart
    └── splash/
```


## ⏱ Time spent

Approximately **6 hours**.

---

## 🤖 AI & Development Tools

Modern AI-assisted workflows were utilized during development:
- **Gemini & Grok**: Used for technical research, architecture pattern comparisons (Feature-First & Clean Architecture), and edge-case validation.
- **Claude Code**: Used as an IDE assistant for code suggestions, pair-programming, and refactoring.
