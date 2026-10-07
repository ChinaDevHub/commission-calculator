import 'package:either_dart/either.dart';

import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';

abstract interface class CommissionContract {
  Future<Either<Failure, List<Transaction>>> getTransactions();
  Future<Either<Failure, List<ExchangeRate>>> getExchangeRates();
}
