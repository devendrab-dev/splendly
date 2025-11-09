import 'dart:convert';

class AccountModel {
  String accountType;
  String userName;
  double balance;
  int? cardNumber;
  String imagePath;

  AccountModel({
    required this.accountType,
    required this.userName,
    required this.balance,
    required this.imagePath,
    this.cardNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountType': accountType,
      'userName': userName,
      'balance': balance,
      'cardNumber': cardNumber,
      'imagePath': imagePath,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountType: map['accountType'] as String,
      userName: map['userName'] as String,
      balance: map['balance'] as double,
      cardNumber: map['cardNumber'] != null ? map['cardNumber'] as int : null,
      imagePath: map['imagePath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
