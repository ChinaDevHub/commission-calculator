import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/repositories/exchange_rate_repository.dart';
import 'package:commission_calculator/features/commission/domain/repositories/transaction_repository.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_calculator.dart';
import 'package:either_dart/either.dart';

class CalculateCommissionsUseCase {
  const CalculateCommissionsUseCase(
    this._transactionRepository,
    this._exchangeRateRepository,
    this._calculator,
  );

  final TransactionRepository _transactionRepository;
  final ExchangeRateRepository _exchangeRateRepository;
  final CommissionCalculator _calculator;

  Future<Either<Failure, List<CommissionResult>>> call({
    String? rawJson,
  }) async {
    final rates = await _exchangeRateRepository.getExchangeRates();
    if (rates.isLeft) return Left(rates.left);

    final transactions = rawJson == null
        ? await _transactionRepository.getTransactions()
        : await _transactionRepository.importTransactions(rawJson);
    if (transactions.isLeft) return Left(transactions.left);

    return _calculator.calculate(transactions.right, rates.right);
  }
}
