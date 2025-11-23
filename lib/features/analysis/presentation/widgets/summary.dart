import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

class SummaryWidget extends StatelessWidget {
  final SummaryData data;

  const SummaryWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final stats = {
      "Total Transactions": data.totalTransactions,
      "Average Transaction": "₹${data.avgTransactions.toStringAsFixed(2)}",
      "Total Amount": "₹${data.totalAmount.toStringAsFixed(2)}",
      "Max Transaction": "₹${data.maxTransaction.toStringAsFixed(2)}",
      "Min Transaction": "₹${data.minTransaction.toStringAsFixed(2)}",
      "Total Income": "₹${data.totalIncome.toStringAsFixed(2)}",
      "Total Expense": "₹${data.totalExpense.toStringAsFixed(2)}",
      "Highest Expense Category": data.maxSpentExpenseCategory,
      "Highest Income Category": data.maxSpentIcomeCategory,
    };

    return Container(
      padding: const .all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: .circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            "Summary",
            style: GoogleFonts.inter(
              fontWeight: .w600,
              fontSize: 18,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          ...stats.entries.map(
            (e) => Padding(
              padding: const .symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      e.key,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: .w500,
                      ),
                    ),
                  ),
                  Text(
                    e.value.toString(),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: .w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
