import 'package:commission_calculator/core/errors/exception_mapper.dart';
import 'package:commission_calculator/core/errors/exceptions.dart';
import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/data/datasources/local/transaction/transaction_local_data_source.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/features/commission/domain/repositories/transaction_repository.dart';
import 'package:either_dart/either.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl(this._localDataSource);

  final TransactionLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions() async {
    try {
      final models = await _localDataSource.loadTransactions();
      return Right(models.map((model) => model.toEntity()).toList());
    } on AppException catch (error) {
      return Left(error.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> importTransactions(
    String rawJson,
  ) async {
    try {
      final models = _localDataSource.loadTransactionsFromRawJson(rawJson);
      return Right(models.map((model) => model.toEntity()).toList());
    } on AppException catch (error) {
      return Left(error.toFailure());
    }
  }
}
