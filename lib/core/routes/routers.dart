import 'package:go_router/go_router.dart';
import 'package:money_tracker/features/accounts/data/hive_helper.dart';
import 'package:money_tracker/features/accounts/presentation/screens/add_account.dart';
import 'package:money_tracker/features/accounts/presentation/screens/success.dart';
import 'package:money_tracker/features/home/presentation/screens/home_screen.dart';
import 'package:money_tracker/features/onboarding/presentation/screens/onboardscreen.dart';

class AppRoutes {
  static const String onboard = "/onboard";

  static const String loginPage = "/auth/login";
  static const String signupPage = "/auth/signup";

  static const String addAccount = "/account/add";
  static const String successScreen = "/account/success";

  static const String homeScreen = "/home";
}

final appRouter = GoRouter(
  initialLocation: HiveAccount.totalAccount() != 0
      ? AppRoutes.homeScreen
      : AppRoutes.onboard,
  routes: [
    GoRoute(
      path: AppRoutes.onboard,
      builder: (context, state) => const OnBoardPage(),
    ),
    GoRoute(
      path: "/account",
      builder: (context, state) => const AddAccount(),
      routes: [
        GoRoute(path: "add", builder: (context, state) => const AddAccount()),
        GoRoute(
          path: "success",
          builder: (context, state) => const SuccessScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
