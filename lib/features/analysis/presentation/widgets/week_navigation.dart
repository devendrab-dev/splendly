import 'package:flutter/material.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';

class WeekNavigationWidget extends StatelessWidget {
  final int weekOffset;
  final ValueChanged<int> onChanged;

  const WeekNavigationWidget({
    super.key,
    required this.weekOffset,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => onChanged(weekOffset + 1),
        ),
        Text(
          weekOffset == 0
              ? "This Week"
              : "$weekOffset week${weekOffset > 1 ? 's' : ''} ago",
          style: AppTextStyles.body,
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: weekOffset > 0 ? () => onChanged(weekOffset - 1) : null,
        ),
      ],
    );
  }
}
