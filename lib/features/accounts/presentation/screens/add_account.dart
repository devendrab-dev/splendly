import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/core/constants/account_types.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/routes/routers.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/core/widgets/amount_input.dart';
import 'package:money_tracker/core/widgets/custom_button.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/accounts/data/models/account_model.dart';
import 'package:money_tracker/features/accounts/data/providers/providers.dart';
import 'package:money_tracker/features/accounts/presentation/widgets/card_number.dart';
import 'package:money_tracker/features/home/presentation/widgets/date_formater.dart';

class AddAccount extends ConsumerStatefulWidget {
  const AddAccount({super.key});

  @override
  ConsumerState<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends ConsumerState<AddAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardController = TextEditingController();
  final TextEditingController balanceController = TextEditingController(
    text: "0",
  );

  final _formKey = GlobalKey<FormState>();
  int? selectedIndex;
  int? optionIndex;

  @override
  void initState() {
    super.initState();
    debugPrint("INIT: AddAccount screen initialized");
    balanceController.addListener(() {
      debugPrint("BALANCE CHANGE: ${balanceController.text}");
      if (balanceController.text == "") {
        balanceController.value = const TextEditingValue(text: "0");
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
  }

  @override
  void dispose() {
    debugPrint("DISPOSE: AddAccount screen disposed");
    nameController.dispose();
    balanceController.dispose();
    cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text(
          "Add new account",
          style: AppTextStyles.appBarTitle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
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
                            builder: (_, ref, __) {
                              final balance = ref.watch(balanceProvider);
                              return FittedBox(
                                child: Text(
                                  balance,
                                  style: AppTextStyles.heading1.copyWith(
                                    fontSize: 54,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 24,
                        bottom: 24 + bottomInset,
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
                              decoration: const InputDecoration(
                                hintText: "Name",
                              ),
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
                                debugPrint(
                                  "ACCOUNT TYPE SELECTED: index=$value",
                                );

                                selectedIndex = value;
                                optionIndex = null;
                                ref.read(selectedLogoProvider.notifier).state =
                                    0;
                                setState(() {});
                              },
                              validator: (value) => value == null
                                  ? "Please select account type"
                                  : null,
                            ),
                            if (selectedIndex != null) ...[
                              const SizedBox(height: 16),
                              DropdownButtonFormField<int>(
                                decoration: const InputDecoration(
                                  hintText: "Select Option",
                                  border: OutlineInputBorder(),
                                ),
                                items: List.generate(
                                  accountTypes[selectedIndex!].options.length,
                                  (index) => DropdownMenuItem<int>(
                                    value: index,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: SvgPicture.asset(
                                            accountTypes[selectedIndex!]
                                                .options[index]
                                                .logo,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          accountTypes[selectedIndex!]
                                              .options[index]
                                              .name,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  debugPrint("OPTION SELECTED: index=$value");

                                  optionIndex = value;
                                  ref
                                          .read(selectedLogoProvider.notifier)
                                          .state =
                                      value ?? 0;
                                  setState(() {});
                                },
                                initialValue: optionIndex,
                                validator: (value) => value == null
                                    ? "Please select option"
                                    : null,
                              ),
                            ],
                            const SizedBox(height: 16),
                            TextField(
                              controller: balanceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [AmountInputFormatter()],
                              decoration: const InputDecoration(
                                counterText: "",
                                hintText: "Balance",
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (selectedIndex == 1)
                              CardNumberField(controller: cardController),
                            const SizedBox(height: 16),
                            CustomButton(
                              title: "Continue",
                              onTap: () async {
                                debugPrint("BUTTON: Continue tapped");
                                if (_formKey.currentState!.validate()) {
                                  String balance = ref.read(balanceProvider);
                                  debugPrint(
                                    "FORM VALID — Saving new account…",
                                  );
                                  await HiveAccount.saveAccount(
                                    AccountModel(
                                      accountId: DateTime.now()
                                          .microsecondsSinceEpoch
                                          .toString(),
                                      accountName: accountTypes[selectedIndex!]
                                          .options[optionIndex!]
                                          .name,
                                      cardNumber: selectedIndex == 1
                                          ? int.tryParse(cardController.text)
                                          : null,
                                      accountType:
                                          accountTypes[selectedIndex!].name,
                                      userName: nameController.text,
                                      balance: parseFormattedBalance(balance),
                                      imagePath: accountTypes[selectedIndex!]
                                          .options[optionIndex!]
                                          .logo,
                                    ),
                                  );
                                  if (!context.mounted) return;
                                  GoRouter.of(
                                    context,
                                  ).push(AppRoutes.successScreen);
                                }
                              },
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
      ),
    );
  }
}
