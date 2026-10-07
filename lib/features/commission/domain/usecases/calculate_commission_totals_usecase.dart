import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_total.dart';
import 'package:decimal/decimal.dart';

class CalculateCommissionTotalsUseCase {
  const CalculateCommissionTotalsUseCase();

  List<CommissionTotal> call(List<CommissionResult> results) {
    final totals = <String, CommissionTotal>{};
    for (final result in results) {
      final currency = result.currency;
      totals[currency] = CommissionTotal(
        currency: currency,
        precision: result.exchangeRate.precision,
        amount: (totals[currency]?.amount ?? Decimal.zero) + result.commission,
      );
    }
    return totals.values.toList();
  }
}
