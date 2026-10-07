import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/core/enums/commission_explanation.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class CommissionResult extends Equatable {
  const CommissionResult({
    required this.transaction,
    required this.exchangeRate,
    required this.feeRate,
    required this.freeAmount,
    required this.explanation,
  });

  final Transaction transaction;
  final ExchangeRate exchangeRate;
  final Decimal feeRate;
  final Decimal freeAmount;
  final CommissionExplanation explanation;

  String get currency => exchangeRate.currency;

  Decimal get amountInEur => exchangeRate.toEur(transaction.amount);

  Decimal get freeAmountInEur => exchangeRate.toEur(freeAmount);

  Decimal get chargedAmount => transaction.amount - freeAmount;

  Decimal get rawCommission => chargedAmount * feeRate;

  Decimal get commission => exchangeRate.roundUp(rawCommission);

  @override
  List<Object> get props => [
    transaction,
    exchangeRate,
    feeRate,
    freeAmount,
    explanation,
  ];
}
