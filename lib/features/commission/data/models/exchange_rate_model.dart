import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:decimal/decimal.dart';

class ExchangeRateModel {
  const ExchangeRateModel({
    required this.currency,
    required this.rateToEur,
    required this.precision,
  });

  final String currency;
  final Decimal rateToEur;
  final int precision;

  ExchangeRate toEntity() => ExchangeRate(
    currency: currency,
    rateToEur: rateToEur,
    precision: precision,
  );
}
