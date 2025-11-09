import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:money_tracker/core/constants/app_colors.dart';
import 'package:money_tracker/core/constants/hive_key.dart';
import 'package:money_tracker/core/routes/routers.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';
import 'package:money_tracker/features/onboarding/data/onboard_data.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _finishOnboarding() async {
    var box = Hive.box(HiveKey.boxName);
    await box.put(HiveKey.onBoardSeend, true);
    if (!mounted) return;
    GoRouter.of(context).pushReplacement(AppRoutes.addAccount);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentIndex == onboardData.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: onboardData.length,
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                final item = onboardData[index];
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * 0.55,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.heading1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            item.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.grey600,
                            ),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.15),
                      ],
                    );
                  },
                );
              },
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardData.length,
                  (dotIndex) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 8,
                    width: _currentIndex == dotIndex ? 24 : 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == dotIndex
                          ? AppColors.primary
                          : AppColors.grey300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            if (isLastPage)
              Positioned(
                bottom: 40,
                right: 30,
                child: GestureDetector(
                  onTap: _finishOnboarding,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
