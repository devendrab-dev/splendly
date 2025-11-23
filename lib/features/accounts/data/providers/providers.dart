import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';

String formattedBalance({String? balance}) {
  final value = double.tryParse(balance ?? "0") ?? 0;
  final formatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );
  return formatter.format(value);
}

String doubleToStringBalance(double balance) {
  final formatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );
  return formatter.format(balance);
}

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
