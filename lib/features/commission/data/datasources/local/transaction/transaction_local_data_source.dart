import 'package:commission_calculator/features/commission/data/models/transaction_model.dart';

abstract interface class TransactionLocalDataSource {
  Future<List<TransactionModel>> loadTransactions();
  List<TransactionModel> loadTransactionsFromRawJson(String rawJson);
}
