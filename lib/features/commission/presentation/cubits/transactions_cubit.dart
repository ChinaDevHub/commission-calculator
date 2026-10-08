import 'package:commission_calculator/features/commission/domain/usecases/calculate_commission_totals_usecase.dart';
import 'package:commission_calculator/features/commission/domain/usecases/calculate_commissions_usecase.dart';
import 'package:commission_calculator/features/commission/presentation/cubits/transactions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit(this._calculateCommissions, this._calculateTotals)
    : super(const TransactionsInitial());

  final CalculateCommissionsUseCase _calculateCommissions;
  final CalculateCommissionTotalsUseCase _calculateTotals;

  Future<void> load() async {
    emit(const TransactionsLoading());
    final result = await _calculateCommissions();
    if (isClosed) return;

    emit(
      result.fold<TransactionsState>(
        (failure) => TransactionsError(failure.message),
        (results) => results.isEmpty
            ? const TransactionsEmpty()
            : TransactionsSuccess(
                results: results,
                totals: _calculateTotals(results),
              ),
      ),
    );
  }
}
