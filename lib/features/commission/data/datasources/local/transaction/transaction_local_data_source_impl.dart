import 'package:commission_calculator/core/constants/app_keys.dart';
import 'package:commission_calculator/core/errors/exceptions.dart';
import 'package:commission_calculator/features/commission/data/datasources/local/transaction/transaction_local_data_source.dart';
import 'package:commission_calculator/features/commission/data/models/transaction_model.dart';
import 'package:commission_calculator/features/commission/data/parsers/transaction_json_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  TransactionLocalDataSourceImpl({AssetBundle? bundle})
    : _bundle = bundle ?? rootBundle;

  static const _parser = TransactionJsonParser();

  final AssetBundle _bundle;

  @override
  Future<List<TransactionModel>> loadTransactions() async {
    final String rawJson;
    try {
      rawJson = await _bundle.loadString(AppKeys.transactionsAsset);
    } on FlutterError catch (error) {
      throw DataLoadException(error.message);
    }
    return _parser.parse(rawJson);
  }

  @override
  List<TransactionModel> loadTransactionsFromRawJson(String rawJson) =>
      _parser.parse(rawJson);
}
