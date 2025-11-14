import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/transactions/data/providers/transaction_type.dart';
import 'package:money_tracker/features/transactions/presentation/widgets/expense_widget.dart';
import 'package:money_tracker/features/transactions/presentation/widgets/segement_button.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});

  final List<String> labels = ["Expense", "Income", "Transfer"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text("Transactions", style: AppTextStyles.appBarTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Save"),
        onPressed: () {},
        icon: Icon(LucideIcons.saveAll),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedSegmentedControl(labels: labels),
            Consumer(
              builder: (context, ref, child) {
                int type = ref.watch(transactionTypeProvider);
                if (type == 0) {
                  return ExpenseWidget();
                } else if (type == 1) {
                  return Container(child: Text("income"));
                } else {
                  return Container(child: Text("transfer"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
