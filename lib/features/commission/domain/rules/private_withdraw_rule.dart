import 'package:commission_calculator/core/enums/commission_explanation.dart';
import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_config.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_rule.dart';
import 'package:decimal/decimal.dart';

class PrivateWithdrawRule extends CommissionRule {
  PrivateWithdrawRule(CommissionConfig config)
    : _weeklyAllowanceEur = config.weeklyFreeAllowanceEur,
      _weeklyFreeWithdrawals = config.weeklyFreeWithdrawals,
      super(config.privateWithdrawRate);

  final Decimal _weeklyAllowanceEur;
  final int _weeklyFreeWithdrawals;

  @override
  CommissionResult calculate(
    Transaction transaction,
    ExchangeRate exchangeRate,
    List<CommissionResult> history,
  ) {
    final sameWeek = history
        .where((previous) => _isSameWeek(previous.transaction, transaction))
        .toList();

    final usedEur = sameWeek.fold(
      Decimal.zero,
      (sum, previous) => sum + previous.freeAmountInEur,
    );
    final remainingEur = _weeklyAllowanceEur - usedEur;

    if (sameWeek.length >= _weeklyFreeWithdrawals) {
      return buildResult(
        transaction,
        exchangeRate,
        allowanceLeftEur: remainingEur,
        explanation: CommissionExplanation.privateWithdrawFreeCountExceeded,
      );
    }

    if (remainingEur <= Decimal.zero) {
      return buildResult(
        transaction,
        exchangeRate,
        allowanceLeftEur: Decimal.zero,
        explanation: CommissionExplanation.privateWithdrawAllowanceExhausted,
      );
    }

    final amountInEur = exchangeRate.toEur(transaction.amount);
    final fitsAllowance = amountInEur <= remainingEur;

    return buildResult(
      transaction,
      exchangeRate,
      freeAmount: fitsAllowance
          ? transaction.amount
          : exchangeRate.fromEur(remainingEur),
      allowanceLeftEur: fitsAllowance
          ? remainingEur - amountInEur
          : Decimal.zero,
      explanation: fitsAllowance
          ? CommissionExplanation.privateWithdrawFree
          : CommissionExplanation.privateWithdrawAllowanceExceeded,
    );
  }

  bool _isSameWeek(Transaction previous, Transaction current) =>
      previous.userId == current.userId &&
      previous.userType == UserType.private &&
      previous.operationType == OperationType.withdraw &&
      _mondayOf(previous.date) == _mondayOf(current.date);

  DateTime _mondayOf(DateTime date) => DateTime.utc(
    date.year,
    date.month,
    date.day - (date.weekday - DateTime.monday),
  );
}
