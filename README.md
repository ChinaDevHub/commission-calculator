# 💸 Commission Calculator Application

A high-precision, production-ready Flutter application built to calculate financial transaction commissions based on complex business rules, multi-currency operations, and weekly limits.

---

## 🎯 Overview

This application processes financial transactions (Deposits and Withdrawals) and calculates respective commission fees according to specific tier rules for **Private** and **Business** clients. 

### Key Highlights
- **Financial Precision:** Strict avoidance of floating-point inaccuracies (`double`) by utilizing `Decimal` arithmetic.
- **Pure Domain Architecture:** Zero framework dependency (`Flutter/UI`) inside the Core Domain layer.
- **Modular Architecture:** Layered using **Feature-First Clean Architecture** principles.
- **CI/CD Pipeline:** Automated code formatting, linting, analysis, and test suites execution using GitHub Actions.

---

## 🛠 Tech Stack & Architecture

- **Language:** Dart / Flutter (`Stable Channel`)
- **State Management:** Flutter BLoC / Cubit
- **Dependency Injection:** GetIt
- **Architecture:** Feature-First Clean Architecture (Domain, Data, Presentation)
- **Math Precision:** `decimal` package
- **Testing:** Unit Tests with `flutter_test` & `mocktail`
- **Typography:** Inter (Tabular figures suited for financial data)

---

## 📐 Business Logic Summary

1. **Deposit:** Fixed commission fee of **0.03%**.
2. **Business Withdrawal:** Fixed commission fee of **0.5%**.
3. **Private Withdrawal:** 
   - **0.3%** commission applied after exceeding the weekly free limit (**1,000.00 EUR** or equivalent).
   - Maximum **3 free operations** per week (Monday to Sunday).
   - Exceeded counts trigger commission regardless of remaining amount limit.
4. **Rounding Rule:** Commission amounts are strictly rounded up (**Ceiling**) to match currency decimals.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (stable channel, Dart `^3.12.2`)

### Setup & Run
```bash
flutter pub get
flutter run
```

---

## 🧪 Running Tests

```bash
flutter test
```

- `test/features/commission/sample_input_test.dart` — runs the bundled `transactions.json` through the real DI graph and asserts all 12 expected commissions and the per-currency totals.
- `test/features/commission/domain/rules/commission_calculator_test.dart` — the 12 sample results plus edge cases: week across New Year, 4th withdrawal, partial allowance, rounding up, per-user allowance, multi-currency allowance, injected config.
- `test/architecture/domain_purity_test.dart` — guards that the domain imports nothing from Flutter, data or presentation.

---

## 🏛 Architecture Overview

Feature-first Clean Architecture. Dependencies point inwards: `presentation → domain ← data`.

```
lib/
├── core/                        # shared: DI, enums, errors, constants
└── features/commission/
    ├── data/                    # JSON parsing, models, data sources, repository implementations
    ├── domain/                  # pure Dart: entities, repositories, rules, use cases
    ├── presentation/
    └── commission_locator.dart  # feature DI
```

- **Domain** — `CommissionCalculator` applies one `CommissionRule` per transaction (`DepositRule`, `BusinessWithdrawRule`, `PrivateWithdrawRule`). Rates and limits live in an injected `CommissionConfig`, so changing them needs no rule changes. `TransactionValidator` enforces the input preconditions whatever the source.
- **Data** — `TransactionRepository` and `ExchangeRateRepository` are implemented over local data sources; a remote API can replace a data source without touching the domain or UI. Data exceptions are mapped to domain `Failure`s in one place (`exception_mapper.dart`).
- **DI** — `get_it`. Each feature registers itself from `core/di/locator.dart`; services are lazy singletons, cubits are factories.

---

## 📌 Assumptions

- A week runs Monday–Sunday by calendar date and may span two years.
- `Decimal` cannot represent conversions such as `50000 / 162.40` exactly, so EUR equivalents keep 20 fractional digits; only the final commission is rounded (ceiling) to the currency precision.
- Input must be sorted by date ascending; unsorted input is rejected with a readable error instead of being re-sorted.
- Amounts must be JSON strings; numeric or negative amounts are rejected, zero is allowed.
- Currency codes are case-sensitive and must match a known rate (`EUR`, `USD`, `JPY`, `AZN`).
- Only private withdrawals of the same user use the weekly allowance; deposits and business withdrawals never do.
- Validation stops at the first invalid transaction and names its position (`Transaction #N: …`).
- The sample input is bundled at `assets/data/transactions.json` (assets are grouped by type).
