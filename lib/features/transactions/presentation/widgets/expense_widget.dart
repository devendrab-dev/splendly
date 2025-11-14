import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/core/widgets/amount_input.dart';

class ExpenseWidget extends StatefulWidget {
  const ExpenseWidget({super.key});

  @override
  State<ExpenseWidget> createState() => _ExpenseWidgetState();
}

class _ExpenseWidgetState extends State<ExpenseWidget> {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String category = "Others";
  String paymentMode = "Cash";

  @override
  void dispose() {
    amountCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat("d MMM yyyy").format(date);
    final timeText = time.format(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _rowTile(
                  icon: Icons.calendar_today_outlined,
                  title: dateText,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) setState(() => date = picked);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _rowTile(
                  icon: Icons.access_time_outlined,
                  title: timeText,
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: time,
                    );
                    if (picked != null) setState(() => time = picked);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 6),
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
                  key: _formKey,
                  child: TextFormField(
                    controller: amountCtrl,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter amount";
                      }
                      return null;
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [AmountInputFormatter()],
                    style: const TextStyle(fontSize: 30),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
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
          _rowTile(
            icon: Icons.category_outlined,
            title: "Category",
            subtitle: category,
            onTap: () {},
          ),
          const Divider(),
          _rowTile(
            icon: Icons.account_balance_wallet_outlined,
            title: "Payment mode",
            subtitle: paymentMode,
            onTap: () {},
          ),
          const Divider(height: 30),
          const Text(
            "Other details",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: noteCtrl,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Write a note",
              prefixIcon: const Icon(Icons.notes_outlined),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _rowTile(
            icon: Icons.attachment_outlined,
            title: "Add attachment",
            onTap: () {},
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _rowTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.grey.shade700),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
