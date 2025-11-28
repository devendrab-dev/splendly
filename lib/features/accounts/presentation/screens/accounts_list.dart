import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:money_tracker/core/routes/routers.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/accounts/data/models/account_model.dart';
import 'package:money_tracker/features/accounts/data/providers/providers.dart';
import 'package:money_tracker/features/home/presentation/widgets/date_formater.dart';

class AccountsList extends StatefulWidget {
  const AccountsList({super.key});

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  AccountResult accountResult = AccountResult(accounts: [], total: 0);

  @override
  void initState() {
    accountResult = HiveAccount.getAccountsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Accounts", style: AppTextStyles.appBarTitle)),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              _buildTotalBalance(
                context,
                doubleToStringBalance(accountResult.total),
              ),
              const SizedBox(height: 20),
              Text(
                "Your Accounts",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: accountResult.accounts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _buildAccountCard(
                    context,
                    id: accountResult.accounts[index].accountId,
                    index: index,
                    image: accountResult.accounts[index].imagePath,
                    name: accountResult.accounts[index].accountName,
                    balance: doubleToStringBalance(
                      accountResult.accounts[index].balance,
                    ),
                    color: Colors.orange,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          GoRouter.of(context).push(AppRoutes.addAccount);
        },
        icon: const Icon(LucideIcons.plus),
        label: Text("Account"),
      ),
    );
  }

  Widget _buildTotalBalance(BuildContext context, String balance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Balance",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            balance,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard(
    BuildContext context, {
    required int index,
    required String id,
    required String image,
    required String name,
    required String balance,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 3),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(image, height: 48, width: 48),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  balance,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              int groupValue = ref.watch(accountSelProvider);
              return RadioGroup(
                groupValue: groupValue,
                onChanged: (value) async {
                  ref.read(accountSelProvider.notifier).state = value ?? 0;
                  await HiveAccount.selectedAccount(id);
                },
                child: Radio(value: index),
              );
            },
          ),
        ],
      ),
    );
  }
}
