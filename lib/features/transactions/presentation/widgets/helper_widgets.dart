import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/core/constants/app_category.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/accounts/data/models/account_model.dart';
import 'package:money_tracker/features/transactions/data/providers/handle_transaction.dart';

Future<void> showPaymentPicker(
  BuildContext context,
  WidgetRef ref, {
  bool toAccount = false,
}) {
  List<AccountModel> accounts = HiveAccount.getAccountsList().accounts;
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
                padding: const .all(20),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text("Select Payment", style: AppTextStyles.heading3),
                        IconButton(
                          onPressed: () => GoRouter.of(context).pop(),
                          icon: const Icon(
                            Icons.close,
                            fontWeight: .bold,
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
                          return Container(
                            padding: .symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: .all(
                                width: 2,
                                color: AppColors.borderColor,
                              ),
                              borderRadius: .circular(10),
                            ),
                            child: ListTile(
                              leading: Container(
                                height: 30,
                                width: 40,
                                clipBehavior: .antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: .circular(6),
                                ),
                                child: Image.asset(
                                  accounts[index].imagePath,
                                  fit: .fill,
                                ),
                              ),
                              title: Text(accounts[index].accountType),
                              trailing: RadioGroup<int>(
                                groupValue: radioValue,
                                onChanged: (value) {
                                  setState(() => radioValue = value ?? 0);
                                  final controller = ref.read(
                                    transactionFormProvider,
                                  );
                                  if (toAccount) {
                                    controller.setToAccount(accounts[index]);
                                  } else {
                                    controller.setFromAccount(accounts[index]);
                                  }
                                },
                                child: Radio(value: index),
                              ),
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

Future<AppCategory?> showCategoryPicker(
  BuildContext context,
  WidgetRef ref,
  List<AppCategory> list,
) {
  return showModalBottomSheet<AppCategory>(
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
                    itemCount: list.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          ref
                              .read(transactionFormProvider)
                              .setCategory(item.title, item.iconPath);
                          GoRouter.of(context).pop();
                        },
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

Widget rowTile({
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
