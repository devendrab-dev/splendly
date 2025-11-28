import 'package:flutter/material.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';

class YearNavigationWidget extends StatelessWidget {
  final int yearOffset;
  final ValueChanged<int> onChanged;

  const YearNavigationWidget({
    super.key,
    required this.yearOffset,
    required this.onChanged,
  });

  String getYearLabel(int offset) {
    final now = DateTime.now();
    final targetYear = now.year - offset;
    return offset == 0 ? "This Year" : "$targetYear";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => onChanged(yearOffset + 1), 
        ),
        Text(getYearLabel(yearOffset), style: AppTextStyles.body),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: yearOffset > 0 ? () => onChanged(yearOffset - 1) : null,
        ),
      ],
    );
  }
}
