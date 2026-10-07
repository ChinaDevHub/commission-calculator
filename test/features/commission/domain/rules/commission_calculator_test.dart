import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/core/enums/commission_explanation.dart';
import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_config.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/commission_fixtures.dart';

void main() {
  final calculator = buildCalculator();

  List<CommissionResult> calculate(List<Transaction> transactions) =>
      calculator.calculate(transactions, testRates).right;

  List<Decimal> fees(List<Transaction> transactions) => [
    for (final result in calculate(transactions)) result.commission,
  ];

  test('matches all 12 expected results of the sample input', () {
    expect(
      commissionsOf(calculate(sampleTransactions)),
      expectedSampleCommissions,
    );
  });

  test('result explains every step of the calculation', () {
    final [_, result] = calculate([
      tx('2024-12-30', '800.00'),
      tx('2025-01-02', '50000', currency: 'JPY'),
    ]);

    expect(result.amountInEur.round(scale: 2), d('307.88'));
    expect(result.freeAmountInEur, d('200'));
    expect(result.freeAmount, d('32480'));
    expect(result.chargedAmount, d('17520'));
    expect(result.feeRate, d('0.003'));
    expect(result.rawCommission, d('52.56'));
    expect(result.commission, d('53'));
    expect(
      result.explanation,
      CommissionExplanation.privateWithdrawAllowanceExceeded,
    );
  });

  group('edge cases', () {
    test('a week spanning New Year is one Monday–Sunday week', () {
      expect(
        fees([
          tx('2024-12-30', '1000.00'),
          tx('2025-01-05', '100.00'),
          tx('2025-01-06', '100.00'),
        ]),
        [d('0'), d('0.30'), d('0')],
      );
    });

    test('the 4th withdrawal is charged even with allowance left', () {
      final results = calculate([
        for (var day = 6; day <= 9; day++) tx('2025-01-0$day', '100.00'),
      ]);

      expect(commissionsOf(results).last, (d('0.30'), 'EUR'));
      expect(
        results.last.explanation,
        CommissionExplanation.privateWithdrawFreeCountExceeded,
      );
    });

    test('only the part above the allowance is charged', () {
      expect(fees([tx('2025-01-06', '1200.00')]), [d('0.60')]);
    });

    test('commission is rounded up to the currency precision', () {
      expect(
        fees([
          tx('2025-01-06', '1.00', operationType: OperationType.deposit),
          tx(
            '2025-01-06',
            '175200',
            currency: 'JPY',
            operationType: OperationType.deposit,
          ),
        ]),
        [d('0.01'), d('53')],
      );
    });

    test('each user has their own weekly allowance', () {
      expect(
        fees([
          tx('2025-01-06', '1000.00'),
          tx('2025-01-06', '1000.00', userId: 2),
        ]),
        [d('0'), d('0')],
      );
    });

    test('deposits and business withdrawals do not use the allowance', () {
      expect(
        fees([
          tx('2025-01-06', '5000.00', operationType: OperationType.deposit),
          tx('2025-01-06', '100.00', userType: UserType.business),
          tx('2025-01-07', '1000.00'),
        ]),
        [d('1.50'), d('0.50'), d('0')],
      );
    });

    test('withdrawals in different currencies share one allowance', () {
      final results = calculate([
        tx('2025-01-06', '81200', currency: 'JPY'),
        tx('2025-01-07', '542.50', currency: 'USD'),
        tx('2025-01-08', '100.00'),
      ]);

      expect(commissionsOf(results), [
        (d('0'), 'JPY'),
        (d('0'), 'USD'),
        (d('0.30'), 'EUR'),
      ]);
      expect(
        results.last.explanation,
        CommissionExplanation.privateWithdrawAllowanceExhausted,
      );
    });
  });

  test('rates and limits come from the injected config', () {
    final config = CommissionConfig(
      depositRate: d('0.001'),
      privateWithdrawRate: d('0.01'),
      businessWithdrawRate: d('0.02'),
      weeklyFreeAllowanceEur: d('500.00'),
      weeklyFreeWithdrawals: 1,
    );

    final results = buildCalculator(config).calculate([
      tx('2025-01-06', '600.00'),
      tx('2025-01-07', '100.00'),
      tx('2025-01-07', '100.00', operationType: OperationType.deposit),
      tx('2025-01-07', '100.00', userType: UserType.business, userId: 2),
    ], testRates).right;

    expect(
      [for (final result in results) result.commission],
      [d('1.00'), d('1.00'), d('0.10'), d('2.00')],
    );
  });

  test('returns the validation failure instead of calculating', () {
    expect(
      calculator.calculate([
        tx('2025-01-06', '10.00', currency: 'GBP'),
      ], testRates).left,
      isA<UnsupportedCurrencyFailure>(),
    );
  });
}
