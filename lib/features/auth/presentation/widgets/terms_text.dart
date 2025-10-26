import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/core/theme/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';

class TermsText extends StatelessWidget {
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  const TermsText({
    super.key,
    required this.onTermsTap,
    required this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'By signing up, you agree to our ',
        style: AppTextStyles.body,
        children: [
          TextSpan(
            text: 'Terms',
            style: AppTextStyles.body.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTermsTap,
          ),
          const TextSpan(
            text: ' and ',
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: AppTextStyles.body.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()..onTap = onPrivacyTap,
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
