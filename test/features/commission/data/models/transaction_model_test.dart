import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/features/commission/data/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/commission_fixtures.dart';

Map<String, dynamic> _json({
  Object? date = '2024-12-30',
  Object? userId = 1,
  Object? userType = 'private',
  Object? operationType = 'withdraw',
  Object? amount = '800.00',
  Object? currency = 'EUR',
}) => {
  'date': date,
  'userId': userId,
  'userType': userType,
  'operationType': operationType,
  'amount': amount,
  'currency': currency,
};

void main() {
  test('parses a valid object and maps it to the domain entity', () {
    final transaction = TransactionModel.fromJson(
      _json(userType: 'business', operationType: 'deposit', currency: 'JPY'),
    ).toEntity();

    expect(transaction.date, DateTime(2024, 12, 30));
    expect(transaction.userId, 1);
    expect(transaction.userType, UserType.business);
    expect(transaction.operationType, OperationType.deposit);
    expect(transaction.amount, d('800.00'));
    expect(transaction.currency, 'JPY');
  });

  group('throws a FormatException naming the field for', () {
    final invalidInputs = {
      'non-numeric amount': (_json(amount: 'abc'), 'invalid amount "abc"'),
      'amount given as a JSON number': (_json(amount: 800.0), 'amount'),
      'missing amount': (_json(amount: null), 'missing amount'),
      'non-ISO date format': (_json(date: '30.12.2024'), 'invalid date'),
      'impossible calendar date': (_json(date: '2025-02-30'), 'invalid date'),
      'out-of-range month': (_json(date: '2025-13-01'), 'invalid date'),
      'date with a time part': (
        _json(date: '2024-12-30T10:00:00Z'),
        'invalid date',
      ),
      'unknown userType': (_json(userType: 'corporate'), 'invalid userType'),
      'unknown operationType': (
        _json(operationType: 'transfer'),
        'invalid operationType',
      ),
      'non-integer userId': (_json(userId: '1'), 'invalid userId'),
      'missing currency': (_json(currency: null), 'missing currency'),
    };

    for (final MapEntry(key: description, value: (json, message))
        in invalidInputs.entries) {
      test(description, () {
        expect(
          () => TransactionModel.fromJson(json),
          throwsA(
            isA<FormatException>().having(
              (error) => error.message,
              'message',
              contains(message),
            ),
          ),
        );
      });
    }
  });
}
