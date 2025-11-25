import 'package:flutter/material.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/home/presentation/widgets/transaction_tile_widget.dart';
import 'package:money_tracker/features/transactions/data/hive_storage.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key, required this.accountId});

  final String accountId;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<TransactionModel> list = [];
  @override
  void initState() {
    list = HiveTransaction.getTransactionsListById(widget.accountId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text("Recent Transactions", style: AppTextStyles.heading2),
            Container(
              padding: const .symmetric(vertical: 6, horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.voilet20,
                borderRadius: .circular(16),
              ),
              child: Text(
                "See All",
                style: AppTextStyles.body.copyWith(
                  fontWeight: .w600,
                  color: AppColors.voilet,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        list.isEmpty
            ? SizedBox(child: Text("No Transaction Done"))
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(list[index].id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) async {
                      await HiveTransaction.deleteTransactionById(
                        list[index].id,
                      );
                      setState(() {
                        list.removeAt(index);
                      });
                    },
                    child: TransactionTile(model: list[index]),
                  );
                },
              ),
        SizedBox(height: 75),
      ],
    );
  }
}
