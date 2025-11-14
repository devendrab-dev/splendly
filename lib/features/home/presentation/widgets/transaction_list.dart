import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_tracker/core/constants/app_assets.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/accounts/data/providers/providers.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Transactions", style: AppTextStyles.heading2),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.voilet20,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "See All",
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.voilet,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.chipBgColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: SvgPicture.asset(AppAssets.transactions),
              ),
              title: Text("Shopping"),
              subtitle: Text("Buy some grocery"),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formattedBalance(balance: "120"),
                    style: AppTextStyles.heading3.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                  Text(
                    "10:00 AM",
                    style: TextStyle(color: AppColors.secondaryText),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
