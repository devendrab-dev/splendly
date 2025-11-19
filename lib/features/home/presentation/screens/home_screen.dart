import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/core/constants/app_assets.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/accounts/data/models/account_model.dart';
import 'package:money_tracker/features/accounts/data/providers/providers.dart';
import 'package:money_tracker/features/home/presentation/widgets/custom_card.dart';
import 'package:money_tracker/features/home/presentation/widgets/transaction_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<AccountModel> accounts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  void loadAccounts() {
    accounts = HiveAccount.getAccountsList().accounts;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int accountIndex = ref.watch(accountSelProvider);
    return SafeArea(
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
                        balance: accounts[accountIndex].balance.toString(),
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
                            balance: accounts[accountIndex].income.toString(),
                          ),
                          color: AppColors.green,
                        ),
                        SizedBox(width: 12),
                        CustomCard(
                          type: "EXPENSE",
                          iconPath: AppAssets.expense,
                          ruppee: formattedBalance(
                            balance: accounts[accountIndex].expense.toString(),
                          ),
                          color: AppColors.error,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    TransactionList(
                      accountId: accounts[accountIndex].accountId,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
