import 'package:commission_calculator/core/errors/exceptions.dart';
import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/data/datasources/local/exchange/exchange_rate_local_data_source.dart';
import 'package:commission_calculator/features/commission/data/models/exchange_rate_model.dart';
import 'package:commission_calculator/features/commission/data/repositories/exchange_rate_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/commission_fixtures.dart';

class _MockExchangeRateLocalDataSource extends Mock
    implements ExchangeRateLocalDataSource {}

void main() {
  late _MockExchangeRateLocalDataSource localDataSource;
  late ExchangeRateRepositoryImpl repository;

  setUp(() {
    localDataSource = _MockExchangeRateLocalDataSource();
    repository = ExchangeRateRepositoryImpl(localDataSource);
  });

  test('maps models to domain entities', () async {
    final model = ExchangeRateModel(
      currency: 'JPY',
      rateToEur: d('162.40'),
      precision: 0,
    );
    when(
      () => localDataSource.getExchangeRates(),
    ).thenAnswer((_) async => [model]);

    final result = await repository.getExchangeRates();

    expect(result.right, [model.toEntity()]);
  });

  test('returns DataLoadFailure when rates cannot be loaded', () async {
    when(
      () => localDataSource.getExchangeRates(),
    ).thenThrow(const DataLoadException('Rates API is down'));

    final result = await repository.getExchangeRates();

    expect(result.left, const DataLoadFailure('Rates API is down'));
  });
}
