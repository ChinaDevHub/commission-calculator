import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error']);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error']);
}

final class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message);
}

final class UnsupportedCurrencyFailure extends Failure {
  const UnsupportedCurrencyFailure(this.currency)
    : super('Unsupported currency: $currency');

  final String currency;
}
