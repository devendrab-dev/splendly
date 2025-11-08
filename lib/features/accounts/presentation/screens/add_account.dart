import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/core/constants/account_types.dart';
import 'package:money_tracker/core/theme/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/core/widgets/custom_button.dart';
import 'package:money_tracker/core/widgets/toast_message.dart';
import 'package:money_tracker/features/accounts/data/providers/balance_provider.dart';
import 'package:money_tracker/features/accounts/presentation/widgets/card_number.dart';

class AddAccount extends ConsumerStatefulWidget {
  const AddAccount({super.key});

  @override
  ConsumerState<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends ConsumerState<AddAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController balanceController = TextEditingController(
    text: "0",
  );
  final _formKey = GlobalKey<FormState>();
  int? selectedIndex;

  @override
  void initState() {
    balanceController.addListener(() {
      if (balanceController.text == "") {
        balanceController.value = TextEditingValue(text: "0");
        return;
      }
      if (balanceController.text.length > 1 &&
          balanceController.text.startsWith('0')) {
        final newText = balanceController.text.replaceFirst(RegExp(r'^0+'), '');
        balanceController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
      ref.read(balanceProvider.notifier).state = formattedBalance(
        balance: balanceController.text.trim(),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
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
                        Consumer(
                          builder: (_, ref, _) {
                            final balance = ref.watch(balanceProvider);
                            return Text(
                              balance,
                              style: AppTextStyles.heading1.copyWith(
                                fontSize: 54,
                                color: AppColors.whiteColor,
                              ),
                            );
                          },
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(hintText: "Name"),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please fill this field";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<int>(
                            decoration: const InputDecoration(
                              hintText: "Account Type",
                              border: OutlineInputBorder(),
                            ),
                            items: List.generate(
                              accountTypes.length,
                              (index) => DropdownMenuItem<int>(
                                value: index,
                                child: Text(accountTypes[index].name),
                              ),
                            ),
                            onChanged: (value) {
                              selectedIndex = value;
                              setState(() {});
                            },
                            validator: (value) => value == null
                                ? "Please select account type"
                                : null,
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
                            maxLength: 5,
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: "Balance",
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (selectedIndex == 1) const CardNumberField(),
                          const SizedBox(height: 16),
                          CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                showToast(message: "message");
                              }
                            },
                            title: "Continue",
                          ),
                        ],
                      ),
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
