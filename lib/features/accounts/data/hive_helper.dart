import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker/core/constants/hive_key.dart';
import 'package:money_tracker/features/accounts/data/models/account_model.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

class HiveAccount {
  static Future<void> saveAccount(AccountModel account) async {
    var box = Hive.box(HiveKey.boxName);
    List accounts = box.get(HiveKey.accountData, defaultValue: []);
    accounts.add(account.toMap());
    await box.put(HiveKey.accountData, accounts);
  }

  static Future<void> saveAccountsList(List<AccountModel> accounts) async {
    var box = Hive.box(HiveKey.boxName);

    List accountsMap = accounts.map((a) => a.toMap()).toList();

    await box.put(HiveKey.accountData, accountsMap);
  }

  static AccountResult getAccountsList() {
    var box = Hive.box(HiveKey.boxName);
    List accountsMapList = box.get(HiveKey.accountData, defaultValue: []);
    double total = 0;
    List<AccountModel> accounts = [];
    for (var ac in accountsMapList) {
      total += ac["balance"];
      accounts.add(AccountModel.fromMap(Map<String, dynamic>.from(ac)));
    }
    return AccountResult(accounts: accounts, total: total);
  }

  static Future<void> updateBalance(AccountModel updated) async {
    var box = Hive.box(HiveKey.boxName);
    List accountsMapList = box.get(HiveKey.accountData, defaultValue: []);
    int index = accountsMapList.indexWhere(
      (m) => m["accountId"] == updated.accountId,
    );
    if (index == -1) return;
    accountsMapList[index] = updated.toMap();
    await box.put(HiveKey.accountData, accountsMapList);
  }

  static Future<void> transferAmount(AccountModel from, AccountModel to) async {
    var box = Hive.box(HiveKey.boxName);

    List accountsMapList = box.get(HiveKey.accountData, defaultValue: []);

    int fromIndex = -1;
    int toIndex = -1;

    for (int i = 0; i < accountsMapList.length; i++) {
      final map = Map<String, dynamic>.from(accountsMapList[i]);

      if (map["accountId"] == from.accountId) fromIndex = i;
      if (map["accountId"] == to.accountId) toIndex = i;
      if (fromIndex != -1 && toIndex != -1) break;
    }
    if (fromIndex == -1 || toIndex == -1) return;
    accountsMapList[fromIndex] = from.toMap();
    accountsMapList[toIndex] = to.toMap();
    await box.put(HiveKey.accountData, accountsMapList);
  }

  static int totalAccount() {
    var box = Hive.box(HiveKey.boxName);
    List accountsMapList = box.get(HiveKey.accountData, defaultValue: []);
    return accountsMapList.length;
  }

  static AccountModel? getAccountAt(int index) {
    List<AccountModel> accounts = getAccountsList().accounts;
    if (index >= 0 && index < accounts.length) {
      return accounts[index];
    }
    return null;
  }

  static int getAccountIndex() {
    var box = Hive.box(HiveKey.boxName);
    List<AccountModel> accounts = getAccountsList().accounts;
    String? selectedId = box.get(HiveKey.selectedAccount);

    if (selectedId == null) return 0;

    int index = accounts.indexWhere((ac) => ac.accountId == selectedId);
    return index;
  }

  static Future<void> selectedAccount(String id) async {
    var box = Hive.box(HiveKey.boxName);
    await box.put(HiveKey.selectedAccount, id);
  }

  static Future<void> deleteAccountAt(int index) async {
    List<AccountModel> accounts = getAccountsList().accounts;
    if (index >= 0 && index < accounts.length) {
      accounts.removeAt(index);
      await saveAccountsList(accounts);
    }
  }

  static Future<void> updateOnDelete({
    required String accountId,
    required TransactionType type,
    required double amount,
  }) async {
    List<AccountModel> accounts = getAccountsList().accounts;
    int index = accounts.indexWhere((a) => a.accountId == accountId);

    if (index == -1) {
      debugPrint("Account not found for update: $accountId");
      return;
    }

    AccountModel acc = accounts[index];
    switch (type) {
      case .expense:
        acc.balance += amount;
        acc.expense -= amount;
        break;
      case .income:
        acc.balance -= amount;
        acc.income -= amount;
        break;
      case .transfer:
        break;
    }

    accounts[index] = acc;
    await saveAccountsList(accounts);
    debugPrint("Account updated after delete: $accountId");
  }

  static Future<void> clearAll() async {
    var box = Hive.box(HiveKey.boxName);
    await box.delete(HiveKey.accountData);
  }
}
