import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker/core/constants/hive_key.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

class HiveTransaction {
  static Future<void> saveTransaction(TransactionModel transaction) async {
    var box = Hive.box(HiveKey.boxName);
    List transactions = box.get(HiveKey.expenseData, defaultValue: []);
    transactions.add(transaction.toMap());
    await box.put(HiveKey.expenseData, transactions);
    debugPrint(
      "fn saveTransaction, Transaction Saved of ID: ${transaction.id}",
    );
  }

  static Future<void> saveTransactionsList(
    List<TransactionModel> transactions,
  ) async {
    var box = Hive.box(HiveKey.boxName);
    List transactionsMap = transactions.map((a) => a.toMap()).toList();
    await box.put(HiveKey.expenseData, transactionsMap);
    debugPrint("Saved total ${transactions.length} Transactions");
  }

  static List<TransactionModel> getTransactionsList() {
    var box = Hive.box(HiveKey.boxName);
    List transactionsMapList = box.get(HiveKey.expenseData, defaultValue: []);
    debugPrint("Got Total of ${transactionsMapList.length} Transactions");
    return transactionsMapList
        .map((map) => TransactionModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }

  static List<TransactionModel> getTransactionsListById(String id) {
    var box = Hive.box(HiveKey.boxName);

    List transactionsMapList = box.get(HiveKey.expenseData, defaultValue: []);

    List<TransactionModel> txList = transactionsMapList
        .where((map) => map['fromAccountId'].toString() == id.toString())
        .map((map) => TransactionModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();

    txList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return txList;
  }

  static TransactionGraphData getTransactionsBarListByFilter(String filter) {
    var box = Hive.box(HiveKey.boxName);
    List transactionsMapList = box.get(HiveKey.expenseData, defaultValue: []);

    List<TransactionModel> transactions = transactionsMapList
        .map((map) => TransactionModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();

    List<double> income = [];
    List<double> expense = [];
    List<String> labels = [];

    Map<String, double> incomeCategoryMap = {};
    Map<String, double> expenseCategoryMap = {};

    final now = DateTime.now();
    List<TransactionModel> filteredTransactions = [];

    if (filter == "Week") {
      for (int i = 6; i >= 0; i--) {
        final day = DateTime(now.year, now.month, now.day - i);
        labels.add("${day.day}/${day.month}");

        double dayIncome = 0;
        double dayExpense = 0;

        for (var tx in transactions) {
          if (tx.dateTime.year == day.year &&
              tx.dateTime.month == day.month &&
              tx.dateTime.day == day.day) {
            filteredTransactions.add(tx);
            if (tx.transactionType == TransactionType.income) {
              dayIncome += tx.amount;
              incomeCategoryMap[tx.category] =
                  (incomeCategoryMap[tx.category] ?? 0) + tx.amount;
            } else if (tx.transactionType == TransactionType.expense) {
              dayExpense += tx.amount;
              expenseCategoryMap[tx.category] =
                  (expenseCategoryMap[tx.category] ?? 0) + tx.amount;
            }
          }
        }

        income.add(dayIncome);
        expense.add(dayExpense);
      }
    } else if (filter == "Month") {
      final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
      for (int dayNum = 1; dayNum <= daysInMonth; dayNum++) {
        final day = DateTime(now.year, now.month, dayNum);
        labels.add(dayNum.toString());

        double dayIncome = 0;
        double dayExpense = 0;

        for (var tx in transactions) {
          if (tx.dateTime.year == day.year &&
              tx.dateTime.month == day.month &&
              tx.dateTime.day == day.day) {
            filteredTransactions.add(tx);
            if (tx.transactionType == TransactionType.income) {
              dayIncome += tx.amount;
              incomeCategoryMap[tx.category] =
                  (incomeCategoryMap[tx.category] ?? 0) + tx.amount;
            } else if (tx.transactionType == TransactionType.expense) {
              dayExpense += tx.amount;
              expenseCategoryMap[tx.category] =
                  (expenseCategoryMap[tx.category] ?? 0) + tx.amount;
            }
          }
        }

        income.add(dayIncome);
        expense.add(dayExpense);
      }
    } else if (filter == "Year") {
      for (var tx in transactions) {
        if (tx.dateTime.year == now.year) {
          filteredTransactions.add(tx);
          if (tx.transactionType == TransactionType.income) {
            incomeCategoryMap[tx.category] =
                (incomeCategoryMap[tx.category] ?? 0) + tx.amount;
          } else if (tx.transactionType == TransactionType.expense) {
            expenseCategoryMap[tx.category] =
                (expenseCategoryMap[tx.category] ?? 0) + tx.amount;
          }
        }
      }

      double yearIncome = filteredTransactions
          .where((tx) => tx.transactionType == TransactionType.income)
          .fold(0, (sum, tx) => sum + tx.amount);
      double yearExpense = filteredTransactions
          .where((tx) => tx.transactionType == TransactionType.expense)
          .fold(0, (sum, tx) => sum + tx.amount);

      income.add(yearIncome);
      expense.add(yearExpense);
      labels.add("${now.year}");
    }

    List<Categories> incomeCategories =
        incomeCategoryMap.entries
            .map((e) => Categories(e.key, e.value))
            .toList()
          ..sort((a, b) => b.total.compareTo(a.total));

    List<Categories> expenseCategories =
        expenseCategoryMap.entries
            .map((e) => Categories(e.key, e.value))
            .toList()
          ..sort((a, b) => b.total.compareTo(a.total));

    double totalAmount = filteredTransactions.fold(
      0,
      (sum, tx) => sum + tx.amount,
    );
    double totalIncome = filteredTransactions
        .where((tx) => tx.transactionType == TransactionType.income)
        .fold(0, (sum, tx) => sum + tx.amount);
    double totalExpense = filteredTransactions
        .where((tx) => tx.transactionType == TransactionType.expense)
        .fold(0, (sum, tx) => sum + tx.amount);
    double maxTransaction = filteredTransactions.isNotEmpty
        ? filteredTransactions
              .map((tx) => tx.amount)
              .reduce((a, b) => a > b ? a : b)
        : 0;
    double minTransaction = filteredTransactions.isNotEmpty
        ? filteredTransactions
              .map((tx) => tx.amount)
              .reduce((a, b) => a < b ? a : b)
        : 0;
    double avgTransactions = filteredTransactions.isNotEmpty
        ? totalAmount / filteredTransactions.length
        : 0;

    SummaryData summaryData = SummaryData(
      totalTransactions: filteredTransactions.length,
      avgTransactions: avgTransactions,
      totalAmount: totalAmount,
      maxTransaction: maxTransaction,
      minTransaction: minTransaction,
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      maxSpentIcomeCategory: incomeCategories.isNotEmpty
          ? incomeCategories.first.category
          : "<No Data>",
      maxSpentExpenseCategory: expenseCategories.isNotEmpty
          ? expenseCategories.first.category
          : "<No Data>",
    );

    return TransactionGraphData(
      income: income,
      expense: expense,
      label: labels,
      incomeCategories: incomeCategories,
      expenseCategories: expenseCategories,
      summaryData: summaryData,
    );
  }

  static Future<bool> deleteTransactionById(String txId) async {
    final box = Hive.box(HiveKey.boxName);
    final List rawList = box.get(HiveKey.expenseData, defaultValue: []);
    final int index = rawList.indexWhere((item) => item["id"] == txId);
    if (index == -1) {
      debugPrint("Transaction not found: $txId");
      return false;
    }
    final tx = rawList[index];
    await HiveAccount.updateOnDelete(
      accountId: tx["fromAccountId"],
      type: tx["transactionType"],
      amount: tx["amount"],
    );
    rawList.removeAt(index);
    await box.put(HiveKey.expenseData, rawList);
    debugPrint("Transaction deleted: $txId at index $index");
    return true;
  }

  static Future<void> clearAll() async {
    var box = Hive.box(HiveKey.boxName);
    await box.delete(HiveKey.expenseData);
    debugPrint("Deleted All the Transactions");
  }
}
