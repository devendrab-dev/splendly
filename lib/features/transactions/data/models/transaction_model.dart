import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  expense,

  @HiveField(1)
  income,

  @HiveField(2)
  transfer,
}

class TransactionModel {
  final String id;
  final TransactionType transactionType;
  final double amount;
  final String category;
  final String iconPath;
  final String? note;
  final String? fromAccountId;
  final String? transferAccountId;
  final DateTime dateTime;

  TransactionModel({
    required this.id,
    required this.transactionType,
    required this.amount,
    required this.category,
    required this.iconPath,
    required this.note,
    required this.fromAccountId,
    this.transferAccountId,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "transactionType": transactionType,
    "amount": amount,
    "category": category,
    "iconPath": iconPath,
    "note": note,
    "fromAccountId": fromAccountId,
    "dateTime": dateTime.toIso8601String(),
  };

  factory TransactionModel.fromMap(Map map) => TransactionModel(
    id: map["id"],
    transactionType: map["transactionType"],
    transferAccountId: map["transferAccountId"],
    amount: map["amount"],
    category: map["category"],
    iconPath: map["iconPath"],
    fromAccountId: map["fromAccountId"],
    note: map["note"],
    dateTime: DateTime.parse(map["dateTime"]),
  );
}

class TransactionGraphData {
  List<double> expense;
  List<double> income;
  List<String> label;
  List<Categories> incomeCategories;
  List<Categories> expenseCategories;
  SummaryData summaryData;

  TransactionGraphData({
    required this.expense,
    required this.income,
    required this.label,
    required this.incomeCategories,
    required this.expenseCategories,
    required this.summaryData,
  });
}

class Categories {
  final String category;
  final double total;

  Categories(this.category, this.total);
}

class SummaryData {
  final int totalTransactions;
  final double avgTransactions;
  final double totalAmount;
  final double maxTransaction;
  final double minTransaction;
  final double totalIncome;
  final double totalExpense;
  final String maxSpentIcomeCategory;
  final String maxSpentExpenseCategory;

  SummaryData({
    this.totalTransactions = 0,
    this.avgTransactions = 0,
    this.totalAmount = 0,
    this.maxTransaction = 0,
    this.minTransaction = 0,
    this.totalIncome = 0,
    this.totalExpense = 0,
    this.maxSpentIcomeCategory = "<No Data>",
    this.maxSpentExpenseCategory = "<No Data>",
  });
}
