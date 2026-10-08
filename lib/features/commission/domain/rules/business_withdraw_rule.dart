import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/core/enums/commission_explanation.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_config.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_rule.dart';

class BusinessWithdrawRule extends CommissionRule {
  BusinessWithdrawRule(CommissionConfig config)
    : super(config.businessWithdrawRate);

  @override
  CommissionResult calculate(
    Transaction transaction,
    ExchangeRate exchangeRate,
    List<CommissionResult> history,
  ) => buildResult(
    transaction,
    exchangeRate,
    explanation: CommissionExplanation.businessWithdraw,
  );
}
