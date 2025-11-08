import 'package:flutter/material.dart';
import 'package:money_tracker/core/constants/account_types.dart';
import 'package:money_tracker/core/theme/app_colors.dart';
import 'package:money_tracker/core/theme/app_input_decoration.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/core/widgets/custom_button.dart';
import 'package:money_tracker/features/accounts/presentation/widgets/card_number.dart';
import 'package:intl/intl.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    balanceController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    balanceController.dispose();
    super.dispose();
  }

  String get formattedBalance {
    final value = double.tryParse(balanceController.text.trim()) ?? 0;
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.primary,
        title: Text(
          "Add new account",
          style: AppTextStyles.appBarTitle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Balance",
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.borderColor,
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, anim) =>
                              FadeTransition(opacity: anim, child: child),
                          child: Text(
                            formattedBalance,
                            key: ValueKey(formattedBalance),
                            style: AppTextStyles.heading1.copyWith(
                              fontSize: 54,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: AppInputDecoration.textField(
                            hintText: "Name",
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: DropdownMenu<int>(
                            width: double.infinity,
                            hintText: "Account Type",
                            inputDecorationTheme: InputDecorationTheme(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: AppColors.hintText,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onSelected: (value) {
                              setState(() => selectedIndex = value);
                            },
                            dropdownMenuEntries: List.generate(
                              accountTypes.length,
                              (index) {
                                return DropdownMenuEntry<int>(
                                  value: index,
                                  label: accountTypes[index].name,
                                );
                              },
                            ),
                          ),
                        ),
                        if (selectedIndex != null)
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: List.generate(
                                    accountTypes[selectedIndex!].logo.length,
                                    (index) {
                                      return Container(
                                        height: 42,
                                        width: 62,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.borderColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Image.asset(
                                          accountTypes[selectedIndex!]
                                              .logo[index],
                                          height: double.infinity,
                                          width: double.infinity,
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: balanceController,
                          keyboardType: TextInputType.number,
                          decoration: AppInputDecoration.textField(
                            hintText: "Balance",
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (selectedIndex == 1) const CardNumberField(),
                        const SizedBox(height: 16),
                        CustomButton(onTap: () {}, title: "Continue"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
