import 'package:commission_calculator/core/constants/app_commissions.dart';
import 'package:commission_calculator/core/enums/commission_explanation_type.dart';
import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_rule.dart';
import 'package:decimal/decimal.dart';

class PrivateWithdrawRule extends CommissionRule {
  PrivateWithdrawRule()
    : super(Decimal.parse(AppCommissions.privateWithdrawRate)); // 0.3%

  static final _weeklyFreeAllowanceEur = Decimal.fromInt(1000);
  static const _weeklyFreeWithdrawals = 3;

  @override
  CommissionResult calculate(
    Transaction transaction,
    ExchangeRate rate,
    List<CommissionResult> history,
  ) {
    final sameWeek = history
        .where((previous) => _isSameWeekPrivateWithdraw(previous, transaction))
        .toList();

    if (sameWeek.length >= _weeklyFreeWithdrawals) {
      return _chargeFullAmount(
        transaction,
        rate,
        CommissionExplanation.privateWithdrawFreeCountExceeded,
      );
    }

    final usedEur = sameWeek.fold(
      Decimal.zero,
      (sum, previous) => sum + previous.freeAllowanceUsedEur,
    );
    final remainingEur = _weeklyFreeAllowanceEur - usedEur;

    if (remainingEur <= Decimal.zero) {
      return _chargeFullAmount(
        transaction,
        rate,
        CommissionExplanation.privateWithdrawAllowanceExhausted,
      );
    }

    final remainingInTxCurrency = remainingEur * rate.rateToEur;

    if (transaction.amount <= remainingInTxCurrency) {
      return buildResult(
        transaction,
        rate,
        chargedAmount: Decimal.zero,
        freeAllowanceUsedEur: toEur(transaction.amount, rate),
        explanation: CommissionExplanation.privateWithdrawFree,
      );
    }

    return buildResult(
      transaction,
      rate,
      chargedAmount: transaction.amount - remainingInTxCurrency,
      freeAllowanceUsedEur: remainingEur,
      explanation: CommissionExplanation.privateWithdrawAllowanceExceeded,
    );
  }

  CommissionResult _chargeFullAmount(
    Transaction transaction,
    ExchangeRate rate,
    CommissionExplanation explanation,
  ) => buildResult(
    transaction,
    rate,
    chargedAmount: transaction.amount,
    explanation: explanation,
  );

  bool _isSameWeekPrivateWithdraw(
    CommissionResult previous,
    Transaction current,
  ) {
    final transaction = previous.transaction;
    return transaction.userId == current.userId &&
        transaction.userType == UserType.private &&
        transaction.operationType == OperationType.withdraw &&
        _mondayOf(transaction.date) == _mondayOf(current.date);
  }

  DateTime _mondayOf(DateTime date) => DateTime.utc(
    date.year,
    date.month,
    date.day - (date.weekday - DateTime.monday),
  );
}
