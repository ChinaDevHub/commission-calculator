import 'package:commission_calculator/core/errors/exception_mapper.dart';
import 'package:commission_calculator/core/errors/exceptions.dart';
import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/data/datasources/local/exchange/exchange_rate_local_data_source.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/repositories/exchange_rate_repository.dart';
import 'package:either_dart/either.dart';

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  const ExchangeRateRepositoryImpl(this._localDataSource);

  final ExchangeRateLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<ExchangeRate>>> getExchangeRates() async {
    try {
      final models = await _localDataSource.getExchangeRates();
      return Right(models.map((model) => model.toEntity()).toList());
    } on AppException catch (error) {
      return Left(error.toFailure());
    }
  }
}
