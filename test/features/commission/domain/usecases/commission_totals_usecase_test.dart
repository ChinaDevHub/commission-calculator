import 'package:commission_calculator/core/enums/commission_explanation_type.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/usecases/commission_totals_usecase.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/commission_fixtures.dart';

void main() {
  const useCase = CommissionTotalsUseCase();

  CommissionResult resultIn(String currency, String commission) =>
      CommissionResult(
        transaction: tx('2025-01-06', '1', currency: currency),
        amountInEur: Decimal.zero,
        freeAllowanceUsedEur: Decimal.zero,
        freeAmountInTxCurrency: Decimal.zero,
        chargedAmountInTxCurrency: Decimal.zero,
        feeRate: Decimal.zero,
        rawCommission: Decimal.zero,
        finalCommission: d(commission),
        explanation: CommissionExplanation.deposit,
      );

  test('sums the sample commissions per currency', () {
    final sampleCommissions = [
      ('EUR', '0.00'),
      ('EUR', '0.06'),
      ('JPY', '53'),
      ('USD', '0.00'),
      ('EUR', '0.37'),
      ('EUR', '1.50'),
      ('USD', '0.30'),
      ('EUR', '0.30'),
      ('AZN', '0.00'),
      ('USD', '0.00'),
      ('EUR', '0.01'),
      ('JPY', '3'),
    ];

    expect(
      useCase([
        for (final (currency, commission) in sampleCommissions)
          resultIn(currency, commission),
      ]),
      {'EUR': d('2.24'), 'JPY': d('56'), 'USD': d('0.30'), 'AZN': d('0')},
    );
  });

  test('returns no totals when there are no results', () {
    expect(useCase([]), isEmpty);
  });
}
