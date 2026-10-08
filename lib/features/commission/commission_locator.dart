import 'package:commission_calculator/core/di/locator.dart';
import 'package:commission_calculator/features/commission/data/datasources/local/exchange/exchange_rate_local_data_source.dart';
import 'package:commission_calculator/features/commission/data/datasources/local/exchange/exchange_rate_local_data_source_impl.dart';
import 'package:commission_calculator/features/commission/data/datasources/local/transaction/transaction_local_data_source.dart';
import 'package:commission_calculator/features/commission/data/datasources/local/transaction/transaction_local_data_source_impl.dart';
import 'package:commission_calculator/features/commission/data/repositories/exchange_rate_repository_impl.dart';
import 'package:commission_calculator/features/commission/data/repositories/transaction_repository_impl.dart';
import 'package:commission_calculator/features/commission/domain/repositories/exchange_rate_repository.dart';
import 'package:commission_calculator/features/commission/domain/repositories/transaction_repository.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_config.dart';
import 'package:commission_calculator/features/commission/domain/rules/commission_calculator.dart';
import 'package:commission_calculator/features/commission/domain/rules/transaction_validator.dart';
import 'package:commission_calculator/features/commission/domain/usecases/calculate_commission_totals_usecase.dart';
import 'package:commission_calculator/features/commission/domain/usecases/calculate_commissions_usecase.dart';
import 'package:commission_calculator/features/commission/presentation/cubits/transactions_cubit.dart';

void setupCommissionLocator() {
  // ── Data ─────────────────────────────────────────────────────────────────
  locator.registerLazySingleton<TransactionLocalDataSource>(
    TransactionLocalDataSourceImpl.new,
  );
  locator.registerLazySingleton<ExchangeRateLocalDataSource>(
    ExchangeRateLocalDataSourceImpl.new,
  );
  locator.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(locator<TransactionLocalDataSource>()),
  );
  locator.registerLazySingleton<ExchangeRateRepository>(
    () => ExchangeRateRepositoryImpl(locator<ExchangeRateLocalDataSource>()),
  );

  // ── Rules ────────────────────────────────────────────────────────────────
  locator.registerLazySingleton(CommissionConfig.standard);
  locator.registerLazySingleton(TransactionValidator.new);
  locator.registerLazySingleton(
    () => CommissionCalculator(
      locator<CommissionConfig>(),
      locator<TransactionValidator>(),
    ),
  );

  // ── Use cases ────────────────────────────────────────────────────────────
  locator.registerLazySingleton(
    () => CalculateCommissionsUseCase(
      locator<TransactionRepository>(),
      locator<ExchangeRateRepository>(),
      locator<CommissionCalculator>(),
    ),
  );
  locator.registerLazySingleton(CalculateCommissionTotalsUseCase.new);

  // ── Cubits ───────────────────────────────────────────────────────────────
  locator.registerFactory(
    () => TransactionsCubit(
      locator<CalculateCommissionsUseCase>(),
      locator<CalculateCommissionTotalsUseCase>(),
    ),
  );
}
