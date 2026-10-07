import 'package:commission_calculator/core/errors/error_messages.dart';
import 'package:commission_calculator/core/errors/failures.dart';
import 'package:commission_calculator/features/commission/domain/entities/exchange_rate.dart';
import 'package:commission_calculator/features/commission/domain/entities/transaction.dart';
import 'package:decimal/decimal.dart';

class TransactionValidator {
  const TransactionValidator();

  Failure? validate(List<Transaction> transactions, List<ExchangeRate> rates) {
    final currencies = {for (final rate in rates) rate.currency};

    for (final (index, transaction) in transactions.indexed) {
      if (!currencies.contains(transaction.currency)) {
        return UnsupportedCurrencyFailure(transaction.currency, index: index);
      }
      if (transaction.amount < Decimal.zero) {
        return InvalidInputFailure(
          transactionErrorMessage(index, 'amount must not be negative'),
        );
      }
      if (index > 0 &&
          transaction.date.isBefore(transactions[index - 1].date)) {
        return InvalidInputFailure(
          transactionErrorMessage(index, 'transactions must be sorted by date'),
        );
      }
    }
    return null;
  }
}
