import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/errors/exceptions.dart';
import 'package:commission_calculator/features/commission/data/datasources/local/transaction/transaction_local_data_source_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final dataSource = TransactionLocalDataSourceImpl();

  group('loadTransactions', () {
    test('loads all 12 transactions from the bundled asset', () async {
      final transactions = await dataSource.loadTransactions();

      expect(transactions, hasLength(12));
      expect(transactions.first.date, DateTime(2024, 12, 30));
      expect(transactions.last.currency, 'JPY');
    });

    test('reads the asset through the injected bundle', () async {
      final bundle = _MockAssetBundle();
      when(() => bundle.loadString(any())).thenAnswer((_) async => '[]');

      await TransactionLocalDataSourceImpl(bundle: bundle).loadTransactions();

      verify(() => bundle.loadString(AppKeys.transactionsAsset)).called(1);
    });

    test('throws DataLoadException when the asset cannot be read', () async {
      final bundle = _MockAssetBundle();
      when(
        () => bundle.loadString(any()),
      ).thenThrow(FlutterError('Unable to load asset'));

      await expectLater(
        TransactionLocalDataSourceImpl(bundle: bundle).loadTransactions(),
        throwsA(isA<DataLoadException>()),
      );
    });
  });

  group('loadTransactionsFromRawJson', () {
    test('parses the content of an imported file', () {
      expect(dataSource.loadTransactionsFromRawJson('[]'), isEmpty);
    });

    test('throws InvalidInputException for an invalid file', () {
      expect(
        () => dataSource.loadTransactionsFromRawJson('not json'),
        throwsA(isA<InvalidInputException>()),
      );
    });
  });
}
