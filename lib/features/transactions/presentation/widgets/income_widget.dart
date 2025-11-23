import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/core/constants/app_category.dart';
import 'package:money_tracker/core/widgets/amount_input.dart';
import 'package:money_tracker/features/transactions/data/providers/handle_transaction.dart';
import 'package:money_tracker/features/transactions/presentation/widgets/helper_widgets.dart';

class IncomeWidget extends ConsumerWidget {
  const IncomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(transactionFormProvider);
    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Expanded(
                child: rowTile(
                  icon: Icons.calendar_today_outlined,
                  title: DateFormat("d MMM yyyy").format(form.date),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: form.date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      form.setDate(picked);
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: rowTile(
                  icon: Icons.access_time_outlined,
                  title: form.time.format(context),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: form.time,
                    );
                    if (picked != null) {
                      form.setTime(picked);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: .only(left: 4, bottom: 6),
            child: Text(
              "Amount",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          Row(
            children: [
              const Text(
                "₹",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Form(
                  key: form.formKey,
                  child: TextFormField(
                    controller: form.amountCtrl,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter amount";
                      }
                      return null;
                    },
                    keyboardType: const .numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [AmountInputFormatter()],
                    style: const TextStyle(fontSize: 30),
                    decoration: const InputDecoration(
                      border: .none,
                      isDense: true,
                      hintText: "0",
                      hintStyle: TextStyle(fontSize: 30),
                      suffixIcon: Icon(Icons.calculate_outlined),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          rowTile(
            icon: Icons.category_outlined,
            title: "Category",
            subtitle: form.category,
            onTap: () async =>
                showCategoryPicker(context, ref, incomeCategories),
          ),
          const Divider(),
          rowTile(
            icon: Icons.account_balance_wallet_outlined,
            title: "Payment mode",
            subtitle: form.fromAccount.accountType,
            onTap: () async => showPaymentPicker(context, ref),
          ),
          const Divider(height: 30),
          const Text(
            "Other details",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: form.noteCtrl,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Write a note",
              prefixIcon: const Icon(Icons.notes_outlined),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: .circular(12),
                borderSide: .none,
              ),
            ),
          ),
          // const SizedBox(height: 20),
          // _rowTile(
          //   icon: Icons.attachment_outlined,
          //   title: "Add attachment",
          //   onTap: () {},
          // ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
