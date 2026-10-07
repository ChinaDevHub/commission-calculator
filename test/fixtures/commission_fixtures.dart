import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:decimal/decimal.dart';

Decimal d(String value) => Decimal.parse(value);

final testRates = [
  ExchangeRate(currency: 'EUR', rateToEur: d('1.0000'), precision: 2),
  ExchangeRate(currency: 'USD', rateToEur: d('1.0850'), precision: 2),
  ExchangeRate(currency: 'JPY', rateToEur: d('162.40'), precision: 0),
  ExchangeRate(currency: 'AZN', rateToEur: d('1.9350'), precision: 2),
];

Transaction tx(
  String date,
  String amount, {
  String currency = 'EUR',
  int userId = 1,
  UserType userType = UserType.private,
  OperationType operationType = OperationType.withdraw,
}) => Transaction(
  date: DateTime.parse(date),
  userId: userId,
  userType: userType,
  operationType: operationType,
  amount: d(amount),
  currency: currency,
);
