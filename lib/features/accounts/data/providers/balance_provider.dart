import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';

String formattedBalance({String? balance}) {
  final value = double.tryParse(balance ?? "0") ?? 0;
  final formatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );
  return formatter.format(value);
}

final balanceProvider = StateProvider<String>((_) {
  return formattedBalance();
});
