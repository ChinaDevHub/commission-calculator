import 'package:commission_calculator/features/commission/domain/usecases/calculate_commission_totals_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/commission_fixtures.dart';

void main() {
  const useCase = CalculateCommissionTotalsUseCase();

  test('sums the sample commissions per currency with its precision', () {
    final results = buildCalculator()
        .calculate(sampleTransactions, testRates)
        .right;

    expect(useCase(results), expectedSampleTotals);
  });

  test('returns no totals when there are no results', () {
    expect(useCase([]), isEmpty);
  });
}
