import 'package:commission_calculator/core/enums/commission_explanation_type.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:decimal/decimal.dart';

class CommissionResult {
  const CommissionResult({
    required this.transaction,
    required this.amountInEur,
    required this.freeAllowanceUsedEur,
    required this.freeAmountInTxCurrency,
    required this.chargedAmountInTxCurrency,
    required this.feeRate,
    required this.rawCommission,
    required this.finalCommission,
    required this.explanation,
  });

  final Transaction transaction;
  final Decimal amountInEur;
  final Decimal freeAllowanceUsedEur;
  final Decimal freeAmountInTxCurrency;
  final Decimal chargedAmountInTxCurrency;
  final Decimal feeRate;
  final Decimal rawCommission;
  final Decimal finalCommission;
  final CommissionExplanation explanation;
}
