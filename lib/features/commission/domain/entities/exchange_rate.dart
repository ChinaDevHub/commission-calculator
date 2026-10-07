import 'package:decimal/decimal.dart';

class ExchangeRate {
  const ExchangeRate({
    required this.currency,
    required this.rateToEur,
    required this.precision,
  });

  final String currency;
  final Decimal rateToEur;
  final int precision;
}
