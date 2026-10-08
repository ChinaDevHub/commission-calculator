import 'package:commission_calculator/core/enums/commission_explanation.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:decimal/decimal.dart';

abstract class CommissionRule {
  const CommissionRule(this.feeRate);

  final Decimal feeRate;

  CommissionResult calculate(
    Transaction transaction,
    ExchangeRate exchangeRate,
    List<CommissionResult> history,
  );

  CommissionResult buildResult(
    Transaction transaction,
    ExchangeRate exchangeRate, {
    required CommissionExplanation explanation,
    Decimal? freeAmount,
    Decimal? allowanceLeftEur,
  }) => CommissionResult(
    transaction: transaction,
    exchangeRate: exchangeRate,
    feeRate: feeRate,
    freeAmount: freeAmount ?? Decimal.zero,
    explanation: explanation,
    allowanceLeftEur: allowanceLeftEur,
  );
}
