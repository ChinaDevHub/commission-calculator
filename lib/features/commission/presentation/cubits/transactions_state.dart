import 'package:commission_calculator/features/commission/domain/entities/commission_result.dart';
import 'package:commission_calculator/features/commission/domain/entities/commission_total.dart';
import 'package:equatable/equatable.dart';

sealed class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

final class TransactionsInitial extends TransactionsState {
  const TransactionsInitial();
}

final class TransactionsLoading extends TransactionsState {
  const TransactionsLoading();
}

final class TransactionsEmpty extends TransactionsState {
  const TransactionsEmpty();
}

final class TransactionsError extends TransactionsState {
  const TransactionsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class TransactionsSuccess extends TransactionsState {
  const TransactionsSuccess({required this.results, required this.totals});

  final List<CommissionResult> results;
  final List<CommissionTotal> totals;

  @override
  List<Object> get props => [results, totals];
}
