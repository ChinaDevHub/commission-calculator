import 'package:commission_calculator/core/enums/commission_explanation_type.dart';
import 'package:commission_calculator/core/enums/operation_type.dart';
import 'package:commission_calculator/core/enums/user_type.dart';
import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/contracts/commission_contract.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:commission_calculator/features/commission/domain/usecases/commissions_usecase.dart';
import 'package:decimal/decimal.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/commission_fixtures.dart';

class _MockCommissionContract extends Mock implements CommissionContract {}

void main() {
  late _MockCommissionContract contract;
  late CommissionsUseCase useCase;

  setUp(() {
    contract = _MockCommissionContract();
    useCase = CommissionsUseCase(contract);
    when(
      () => contract.getExchangeRates(),
    ).thenAnswer((_) async => Right(testRates));
  });

  Future<Either<Failure, List<CommissionResult>>> calculate(
    List<Transaction> transactions,
  ) {
    when(
      () => contract.getTransactions(),
    ).thenAnswer((_) async => Right(transactions));
    return useCase();
  }

  Future<List<Decimal>> fees(List<Transaction> transactions) async => [
    for (final result in (await calculate(transactions)).right)
      result.finalCommission,
  ];

  test('matches all 12 expected results of the sample input', () async {
    expect(
      await fees([
        tx('2024-12-30', '800.00'),
        tx('2024-12-31', '200.00', operationType: OperationType.deposit),
        tx('2025-01-02', '50000', currency: 'JPY'),
        tx('2025-01-03', '1000.00', currency: 'USD', userId: 2),
        tx('2025-01-04', '200.00', userId: 2),
        tx('2025-01-04', '300.00', userId: 3, userType: UserType.business),
        tx('2025-01-05', '100.00', currency: 'USD'),
        tx('2025-01-05', '100.00'),
        tx('2025-01-06', '500.00', currency: 'AZN'),
        tx('2025-01-07', '300.00', currency: 'USD', userId: 2),
        tx('2025-01-08', '1.00', operationType: OperationType.deposit),
        tx(
          '2025-01-08',
          '10000',
          currency: 'JPY',
          userId: 3,
          userType: UserType.business,
          operationType: OperationType.deposit,
        ),
      ]),
      [
        d('0.00'),
        d('0.06'),
        d('53'),
        d('0.00'),
        d('0.37'),
        d('1.50'),
        d('0.30'),
        d('0.30'),
        d('0.00'),
        d('0.00'),
        d('0.01'),
        d('3'),
      ],
    );
  });

  test('result explains every step of the calculation', () async {
    final [_, result] = (await calculate([
      tx('2024-12-30', '800.00'),
      tx('2025-01-02', '50000', currency: 'JPY'),
    ])).right;

    expect(result.amountInEur.round(scale: 2), d('307.88'));
    expect(result.freeAllowanceUsedEur, d('200'));
    expect(result.freeAmountInTxCurrency, d('32480'));
    expect(result.chargedAmountInTxCurrency, d('17520'));
    expect(result.feeRate, d('0.003'));
    expect(result.rawCommission, d('52.56'));
    expect(result.finalCommission, d('53'));
    expect(
      result.explanation,
      CommissionExplanation.privateWithdrawAllowanceExceeded,
    );
  });

  group('edge cases', () {
    test('a week spanning New Year is one Monday–Sunday week', () async {
      expect(
        await fees([
          tx('2024-12-30', '1000.00'),
          tx('2025-01-05', '100.00'),
          tx('2025-01-06', '100.00'),
        ]),
        [d('0'), d('0.30'), d('0')],
      );
    });

    test('the 4th withdrawal is charged even with allowance left', () async {
      expect(
        await fees([
          for (var day = 6; day <= 9; day++) tx('2025-01-0$day', '100.00'),
        ]),
        [d('0'), d('0'), d('0'), d('0.30')],
      );
    });

    test('only the part above the allowance is charged', () async {
      expect(await fees([tx('2025-01-06', '1200.00')]), [d('0.60')]);
    });

    test('commission is rounded up to the currency precision', () async {
      expect(
        await fees([
          tx('2025-01-06', '1.00', operationType: OperationType.deposit),
          tx(
            '2025-01-06',
            '175200',
            currency: 'JPY',
            operationType: OperationType.deposit,
          ),
        ]),
        [d('0.01'), d('53')],
      );
    });
  });

  group('failures', () {
    test('returns the failure when rates cannot be loaded', () async {
      when(
        () => contract.getExchangeRates(),
      ).thenAnswer((_) async => const Left(ServerFailure()));

      expect(await useCase(), const Left(ServerFailure()));
    });

    test('returns the failure when transactions cannot be loaded', () async {
      when(
        () => contract.getTransactions(),
      ).thenAnswer((_) async => const Left(CacheFailure()));

      expect(await useCase(), const Left(CacheFailure()));
    });

    test('rejects a currency without an exchange rate', () async {
      expect(
        await calculate([tx('2025-01-06', '10.00', currency: 'GBP')]),
        const Left(UnsupportedCurrencyFailure('GBP')),
      );
    });

    test('rejects a negative amount', () async {
      expect(
        (await calculate([tx('2025-01-06', '-5.00')])).left,
        isA<InvalidInputFailure>(),
      );
    });
  });
}
