import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:money_tracker/core/constants/app_category.dart';
import 'package:money_tracker/core/widgets/app_message.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/accounts/data/models/account_model.dart';
import 'package:money_tracker/features/transactions/data/hive_storage.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

class TransactionFormProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  late List<AccountModel> accountsList;
  late AccountModel fromAccount;
  late AccountModel toAccount;

  late String category;
  late String iconPath;

  DateTime date = .now();
  TimeOfDay time = .now();

  TransactionFormProvider() {
    accountsList = HiveAccount.getAccountsList().accounts;
    if (accountsList.isNotEmpty) {
      fromAccount = accountsList.first;
      toAccount = fromAccount;
      category = expenseCategories[0].title;
      iconPath = expenseCategories[0].iconPath;
    }
  }

  void setCategory(String value, String icon) {
    category = value;
    iconPath = icon;
    notifyListeners();
  }

  void setFromAccount(AccountModel account) {
    fromAccount = account;
    notifyListeners();
  }

  void setToAccount(AccountModel account) {
    toAccount = account;
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

  void reset() {
    amountCtrl.clear();
    noteCtrl.clear();

    category = expenseCategories[0].title;
    iconPath = expenseCategories[0].iconPath;

    date = .now();
    time = .now();
    if (accountsList.isNotEmpty) {
      fromAccount = accountsList.first;
      toAccount = fromAccount;
    }
    notifyListeners();
  }

  void save(TransactionType type, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      double amount = double.parse(amountCtrl.text.trim());
      if (type == .transfer) {
        if (toAccount.accountId == fromAccount.accountId) {
          showModernSnackBar(
            context: context,
            message: "Can't Transfer amount to Same account",
            type: .error,
          );
          return;
        }
        fromAccount.balance -= double.parse(amountCtrl.text.trim());
        toAccount.balance += double.parse(amountCtrl.text.trim());
        await HiveAccount.transferAmount(fromAccount, toAccount);
      } else if (type == .income) {
        fromAccount.balance += amount;
        fromAccount.income += amount;
      } else {
        fromAccount.balance -= amount;
        fromAccount.expense += amount;
      }
      await HiveAccount.updateBalance(fromAccount);
      DateTime finalDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      final uTime = DateTime.now().millisecondsSinceEpoch;
      final random = (uTime % 9999).toString();

      TransactionModel model = TransactionModel(
        id: "TXN$uTime$random",
        transactionType: type,
        amount: double.parse(amountCtrl.text.trim()),
        category: category,
        iconPath: iconPath,
        fromAccountId: fromAccount.accountId,
        transferAccountId: toAccount.accountId != fromAccount.accountId
            ? toAccount.accountId
            : null,
        note: noteCtrl.text.trim().isEmpty ? null : noteCtrl.text.trim(),
        dateTime: finalDateTime,
      );
      await HiveTransaction.saveTransaction(model);
      debugPrint(
        "Saved Transaction => "
        "\nid: TXN$uTime$random"
        "\nType: $type"
        "\nAmount: ${model.amount}"
        "\nCategory: ${model.category}"
        "\nFrom AccountId: ${model.fromAccountId}"
        "\nTo AccountId: ${model.transferAccountId}"
        "\nNote: ${model.note}"
        "\nDateTime: ${model.dateTime.toIso8601String()}"
        "\n-------------------------------",
      );
      if (!context.mounted) return;
      showModernSnackBar(
        context: context,
        message: "Transaction completed",
        type: .success,
      );
    }
  }

  @override
  void dispose() {
    amountCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }
}

final transactionFormProvider = ChangeNotifierProvider.autoDispose(
  (ref) => TransactionFormProvider(),
);
