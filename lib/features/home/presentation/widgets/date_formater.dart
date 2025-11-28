import 'package:intl/intl.dart';

String formatTime(DateTime date) {
  return DateFormat.jm().format(date);
}

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

String formatDateOrTime(DateTime dt) {
  final now = DateTime.now();

  bool isToday =
      dt.year == now.year && dt.month == now.month && dt.day == now.day;

  if (isToday) {
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  } else {
    return "${dt.day.toString().padLeft(2, '0')} "
        "${_month(dt.month)} "
        "${dt.year}";
  }
}

String _month(int m) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return months[m - 1];
}
