import 'package:commission_calculator/core/di/locator.dart';
import 'package:commission_calculator/features/commission/domain/usecases/calculate_commission_totals_usecase.dart';
import 'package:commission_calculator/features/commission/domain/usecases/calculate_commissions_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/commission_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(setupLocator);
  tearDown(locator.reset);

  test(
    'bundled transactions.json yields the 12 expected commissions',
    () async {
      final results = (await locator<CalculateCommissionsUseCase>()()).right;
      final totals = locator<CalculateCommissionTotalsUseCase>()(results);

      expect(commissionsOf(results), expectedSampleCommissions);
      expect(totals, expectedSampleTotals);
    },
  );
}
