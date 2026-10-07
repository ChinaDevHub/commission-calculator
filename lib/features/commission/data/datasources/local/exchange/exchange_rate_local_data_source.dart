import 'package:commission_calculator/features/commission/data/models/exchange_rate_model.dart';

abstract interface class ExchangeRateLocalDataSource {
  Future<List<ExchangeRateModel>> getExchangeRates();
}
