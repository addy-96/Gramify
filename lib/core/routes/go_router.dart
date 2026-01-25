import 'package:go_router/go_router.dart';
import 'package:gramify/core/routes/go_routes.dart';
import 'package:gramify/features/auth/presentation/screens/login_screen.dart';
import 'package:gramify/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:gramify/features/auth/presentation/screens/register_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen(), name: GoRoutes.onboardingRoute),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen(), name: GoRoutes.registerRoute),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen(), name: GoRoutes.loginRoute),
  ],
);
