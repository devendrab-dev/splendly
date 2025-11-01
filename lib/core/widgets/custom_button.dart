import 'package:flutter/material.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.bgColor = const Color(0xFF7F3DFF),
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.height = 50,
  });

  final String title;
  final VoidCallback? onTap;
  final Color bgColor;
  final Color textColor;
  final double fontSize;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), 
          ),
          textStyle: AppTextStyles.heading2.copyWith(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
