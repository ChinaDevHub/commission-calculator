import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/contracts/commission_contract.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/features/commission/domain/rules/business_withdraw_rule.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_rule.dart';
import 'package:commission_calculator/features/commission/domain/rules/deposit_rule.dart';
import 'package:commission_calculator/features/commission/domain/rules/private_withdraw_rule.dart';
import 'package:decimal/decimal.dart';
import 'package:either_dart/either.dart';

class CommissionsUseCase {
  CommissionsUseCase(this._contract);

  final CommissionContract _contract;
  final _depositRule = DepositRule();
  final _businessWithdrawRule = BusinessWithdrawRule();
  final _privateWithdrawRule = PrivateWithdrawRule();

  Future<Either<Failure, List<CommissionResult>>> call() async {
    final rates = await _contract.getExchangeRates();
    if (rates.isLeft) return Left(rates.left);

    final transactions = await _contract.getTransactions();
    if (transactions.isLeft) return Left(transactions.left);

    final ratesByCurrency = {
      for (final rate in rates.right) rate.currency: rate,
    };
    final results = <CommissionResult>[];

    for (final transaction in transactions.right) {
      final rate = ratesByCurrency[transaction.currency];
      if (rate == null) {
        return Left(UnsupportedCurrencyFailure(transaction.currency));
      }
      if (transaction.amount < Decimal.zero) {
        return Left(
          InvalidInputFailure('Negative amount: ${transaction.amount}'),
        );
      }

      results.add(_ruleFor(transaction).calculate(transaction, rate, results));
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
