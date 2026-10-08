import 'package:commission_calculator/core/di/locator.dart';
import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/core/theme/app_theme.dart';
import 'package:commission_calculator/core/theme/theme_cubit.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/usecases/calculate_commission_totals_usecase.dart';
import 'package:commission_calculator/features/commission/domain/usecases/calculate_commissions_usecase.dart';
import 'package:commission_calculator/features/commission/presentation/cubits/transactions_cubit.dart';
import 'package:commission_calculator/features/commission/presentation/pages/transactions_page.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/commission_fixtures.dart';
import '../../../../fixtures/in_memory_theme_mode_storage.dart';

class _MockCalculateCommissionsUseCase extends Mock
    implements CalculateCommissionsUseCase {}

void main() {
  late _MockCalculateCommissionsUseCase calculateCommissions;

  setUp(() {
    calculateCommissions = _MockCalculateCommissionsUseCase();
    locator.registerFactory(
      () => TransactionsCubit(
        calculateCommissions,
        const CalculateCommissionTotalsUseCase(),
      ),
    );
  });

  tearDown(locator.reset);

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => ThemeCubit(InMemoryThemeModeStorage(ThemeMode.dark)),
        child: MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          home: const TransactionsPage(),
        ),
      ),
    );
    await tester.pump();
  }

  void answer(Either<Failure, List<CommissionResult>> result) =>
      when(() => calculateCommissions()).thenAnswer((_) async => result);

  testWidgets('lists every transaction with its commission', (tester) async {
    answer(
      Right(buildCalculator().calculate(sampleTransactions, testRates).right),
    );
    await pumpPage(tester);

    expect(find.text('TOTAL COMMISSION'), findsOneWidget);
    expect(find.text('2.24'), findsOneWidget);
    expect(find.text('800.00 EUR'), findsOneWidget);
    expect(find.text('Fee 53 JPY'), findsOneWidget);
  });

  testWidgets('opens the calculation breakdown of a tapped row', (
    tester,
  ) async {
    answer(
      Right(buildCalculator().calculate(sampleTransactions, testRates).right),
    );
    await pumpPage(tester);

    await tester.tap(find.text('Fee 53 JPY'));
    await tester.pumpAndSettle();

    expect(find.text('Calculation'), findsOneWidget);
    expect(find.text('≈ 307.88 EUR'), findsOneWidget);
    expect(find.text('32,480 JPY'), findsOneWidget);
    expect(find.text('17,520 JPY'), findsOneWidget);
    expect(find.text('0.3%'), findsOneWidget);
    expect(find.text('52.56 JPY'), findsOneWidget);
  });

  testWidgets('shows a readable error with a retry for invalid input', (
    tester,
  ) async {
    answer(const Left(InvalidInputFailure('Transaction #3: invalid date')));
    await pumpPage(tester);

    expect(find.text('Transaction #3: invalid date'), findsOneWidget);

    answer(const Right([]));
    await tester.tap(find.text('Try again'));
    await tester.pump();

    expect(find.text('No transactions'), findsOneWidget);
  });
}
