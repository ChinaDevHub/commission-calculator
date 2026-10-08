import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/features/commission/domain/rules/transaction_validator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/commission_fixtures.dart';

void main() {
  const validator = TransactionValidator();

  Failure? validate(List<Transaction> transactions) =>
      validator.validate(transactions, testRates);

  test('accepts the sample input', () {
    expect(validate(sampleTransactions), isNull);
  });

  test('accepts several transactions on the same date', () {
    expect(
      validate([tx('2025-01-06', '1.00'), tx('2025-01-06', '2.00')]),
      isNull,
    );
  });

  test('rejects a currency without an exchange rate', () {
    expect(
      validate([
        tx('2025-01-06', '1.00'),
        tx('2025-01-06', '1.00', currency: 'GBP'),
      ]),
      UnsupportedCurrencyFailure('GBP', index: 1),
    );
  });

  test('rejects a negative amount', () {
    expect(
      validate([tx('2025-01-06', '-5.00')]),
      const InvalidInputFailure('Transaction #1: amount must not be negative'),
    );
  });

  test('rejects transactions that are not sorted by date', () {
    expect(
      validate([tx('2025-01-07', '1.00'), tx('2025-01-06', '1.00')]),
      const InvalidInputFailure(
        'Transaction #2: transactions must be sorted by date',
      ),
    );
  });
}
