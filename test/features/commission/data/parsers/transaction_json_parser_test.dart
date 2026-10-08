import 'package:commission_calculator/core/errors/exceptions.dart';
import 'package:commission_calculator/features/commission/data/parsers/transaction_json_parser.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/commission_fixtures.dart';

Matcher _throwsInvalidInput(String messagePart) => throwsA(
  isA<InvalidInputException>().having(
    (error) => error.message,
    'message',
    contains(messagePart),
  ),
);

String _transaction(String amount) =>
    '{"date":"2024-12-30","userId":1,"userType":"private",'
    '"operationType":"withdraw","amount":"$amount","currency":"EUR"}';

void main() {
  const parser = TransactionJsonParser();

  test('parses every object of the array in order', () {
    final models = parser.parse(
      '[${_transaction('800.00')},${_transaction('1.00')}]',
    );

    expect([for (final model in models) model.amount], [d('800'), d('1')]);
  });

  test('returns an empty list for an empty array', () {
    expect(parser.parse('[]'), isEmpty);
  });

  test('throws InvalidInputException for malformed JSON', () {
    expect(() => parser.parse('[{"date": '), _throwsInvalidInput('Malformed'));
  });

  test('throws InvalidInputException when the root is not an array', () {
    expect(() => parser.parse('{}'), _throwsInvalidInput('JSON array'));
  });

  test('rejects array items that are not objects', () {
    expect(() => parser.parse('[42]'), _throwsInvalidInput('Transaction #1'));
  });

  test('names the offending transaction in the error message', () {
    expect(
      () => parser.parse('[${_transaction('800.00')},${_transaction('abc')}]'),
      _throwsInvalidInput('Transaction #2: invalid amount "abc"'),
    );
  });
}
