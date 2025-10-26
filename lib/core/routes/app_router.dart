import 'package:go_router/go_router.dart';
import 'package:money_tracker/features/auth/presentation/screens/login.dart';
import 'package:money_tracker/features/auth/presentation/screens/signup.dart';
import 'package:money_tracker/features/onboarding/presentation/screens/onboardscreen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/onboard",
  routes: [
    GoRoute(
      path: "/onboard",
      builder: (context, state) => const OnBoardPage(),
    ),
    GoRoute(
      path: "/signup",
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
