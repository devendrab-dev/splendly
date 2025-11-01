import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/core/providers/router_provider.dart';
import 'package:money_tracker/core/theme/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/core/widgets/custom_button.dart';
import 'package:money_tracker/features/onboarding/data/onboard_data.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                itemCount: onboardData.length,
                onPageChanged: (value) {
                  _currentIndex = value;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.asset(onboardData[index].image),
                      ),
                      Text(
                        onboardData[index].title,
                        style: AppTextStyles.heading1,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        onboardData[index].description,
                        style: AppTextStyles.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardData.length, (index) {
                return AnimatedContainer(
                  margin: EdgeInsets.all(4),
                  height: 12,
                  width: _currentIndex == index ? 24 : 12,
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _currentIndex == index
                        ? AppColors.primary
                        : AppColors.inactiveColor,
                  ),
                );
              }),
            ),
            SizedBox(height: 25),
            CustomButton(
              onTap: () => GoRouter.of(context).go(AppRoutes.signupPage),
              title: "Sign Up",
              textColor: AppColors.whiteColor,
              bgColor: AppColors.primary,
            ),
            SizedBox(height: 12),
            CustomButton(
              onTap: () => GoRouter.of(context).go(AppRoutes.loginPage),
              title: "Log In",
              textColor: AppColors.primary,
              bgColor: AppColors.primaryLight,
            ),
            SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}
