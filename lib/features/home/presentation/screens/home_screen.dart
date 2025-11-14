import 'package:flutter/material.dart';
import 'package:money_tracker/core/constants/app_assets.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/accounts/data/providers/providers.dart';
import 'package:money_tracker/features/home/presentation/widgets/custom_card.dart';
import 'package:money_tracker/features/home/presentation/widgets/transaction_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Account Balance",
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text("₹500.00", style: AppTextStyles.heading1),
                SizedBox(height: 12),
                Row(
                  children: [
                    CustomCard(
                      type: "INCOME",
                      iconPath: AppAssets.income,
                      ruppee: formattedBalance(balance: "234567897"),
                      color: AppColors.green,
                    ),
                    SizedBox(width: 12),
                    CustomCard(
                      type: "EXPENSE",
                      iconPath: AppAssets.expense,
                      ruppee: formattedBalance(balance: "11250"),
                      color: AppColors.error,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                TransactionList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
