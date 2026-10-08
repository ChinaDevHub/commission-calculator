import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/core/enums/commission_explanation.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_config.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_rule.dart';

class DepositRule extends CommissionRule {
  DepositRule(CommissionConfig config) : super(config.depositRate);

  @override
  CommissionResult calculate(
    Transaction transaction,
    ExchangeRate exchangeRate,
    List<CommissionResult> history,
  ) => buildResult(
    transaction,
    exchangeRate,
    explanation: CommissionExplanation.deposit,
  );
}
