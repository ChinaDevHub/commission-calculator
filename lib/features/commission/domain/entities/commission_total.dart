import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class CommissionTotal extends Equatable {
  const CommissionTotal({
    required this.currency,
    required this.precision,
    required this.amount,
  });

  final String currency;
  final int precision;
  final Decimal amount;

  @override
  List<Object> get props => [currency, precision, amount];
}
