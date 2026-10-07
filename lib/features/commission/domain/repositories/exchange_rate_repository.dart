import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:either_dart/either.dart';

abstract interface class ExchangeRateRepository {
  Future<Either<Failure, List<ExchangeRate>>> getExchangeRates();
}
