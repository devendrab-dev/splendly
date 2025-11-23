import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_tracker/core/constants/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.type,
    required this.iconPath,
    required this.ruppee,
    required this.color,
  });

  final String type;
  final String iconPath;
  final String ruppee;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: .all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: .circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              child: SvgPicture.asset(
                iconPath,
                colorFilter: .mode(color, BlendMode.srcIn),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(type, style: TextStyle(color: AppColors.whiteColor)),
                  FittedBox(
                    child: Text(
                      ruppee,
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
