import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:either_dart/either.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, List<Transaction>>> getTransactions();

  Future<Either<Failure, List<Transaction>>> importTransactions(String rawJson);
}
