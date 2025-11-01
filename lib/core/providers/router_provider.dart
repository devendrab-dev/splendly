import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/features/accounts/presentation/screens/add_account.dart';
import 'package:money_tracker/features/auth/presentation/screens/login.dart';
import 'package:money_tracker/features/auth/presentation/screens/signup.dart';
import 'package:money_tracker/features/home/presentation/screens/home_screen.dart';
import 'package:money_tracker/features/onboarding/presentation/screens/onboardscreen.dart';

class AppRoutes {
  static const String onboard = "/onboard";
  
  static const String loginPage = "/auth/login";
  static const String signupPage = "/auth/signup";

  static const String addAccount = "/account/add";
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/onboard",
    routes: [
      GoRoute(
        path: "/onboard",
        builder: (context, state) => const OnBoardPage(),
      ),
      GoRoute(
        path: "/auth",
        redirect: (_, __) => "/auth/login",
        routes: [
          GoRoute(
            path: "login",
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: "signup",
            builder: (context, state) => const SignUpPage(),
          ),
        ],
      ),
      GoRoute(
        path: "/account",
        redirect: (_, __) => "/account/add",
        routes: [
          GoRoute(path: "add", builder: (context, state) => const AddAccount()),
          // GoRoute(
          //   path: "remove",
          //   builder: (context, state) => const RemoveAccount(),
          // ),
        ],
      ),
      GoRoute(path: "/home", builder: (context, state) => const HomeScreen()),
    ],
  );
});
