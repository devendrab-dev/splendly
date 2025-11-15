import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker/core/constants/hive_key.dart';
import 'package:money_tracker/features/transactions/data/models/expense_model.dart';

class HiveAccount {
  static Future<void> saveAccount(ExpenseModel account) async {
    var box = Hive.box(HiveKey.boxName);
    List accounts = box.get(HiveKey.expenseData, defaultValue: []);
    accounts.add(account.toMap());
    await box.put(HiveKey.expenseData, accounts);
  }

  static Future<void> saveAccountsList(List<ExpenseModel> accounts) async {
    var box = Hive.box(HiveKey.boxName);

    List accountsMap = accounts.map((a) => a.toMap()).toList();

    await box.put(HiveKey.expenseData, accountsMap);
  }

  static List<ExpenseModel> getAccountsList() {
    var box = Hive.box(HiveKey.boxName);
    List accountsMapList = box.get(HiveKey.expenseData, defaultValue: []);
    return accountsMapList
        .map((map) => ExpenseModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }

  static int totalAccount() {
    var box = Hive.box(HiveKey.boxName);
    List accountsMapList = box.get(HiveKey.expenseData, defaultValue: []);
    return accountsMapList.length;
  }

  static ExpenseModel? getAccountAt(int index) {
    List<ExpenseModel> accounts = getAccountsList();
    if (index >= 0 && index < accounts.length) {
      return accounts[index];
    }
    return null;
  }

  static Future<void> deleteAccountAt(int index) async {
    var accounts = getAccountsList();
    if (index >= 0 && index < accounts.length) {
      accounts.removeAt(index);
      await saveAccountsList(accounts);
    }
  }

  static Future<void> clearAll() async {
    var box = Hive.box(HiveKey.boxName);
    await box.delete(HiveKey.expenseData);
  }
}
