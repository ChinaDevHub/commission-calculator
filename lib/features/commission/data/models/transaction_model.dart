import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class TransactionModel {
  const TransactionModel({
    required this.date,
    required this.userId,
    required this.userType,
    required this.operationType,
    required this.amount,
    required this.currency,
  });

  final DateTime date;
  final int userId;
  final UserType userType;
  final OperationType operationType;
  final Decimal amount;
  final String currency;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        date: _read(json, 'date', _dateFormat.parseStrict),
        userId: _read(json, 'userId', (int value) => value),
        userType: _read(json, 'userType', UserType.values.byName),
        operationType: _read(
          json,
          'operationType',
          OperationType.values.byName,
        ),
        amount: _read(json, 'amount', Decimal.parse),
        currency: _read(json, 'currency', (String value) => value),
      );

  static final _dateFormat = DateFormat('yyyy-MM-dd', 'en_US');

  Transaction toEntity() => Transaction(
    date: date,
    userId: userId,
    userType: userType,
    operationType: operationType,
    amount: amount,
    currency: currency,
  );

  static T _read<T, V>(
    Map<String, dynamic> json,
    String key,
    T Function(V value) parse,
  ) {
    final value = json[key];
    try {
      return parse(value as V);
    } catch (_) {
      throw FormatException(
        value == null ? 'missing $key' : 'invalid $key "$value"',
      );
    }
  }
}
