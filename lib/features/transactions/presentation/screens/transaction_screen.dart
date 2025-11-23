import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';
import 'package:money_tracker/features/transactions/data/providers/handle_transaction.dart';
import 'package:money_tracker/features/transactions/data/providers/transaction_type.dart';
import 'package:money_tracker/features/transactions/presentation/widgets/expense_widget.dart';
import 'package:money_tracker/features/transactions/presentation/widgets/income_widget.dart';
import 'package:money_tracker/features/transactions/presentation/widgets/segement_button.dart';
import 'package:money_tracker/features/transactions/presentation/widgets/transfer_widget.dart';

class TransactionScreen extends ConsumerWidget {
  TransactionScreen({super.key});

  final List<String> labels = ["Expense", "Income", "Transfer"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text("Add Transactions", style: AppTextStyles.appBarTitle),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          int type = ref.watch(transactionTypeProvider);
          return FloatingActionButton.extended(
            label: Text("Save"),
            onPressed: () {
              TransactionType value = type == 0
                  ? .expense
                  : type == 1
                  ? .income
                  : .transfer;
              ref.read(transactionFormProvider).save(value, context);
            },
            icon: Icon(LucideIcons.saveAll),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedSegmentedControl(
              labels: labels,
              onChanged: (selectedIndex) {
                ref.read(transactionTypeProvider.notifier).state =
                    selectedIndex;
                ref.read(transactionFormProvider).reset();
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                int type = ref.watch(transactionTypeProvider);
                if (type == 0) {
                  return ExpenseWidget();
                } else if (type == 1) {
                  return IncomeWidget();
                } else {
                  return TransferWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
