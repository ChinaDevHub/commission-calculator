import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/core/errors/exceptions.dart';
import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/data/datasources/local/transaction/transaction_local_data_source.dart';
import 'package:commission_calculator/features/commission/data/models/transaction_model.dart';
import 'package:commission_calculator/features/commission/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/commission_fixtures.dart';

class _MockTransactionLocalDataSource extends Mock
    implements TransactionLocalDataSource {}

void main() {
  late _MockTransactionLocalDataSource localDataSource;
  late TransactionRepositoryImpl repository;

  final model = TransactionModel(
    date: DateTime(2025, 1, 2),
    userId: 1,
    userType: UserType.private,
    operationType: OperationType.withdraw,
    amount: d('50000'),
    currency: 'JPY',
  );

  setUp(() {
    localDataSource = _MockTransactionLocalDataSource();
    repository = TransactionRepositoryImpl(localDataSource);
  });

  group('getTransactions', () {
    test('maps models to domain entities', () async {
      when(
        () => localDataSource.loadTransactions(),
      ).thenAnswer((_) async => [model]);

      final result = await repository.getTransactions();

      expect(result.right, [model.toEntity()]);
    });

    test('returns InvalidInputFailure for invalid input', () async {
      when(
        () => localDataSource.loadTransactions(),
      ).thenThrow(const InvalidInputException('Transaction #2: bad amount'));

      final result = await repository.getTransactions();

      expect(
        result.left,
        const InvalidInputFailure('Transaction #2: bad amount'),
      );
    });

    test('returns DataLoadFailure when the source cannot be read', () async {
      when(
        () => localDataSource.loadTransactions(),
      ).thenThrow(const DataLoadException('Unable to load asset'));

      final result = await repository.getTransactions();

      expect(result.left, const DataLoadFailure('Unable to load asset'));
    });
  });

  group('importTransactions', () {
    test('parses the raw JSON through the data source', () async {
      when(
        () => localDataSource.loadTransactionsFromRawJson('[...]'),
      ).thenReturn([model]);

      final result = await repository.importTransactions('[...]');

      expect(result.right, [model.toEntity()]);
    });

    test('returns InvalidInputFailure for an invalid file', () async {
      when(
        () => localDataSource.loadTransactionsFromRawJson(any()),
      ).thenThrow(const InvalidInputException('Malformed JSON'));

      final result = await repository.importTransactions('{');

      expect(result.left, const InvalidInputFailure('Malformed JSON'));
    });
  });
}
