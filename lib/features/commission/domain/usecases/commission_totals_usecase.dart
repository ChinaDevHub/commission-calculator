import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:decimal/decimal.dart';

class CommissionTotalsUseCase {
  const CommissionTotalsUseCase();

  Map<String, Decimal> call(List<CommissionResult> results) {
    final totals = <String, Decimal>{};
    for (final result in results) {
      totals.update(
        result.transaction.currency,
        (total) => total + result.finalCommission,
        ifAbsent: () => result.finalCommission,
      );
    }
    return totals;
  }
}
