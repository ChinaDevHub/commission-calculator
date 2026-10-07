import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class ExchangeRate extends Equatable {
  const ExchangeRate({
    required this.currency,
    required this.rateToEur,
    required this.precision,
  });

  static const _conversionScale = 20;

  final String currency;
  final Decimal rateToEur;
  final int precision;

  Decimal toEur(Decimal amount) => (amount / rateToEur).toDecimal(
    scaleOnInfinitePrecision: _conversionScale,
  );

  Decimal fromEur(Decimal amountInEur) => amountInEur * rateToEur;

  Decimal roundUp(Decimal amount) => amount.ceil(scale: precision);

  @override
  List<Object> get props => [currency, rateToEur, precision];
}
