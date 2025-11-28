import 'package:flutter/material.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:intl/intl.dart';

class MonthNavigationWidget extends StatelessWidget {
  final int monthOffset;
  final ValueChanged<int> onChanged;

  const MonthNavigationWidget({
    super.key,
    required this.monthOffset,
    required this.onChanged,
  });

  String getMonthLabel(int offset) {
    final now = DateTime.now();
    final targetMonth = DateTime(now.year, now.month - offset, 1);
    return offset == 0
        ? "This Month"
        : "${DateFormat.MMMM().format(targetMonth)} ${targetMonth.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => onChanged(monthOffset + 1), 
        ),
        Text(getMonthLabel(monthOffset), style: AppTextStyles.body),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: monthOffset > 0 ? () => onChanged(monthOffset - 1) : null,
        ),
      ],
    );
  }
}
