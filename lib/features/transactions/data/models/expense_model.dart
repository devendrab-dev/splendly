class ExpenseModel {
  final String id;
  final String transactionType;
  final double amount;
  final String category;
  final String paymentMode;
  final String note;
  final DateTime dateTime;

  ExpenseModel({
    required this.id,
    required this.transactionType,
    required this.amount,
    required this.category,
    required this.paymentMode,
    required this.note,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "transactionType": transactionType,
    "amount": amount,
    "category": category,
    "paymentMode": paymentMode,
    "note": note,
    "dateTime": dateTime.toIso8601String(),
  };

  factory ExpenseModel.fromMap(Map map) => ExpenseModel(
    id: map["id"],
    transactionType: map["transactionType"],
    amount: map["amount"],
    category: map["category"],
    paymentMode: map["paymentMode"],
    note: map["note"],
    dateTime: DateTime.parse(map["dateTime"]),
  );
}
