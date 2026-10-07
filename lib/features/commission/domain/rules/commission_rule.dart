import 'package:commission_calculator/core/enums/commission_explanation_type.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:decimal/decimal.dart';

abstract class CommissionRule {
  CommissionRule(this.feeRate);

  final Decimal feeRate;

  CommissionResult calculate(
    Transaction transaction,
    ExchangeRate rate,
    List<CommissionResult> history,
  );

  CommissionResult buildResult(
    Transaction transaction,
    ExchangeRate rate, {
    required Decimal chargedAmount,
    required CommissionExplanation explanation,
    Decimal? freeAllowanceUsedEur,
  }) {
    final rawCommission = chargedAmount * feeRate;
    return CommissionResult(
      transaction: transaction,
      amountInEur: toEur(transaction.amount, rate),
      freeAllowanceUsedEur: freeAllowanceUsedEur ?? Decimal.zero,
      freeAmountInTxCurrency: transaction.amount - chargedAmount,
      chargedAmountInTxCurrency: chargedAmount,
      feeRate: feeRate,
      rawCommission: rawCommission,
      finalCommission: rawCommission.ceil(scale: rate.precision),
      explanation: explanation,
    );
  }

  Decimal toEur(Decimal amount, ExchangeRate rate) =>
      (amount / rate.rateToEur).toDecimal(scaleOnInfinitePrecision: 20);
}
