import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  const Transaction({
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

  @override
  List<Object> get props => [
    date,
    userId,
    userType,
    operationType,
    amount,
    currency,
  ];
}
