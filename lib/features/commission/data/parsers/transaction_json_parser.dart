import 'dart:convert';

import 'package:commission_calculator/core/errors/error_messages.dart';
import 'package:commission_calculator/core/errors/exceptions.dart';
import 'package:commission_calculator/features/commission/data/models/transaction_model.dart';

class TransactionJsonParser {
  const TransactionJsonParser();

  List<TransactionModel> parse(String rawJson) => [
    for (final (index, item) in _decodeList(rawJson).indexed)
      _parseItem(index, item),
  ];

  List<Object?> _decodeList(String rawJson) {
    final Object? decoded;
    try {
      decoded = jsonDecode(rawJson);
    } on FormatException catch (error) {
      throw InvalidInputException('Malformed JSON: ${error.message}');
    }
    if (decoded is! List) {
      throw const InvalidInputException(
        'Expected a JSON array of transactions',
      );
    }
    return decoded;
  }

  TransactionModel _parseItem(int index, Object? item) {
    if (item is! Map<String, dynamic>) {
      throw InvalidInputException(
        transactionErrorMessage(index, 'expected a JSON object'),
      );
    }
    try {
      return TransactionModel.fromJson(item);
    } on FormatException catch (error) {
      throw InvalidInputException(
        transactionErrorMessage(index, error.message),
      );
    }
  }
}
