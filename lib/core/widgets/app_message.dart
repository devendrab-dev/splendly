import 'package:flutter/material.dart';
import 'package:money_tracker/core/constants/app_colors.dart';

enum MessageType { error, success, warning, information }

void showModernSnackBar({
  required BuildContext context,
  required String message,
  required MessageType type,
  IconData? icon,
  Duration duration = const Duration(seconds: 3),
}) {
  Color backgroundColor;
  IconData defaultIcon;

  switch (type) {
    case .success:
      backgroundColor = AppColors.success;
      defaultIcon = Icons.check_circle;
      break;
    case .error:
      backgroundColor = AppColors.error;
      defaultIcon = Icons.error_outline;
      break;
    case .warning:
      backgroundColor = AppColors.warning;
      defaultIcon = Icons.warning_amber_rounded;
      break;
    case .information:
      backgroundColor = AppColors.information;
      defaultIcon = Icons.info_outline;
      break;
  }

  final snackBar = SnackBar(
    behavior: .floating,
    elevation: 6,
    backgroundColor: AppColors.transparent,
    duration: duration,
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon ?? defaultIcon, color: AppColors.whiteColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 14,
                fontWeight: .w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
