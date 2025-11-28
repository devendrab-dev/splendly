import 'package:flutter/material.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/home/presentation/widgets/transaction_tile_widget.dart';
import 'package:money_tracker/features/transactions/data/hive_storage.dart';
import 'package:money_tracker/features/transactions/data/models/transaction_model.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  List<TransactionModel> list = [];
  @override
  void initState() {
    list = HiveTransaction.getTransactionsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Transactions", style: AppTextStyles.appBarTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: list.isEmpty
              ? SizedBox(child: Text("No Transaction Done"))
              : ListView.builder(
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
                      confirmDismiss: (_) async {
                        debugPrint("❓ [TX] Asking confirmation for delete");

                        final shouldDelete = await _showDeleteDialog(context);
                        debugPrint("🔍 [TX] User response: $shouldDelete");
                        return shouldDelete;
                      },
                      onDismissed: (_) async {
                        debugPrint("🗑 [TX] Deleting permanently");
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
        ),
      ),
    );
  }
}

Future<bool> _showDeleteDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Delete Transaction?"),
            content: const Text(
              "Are you sure want to delete this transaction?",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  debugPrint("❌ [TX] Delete cancelled");
                  Navigator.pop(ctx, false);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  debugPrint("🗑 [TX] Confirm delete");
                  Navigator.pop(ctx, true);
                },
                child: const Text("Delete"),
              ),
            ],
          );
        },
      ) ??
      false;
}
