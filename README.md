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
Ensure Flutter SDK is installed on your environment.

### Installation

1. Clone the repository:
   ```bash
   git clone [https://github.com/YOUR_USERNAME/commission_calculator.git](https://github.com/YOUR_USERNAME/commission_calculator.git)