import 'package:flutter/material.dart';
import 'package:money_tracker/core/constants/app_assets.dart';
import 'package:money_tracker/core/theme/app_colors.dart';
import 'package:money_tracker/core/theme/app_input_decoration.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/core/widgets/custom_button.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
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
      body: Column(
        children: [
          Expanded(flex: 2, child: Container()),
          Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: AppInputDecoration.textField(hintText: "Name"),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: DropdownMenu<String>(
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
                    onSelected: (value) {},
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "Bank", label: "Bank"),
                      DropdownMenuEntry(value: "GPay", label: "GPay"),
                      DropdownMenuEntry(value: "Card", label: "Card"),
                      DropdownMenuEntry(value: "Paytm", label: "Paytm"),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Visibility(
                  visible: true,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      Container(
                        height: 42,
                        width: 62,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          AppAssets.google,
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 62,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          AppAssets.google,
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 62,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          AppAssets.google,
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 62,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          AppAssets.google,
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 62,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          AppAssets.google,
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 62,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          AppAssets.google,
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 62,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          AppAssets.google,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                CustomButton(onTap: () {}, title: "Continue"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
