import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker/core/constants/hive_key.dart';
import 'package:money_tracker/features/accounts/data/models/account_model.dart';

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

  static List<AccountModel> getAccountsList() {
    var box = Hive.box(HiveKey.boxName);
    List accountsMapList = box.get(HiveKey.accountData, defaultValue: []);
    return accountsMapList
        .map((map) => AccountModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }

  static int totalAccount() {
    var box = Hive.box(HiveKey.boxName);
    List accountsMapList = box.get(HiveKey.accountData, defaultValue: []);
    return accountsMapList.length;
  }

  static AccountModel? getAccountAt(int index) {
    List<AccountModel> accounts = getAccountsList();
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
    await box.delete(HiveKey.accountData);
  }
}
