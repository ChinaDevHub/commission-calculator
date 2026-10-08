import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_total.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_config.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_calculator.dart';
import 'package:commission_calculator/features/commission/domain/rules/transaction_validator.dart';
import 'package:decimal/decimal.dart';

Decimal d(String value) => Decimal.parse(value);

final testRates = [
  ExchangeRate(currency: 'EUR', rateToEur: d('1.0000'), precision: 2),
  ExchangeRate(currency: 'USD', rateToEur: d('1.0850'), precision: 2),
  ExchangeRate(currency: 'JPY', rateToEur: d('162.40'), precision: 0),
  ExchangeRate(currency: 'AZN', rateToEur: d('1.9350'), precision: 2),
];

CommissionCalculator buildCalculator([CommissionConfig? config]) =>
    CommissionCalculator(
      config ?? CommissionConfig.standard(),
      const TransactionValidator(),
    );

Transaction tx(
  String date,
  String amount, {
  String currency = 'EUR',
  int userId = 1,
  UserType userType = UserType.private,
  OperationType operationType = OperationType.withdraw,
}) => Transaction(
  date: DateTime.parse(date),
  userId: userId,
  userType: userType,
  operationType: operationType,
  amount: d(amount),
  currency: currency,
);

final sampleTransactions = [
  tx('2024-12-30', '800.00'),
  tx('2024-12-31', '200.00', operationType: OperationType.deposit),
  tx('2025-01-02', '50000', currency: 'JPY'),
  tx('2025-01-03', '1000.00', currency: 'USD', userId: 2),
  tx('2025-01-04', '200.00', userId: 2),
  tx('2025-01-04', '300.00', userId: 3, userType: UserType.business),
  tx('2025-01-05', '100.00', currency: 'USD'),
  tx('2025-01-05', '100.00'),
  tx('2025-01-06', '500.00', currency: 'AZN'),
  tx('2025-01-07', '300.00', currency: 'USD', userId: 2),
  tx('2025-01-08', '1.00', operationType: OperationType.deposit),
  tx(
    '2025-01-08',
    '10000',
    currency: 'JPY',
    userId: 3,
    userType: UserType.business,
    operationType: OperationType.deposit,
  ),
];

final expectedSampleCommissions = [
  (d('0.00'), 'EUR'),
  (d('0.06'), 'EUR'),
  (d('53'), 'JPY'),
  (d('0.00'), 'USD'),
  (d('0.37'), 'EUR'),
  (d('1.50'), 'EUR'),
  (d('0.30'), 'USD'),
  (d('0.30'), 'EUR'),
  (d('0.00'), 'AZN'),
  (d('0.00'), 'USD'),
  (d('0.01'), 'EUR'),
  (d('3'), 'JPY'),
];

final expectedSampleTotals = [
  CommissionTotal(currency: 'EUR', precision: 2, amount: d('2.24')),
  CommissionTotal(currency: 'JPY', precision: 0, amount: d('56')),
  CommissionTotal(currency: 'USD', precision: 2, amount: d('0.30')),
  CommissionTotal(currency: 'AZN', precision: 2, amount: d('0')),
];

List<(Decimal, String)> commissionsOf(List<CommissionResult> results) => [
  for (final result in results) (result.commission, result.currency),
];
