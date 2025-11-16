import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/core/constants/app_assets.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/routes/routers.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/accounts/data/models/account_model.dart';
import 'package:money_tracker/features/accounts/data/providers/providers.dart';
import 'package:money_tracker/features/home/presentation/widgets/custom_card.dart';
import 'package:money_tracker/features/home/presentation/widgets/transaction_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AccountModel> accounts = [];
  bool _isLoading = true;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  void loadAccounts() {
    accounts = HiveAccount.getAccountsList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            GoRouter.of(context).push(AppRoutes.transactionScreen),
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: _isLoading
              ? Center(child: CircularProgressIndicator.adaptive())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Account Balance",
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        formattedBalance(
                          balance: accounts[0].balance.toString(),
                        ),
                        style: AppTextStyles.heading1,
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          CustomCard(
                            type: "INCOME",
                            iconPath: AppAssets.income,
                            ruppee: formattedBalance(
                              balance: accounts[0].income.toString(),
                            ),
                            color: AppColors.green,
                          ),
                          SizedBox(width: 12),
                          CustomCard(
                            type: "EXPENSE",
                            iconPath: AppAssets.expense,
                            ruppee: formattedBalance(
                              balance: accounts[0].expense.toString(),
                            ),
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
