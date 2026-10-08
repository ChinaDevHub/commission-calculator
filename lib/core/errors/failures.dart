import 'package:commission_calculator/core/errors/error_messages.dart';
import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class DataLoadFailure extends Failure {
  const DataLoadFailure(super.message);
}

final class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message);
}

final class UnsupportedCurrencyFailure extends Failure {
  UnsupportedCurrencyFailure(this.currency, {required int index})
    : super(transactionErrorMessage(index, 'unsupported currency "$currency"'));

  final String currency;
}
