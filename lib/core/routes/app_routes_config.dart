import 'package:go_router/go_router.dart';
import 'package:gramify/auth/presentation/login_res_page.dart';
import 'package:gramify/auth/presentation/signup_res_page.dart';
import 'package:gramify/core/routes/app_routes_const.dart';
import 'package:gramify/home/presentation/home_page.dart';
import 'package:gramify/main.dart';

class MyAppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRoutesConstant.defaultRouteName,
        path: '/',
        builder: (context, state) => const Gramify(),
      ),
      GoRoute(
        name: MyAppRoutesConstant.loginRouteName,
        path: '/login',
        builder: (context, state) => const LoginResPage(),
      ),
      GoRoute(
        name: MyAppRoutesConstant.signupRouteName,
        path: '/signup',
        builder: (context, state) => const SignupResPage(),
      ),
      GoRoute(
        name: MyAppRoutesConstant.homeRouteName,
        path: '/home/:userId/:username',
        builder:
            (context, state) => HomePage(
              userID: state.pathParameters['userId']!,
              username: state.pathParameters['username']!,
            ),
      ),
    ],
  );
}
