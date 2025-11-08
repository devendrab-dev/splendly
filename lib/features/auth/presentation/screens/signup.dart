import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/core/constants/app_assets.dart';
import 'package:money_tracker/core/providers/router_provider.dart';
import 'package:money_tracker/core/theme/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/core/widgets/custom_button.dart';
import 'package:money_tracker/core/widgets/toast_message.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  bool _agreed = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: Text("Sign Up", style: AppTextStyles.appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 38),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.iconInactive,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: _agreed,
                      onChanged: (newValue) {
                        _agreed = newValue ?? false;
                        setState(() {});
                      },
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          text: "By signing up, you agree to the ",
                          style: AppTextStyles.body,
                          children: [
                            TextSpan(
                              text: "Terms of service and Privacy Policy",
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.primary,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (!_agreed) {
                        showToast(message: "Agree to terms and condition");
                        return;
                      }
                    }
                  },
                  title: "Sign Up",
                  bgColor: AppColors.primary,
                  textColor: AppColors.whiteColor,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.inactiveColor,
                        thickness: 1,
                        endIndent: 8,
                      ),
                    ),
                    Text(
                      "or With",
                      style: TextStyle(
                        color: AppColors.inactiveColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.inactiveColor,
                        thickness: 1,
                        indent: 8,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.google),
                      SizedBox(width: 10),
                      Text(
                        "Sign Up with Google",
                        style: AppTextStyles.heading3,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: AppColors.iconInactive),
                    children: [
                      TextSpan(
                        text: "Login",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            GoRouter.of(context).go(AppRoutes.loginPage);
                          },
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
