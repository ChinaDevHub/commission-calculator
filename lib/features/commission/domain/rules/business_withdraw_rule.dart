import 'package:commission_calculator/core/constants/app_commissions.dart';
import 'package:commission_calculator/core/enums/commission_explanation_type.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_rule.dart';
import 'package:decimal/decimal.dart';

class BusinessWithdrawRule extends CommissionRule {
  BusinessWithdrawRule()
    : super(Decimal.parse(AppCommissions.businessWithdrawRate)); // 0.5%

  @override
  CommissionResult calculate(
    Transaction transaction,
    ExchangeRate rate,
    List<CommissionResult> history,
  ) => buildResult(
    transaction,
    rate,
    chargedAmount: transaction.amount,
    explanation: CommissionExplanation.businessWithdraw,
  );
}
