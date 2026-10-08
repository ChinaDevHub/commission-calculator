import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/usecases/calculate_commission_totals_usecase.dart';
import 'package:commission_calculator/features/commission/domain/usecases/calculate_commissions_usecase.dart';
import 'package:commission_calculator/features/commission/presentation/cubits/transactions_cubit.dart';
import 'package:commission_calculator/features/commission/presentation/cubits/transactions_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/commission_fixtures.dart';

class _MockCalculateCommissionsUseCase extends Mock
    implements CalculateCommissionsUseCase {}

void main() {
  late _MockCalculateCommissionsUseCase calculateCommissions;
  late TransactionsCubit cubit;

  setUp(() {
    calculateCommissions = _MockCalculateCommissionsUseCase();
    cubit = TransactionsCubit(
      calculateCommissions,
      const CalculateCommissionTotalsUseCase(),
    );
  });

  tearDown(() => cubit.close());

  test('starts in the initial state', () {
    expect(cubit.state, const TransactionsInitial());
  });

  test('emits loading, then the results with their totals', () async {
    final results = buildCalculator()
        .calculate(sampleTransactions, testRates)
        .right;
    when(() => calculateCommissions()).thenAnswer((_) async => Right(results));

    final states = expectLater(
      cubit.stream,
      emitsInOrder([
        const TransactionsLoading(),
        TransactionsSuccess(results: results, totals: expectedSampleTotals),
      ]),
    );
    await cubit.load();
    await states;
  });

  test('emits empty when there are no transactions', () async {
    when(() => calculateCommissions()).thenAnswer((_) async => const Right([]));

    final states = expectLater(
      cubit.stream,
      emitsInOrder([const TransactionsLoading(), const TransactionsEmpty()]),
    );
    await cubit.load();
    await states;
  });

  test('emits the failure message for invalid input', () async {
    when(() => calculateCommissions()).thenAnswer(
      (_) async => const Left(InvalidInputFailure('Transaction #3: bad date')),
    );

    final states = expectLater(
      cubit.stream,
      emitsInOrder([
        const TransactionsLoading(),
        const TransactionsError('Transaction #3: bad date'),
      ]),
    );
    await cubit.load();
    await states;
  });

  test('does not emit after being closed mid-load', () async {
    when(() => calculateCommissions()).thenAnswer((_) async => const Right([]));

    final load = cubit.load();
    await cubit.close();

    await expectLater(load, completes);
  });
}
