import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/home/presentation/widgets/date_formater.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel model;

  const TransactionTile({super.key, required this.model});

  Color _amountColor(TransactionType type) {
    switch (type) {
      case TransactionType.expense:
        return AppColors.error;
      case TransactionType.income:
        return Colors.green;
      case TransactionType.transfer:
        return Colors.blue;
    }
  }

  String _prefix(TransactionType type) {
    return type == TransactionType.expense ? "-" : "+";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardBg, 
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.chipBgColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: SvgPicture.asset(model.iconPath, height: 26, width: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.category, style: AppTextStyles.heading3),
                if (model.note != null && model.note!.isNotEmpty)
                  Text(
                    model.note!,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.secondaryText,
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${_prefix(model.transactionType)} ${model.amount.toStringAsFixed(2)}",
                style: AppTextStyles.heading3.copyWith(
                  color: _amountColor(model.transactionType),
                ),
              ),
              Text(
                formatTime(model.dateTime), 
                style: TextStyle(color: AppColors.secondaryText, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
