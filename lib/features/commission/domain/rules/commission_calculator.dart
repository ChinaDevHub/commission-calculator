import 'dart:collection';

import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/features/commission/domain/rules/business_withdraw_rule.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_config.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_rule.dart';
import 'package:commission_calculator/features/commission/domain/rules/deposit_rule.dart';
import 'package:commission_calculator/features/commission/domain/rules/private_withdraw_rule.dart';
import 'package:commission_calculator/features/commission/domain/rules/transaction_validator.dart';
import 'package:either_dart/either.dart';

class CommissionCalculator {
  CommissionCalculator(CommissionConfig config, this._validator)
    : _depositRule = DepositRule(config),
      _businessWithdrawRule = BusinessWithdrawRule(config),
      _privateWithdrawRule = PrivateWithdrawRule(config);

  final TransactionValidator _validator;
  final CommissionRule _depositRule;
  final CommissionRule _businessWithdrawRule;
  final CommissionRule _privateWithdrawRule;

  Either<Failure, List<CommissionResult>> calculate(
    List<Transaction> transactions,
    List<ExchangeRate> rates,
  ) {
    final failure = _validator.validate(transactions, rates);
    if (failure != null) return Left(failure);

    final ratesByCurrency = {for (final rate in rates) rate.currency: rate};
    final results = <CommissionResult>[];
    final history = UnmodifiableListView(results);

    for (final transaction in transactions) {
      final rate = ratesByCurrency[transaction.currency]!;
      results.add(_ruleFor(transaction).calculate(transaction, rate, history));
    }
    return Right(results);
  }

  CommissionRule _ruleFor(Transaction transaction) =>
      switch ((transaction.operationType, transaction.userType)) {
        (OperationType.deposit, _) => _depositRule,
        (OperationType.withdraw, UserType.business) => _businessWithdrawRule,
        (OperationType.withdraw, UserType.private) => _privateWithdrawRule,
      };
}
