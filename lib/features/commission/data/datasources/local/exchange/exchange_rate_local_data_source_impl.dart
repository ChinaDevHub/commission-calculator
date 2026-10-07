import 'package:commission_calculator/features/commission/data/datasources/local/exchange/exchange_rate_local_data_source.dart';
import 'package:commission_calculator/features/commission/data/models/exchange_rate_model.dart';
import 'package:decimal/decimal.dart';

class ExchangeRateLocalDataSourceImpl implements ExchangeRateLocalDataSource {
  const ExchangeRateLocalDataSourceImpl();

  @override
  Future<List<ExchangeRateModel>> getExchangeRates() async => [
    ExchangeRateModel(
      currency: 'EUR',
      rateToEur: Decimal.parse('1.0000'),
      precision: 2,
    ),
    ExchangeRateModel(
      currency: 'USD',
      rateToEur: Decimal.parse('1.0850'),
      precision: 2,
    ),
    ExchangeRateModel(
      currency: 'JPY',
      rateToEur: Decimal.parse('162.40'),
      precision: 0,
    ),
    ExchangeRateModel(
      currency: 'AZN',
      rateToEur: Decimal.parse('1.9350'),
      precision: 2,
    ),
  ];
}
