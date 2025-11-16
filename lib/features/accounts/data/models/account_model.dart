import 'dart:convert';

class AccountModel {
  String accountId;
  String accountType;
  String userName;
  double balance;
  int? cardNumber;
  String imagePath;
  double income;
  double expense;

  AccountModel({
    required this.accountId,
    required this.accountType,
    required this.userName,
    required this.balance,
    required this.imagePath,
    this.income = 0,
    this.expense = 0,
    this.cardNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountId': accountId,
      'accountType': accountType,
      'userName': userName,
      'balance': balance,
      'cardNumber': cardNumber,
      'imagePath': imagePath,
      'income': income,
      'expense': expense,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountId: map['accountId'] as String,
      accountType: map['accountType'] as String,
      userName: map['userName'] as String,
      balance: map['balance'] as double,
      cardNumber: map['cardNumber'] != null ? map['cardNumber'] as int : null,
      imagePath: map['imagePath'] as String,
      income: map['income'] ?? 0,
      expense: map['expense'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
