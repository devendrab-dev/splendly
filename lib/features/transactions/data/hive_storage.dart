import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker/core/constants/hive_key.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

class HiveTransaction {
  static Future<void> saveTransaction(TransactionModel transaction) async {
    var box = Hive.box(HiveKey.boxName);
    List transactions = box.get(HiveKey.expenseData, defaultValue: []);
    transactions.add(transaction.toMap());
    await box.put(HiveKey.expenseData, transactions);
  }

  static Future<void> saveTransactionsList(
    List<TransactionModel> transactions,
  ) async {
    var box = Hive.box(HiveKey.boxName);

    List transactionsMap = transactions.map((a) => a.toMap()).toList();

    await box.put(HiveKey.expenseData, transactionsMap);
  }

  static List<TransactionModel> getTransactionsList() {
    var box = Hive.box(HiveKey.boxName);
    List transactionsMapList = box.get(HiveKey.expenseData, defaultValue: []);
    return transactionsMapList
        .map((map) => TransactionModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }

  static int totalTransaction() {
    var box = Hive.box(HiveKey.boxName);
    List transactionsMapList = box.get(HiveKey.expenseData, defaultValue: []);
    return transactionsMapList.length;
  }

  static TransactionModel? getTransactionAt(int index) {
    List<TransactionModel> transactions = getTransactionsList();
    if (index >= 0 && index < transactions.length) {
      return transactions[index];
    }
    return null;
  }

  static Future<void> deleteTransactionAt(int index) async {
    var transactions = getTransactionsList();
    if (index >= 0 && index < transactions.length) {
      transactions.removeAt(index);
      await saveTransactionsList(transactions);
    }
  }

  static Future<void> clearAll() async {
    var box = Hive.box(HiveKey.boxName);
    await box.delete(HiveKey.expenseData);
  }
}
