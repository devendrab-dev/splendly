import 'package:flutter_riverpod/legacy.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/home/presentation/widgets/date_formater.dart';

double parseFormattedBalance(String formattedBalance) {
  String cleaned = formattedBalance.replaceAll(RegExp(r'[^\d.]'), '');
  return double.tryParse(cleaned) ?? 0.0;
}

final balanceProvider = StateProvider<String>((_) {
  return formattedBalance();
});

final accountSelProvider = StateProvider<int>((_) {
  return HiveAccount.getAccountIndex();
});

final selectedLogoProvider = StateProvider<int>((_) => 0);
