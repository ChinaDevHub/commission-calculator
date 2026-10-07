import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/repositories/exchange_rate_repository.dart';
import 'package:commission_calculator/features/commission/domain/repositories/transaction_repository.dart';
import 'package:commission_calculator/features/commission/domain/usecases/calculate_commissions_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/commission_fixtures.dart';

class _MockTransactionRepository extends Mock
    implements TransactionRepository {}

class _MockExchangeRateRepository extends Mock
    implements ExchangeRateRepository {}

void main() {
  late _MockTransactionRepository transactionRepository;
  late _MockExchangeRateRepository exchangeRateRepository;
  late CalculateCommissionsUseCase useCase;

  setUp(() {
    transactionRepository = _MockTransactionRepository();
    exchangeRateRepository = _MockExchangeRateRepository();
    useCase = CalculateCommissionsUseCase(
      transactionRepository,
      exchangeRateRepository,
      buildCalculator(),
    );
    when(
      () => exchangeRateRepository.getExchangeRates(),
    ).thenAnswer((_) async => Right(testRates));
    when(
      () => transactionRepository.getTransactions(),
    ).thenAnswer((_) async => Right(sampleTransactions));
  });

  test('calculates the bundled transactions', () async {
    final result = await useCase();

    expect(commissionsOf(result.right), expectedSampleCommissions);
    verifyNever(() => transactionRepository.importTransactions(any()));
  });

  test('calculates imported transactions when raw JSON is given', () async {
    when(
      () => transactionRepository.importTransactions('[...]'),
    ).thenAnswer((_) async => Right([tx('2025-01-06', '1200.00')]));

    final result = await useCase(rawJson: '[...]');

    expect(commissionsOf(result.right), [(d('0.60'), 'EUR')]);
    verifyNever(() => transactionRepository.getTransactions());
  });

  group('failures', () {
    test('returns the failure when rates cannot be loaded', () async {
      when(
        () => exchangeRateRepository.getExchangeRates(),
      ).thenAnswer((_) async => const Left(DataLoadFailure('rates')));

      expect(await useCase(), const Left(DataLoadFailure('rates')));
    });

    test('returns the failure when transactions cannot be loaded', () async {
      when(
        () => transactionRepository.getTransactions(),
      ).thenAnswer((_) async => const Left(DataLoadFailure('transactions')));

      expect(await useCase(), const Left(DataLoadFailure('transactions')));
    });

    test('returns the failure of an invalid imported file', () async {
      when(
        () => transactionRepository.importTransactions(any()),
      ).thenAnswer((_) async => const Left(InvalidInputFailure('bad file')));

      expect(
        await useCase(rawJson: '{'),
        const Left(InvalidInputFailure('bad file')),
      );
    });

    test('returns the validation failure of the transactions', () async {
      when(() => transactionRepository.getTransactions()).thenAnswer(
        (_) async => Right([tx('2025-01-06', '10.00', currency: 'GBP')]),
      );

      final result = await useCase();

      expect(result.left, isA<UnsupportedCurrencyFailure>());
    });
  });
}
