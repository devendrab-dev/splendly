import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class ExpenseFormController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  String category = "Others";
  String paymentMode = "Cash";

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  void setCategory(String value) {
    category = value;
    notifyListeners();
  }

  void setPaymentMode(String value) {
    paymentMode = value;
    notifyListeners();
  }

  void setDate(DateTime d) {
    date = d;
    notifyListeners();
  }

  void setTime(TimeOfDay t) {
    time = t;
    notifyListeners();
  }

  void save() {
    if (formKey.currentState!.validate()) {
      
    }
  }

  @override
  void dispose() {
    amountCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }
}

final expenseFormProvider = ChangeNotifierProvider.autoDispose(
  (ref) => ExpenseFormController(),
);
