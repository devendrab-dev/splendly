import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/core/constants/app_category.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/core/widgets/amount_input.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/accounts/data/models/account_model.dart';
import 'package:money_tracker/features/transactions/data/providers/handle_transaction.dart';

class ExpenseWidget extends ConsumerWidget {
  const ExpenseWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(expenseFormProvider);
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
                child: _rowTile(
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
                  key: form.formKey,
                  child: TextFormField(
                    controller: form.amountCtrl,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
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
            subtitle: form.category,
            onTap: () async => showCategoryPicker(context),
          ),
          const Divider(),
          _rowTile(
            icon: Icons.account_balance_wallet_outlined,
            title: "Payment mode",
            subtitle: form.paymentMode,
            onTap: () async => showPaymentPicker(context),
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
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
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

  Future<ExpenseCategory?> showCategoryPicker(BuildContext context) {
    return showModalBottomSheet<ExpenseCategory>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.55,
          maxChildSize: 0.85,
          minChildSize: 0.40,
          builder: (_, controller) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Category", style: AppTextStyles.heading3),
                      IconButton(
                        onPressed: () => GoRouter.of(context).pop(),
                        icon: Icon(Icons.close, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      controller: controller,
                      itemCount: expenseCategories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                            childAspectRatio: 0.75,
                          ),
                      itemBuilder: (context, index) {
                        final item = expenseCategories[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => GoRouter.of(context).pop(),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: item.color.withValues(
                                  alpha: 0.15,
                                ),
                                child: SvgPicture.asset(
                                  item.iconPath,
                                  height: 28,
                                  width: 28,
                                  colorFilter: ColorFilter.mode(
                                    item.color,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item.title,
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> showPaymentPicker(BuildContext context) {
    List<AccountModel> accounts = HiveAccount.getAccountsList();
    int radioValue = 0;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.55,
              maxChildSize: 0.85,
              minChildSize: 0.40,
              builder: (_, controller) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Payment", style: AppTextStyles.heading3),
                          IconButton(
                            onPressed: () => GoRouter.of(context).pop(),
                            icon: const Icon(
                              Icons.close,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          controller: controller,
                          itemCount: accounts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                child: Container(
                                  height: 30,
                                  width: 136,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Image.asset(
                                    accounts[index].imagePath,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              title: Text(accounts[index].accountType),
                              trailing: RadioGroup<int>(
                                groupValue: radioValue,
                                onChanged: (value) {
                                  setState(() {
                                    radioValue = value ?? 0;
                                  });
                                },
                                child: Radio(value: index),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
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
