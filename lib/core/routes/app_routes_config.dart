import 'package:go_router/go_router.dart';
import 'package:gramify/features/auth/presentation/mobile/forogot_pass_page.dart';
import 'package:gramify/features/auth/presentation/login_res_page.dart';
import 'package:gramify/features/auth/presentation/signup_res_page.dart';
import 'package:gramify/core/routes/app_routes_const.dart';
import 'package:gramify/main.dart';
import 'package:gramify/main_presentaiton/wrapper.dart';

class MyAppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRoutesConstant.defaultRouteName,
        path: '/',
        builder: (context, state) => const Gramify(),
        routes: const [
          
        ]
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
        name: MyAppRoutesConstant.wrapperRouteName,
        path: '/wrapper/:userId',
        builder:
            (context, state) =>
                WrapperRes(userID: state.pathParameters['userId']!),
      ),
      GoRoute(
        name: MyAppRoutesConstant.forgotPassRouteName,
        path: '/forgot_password',
        builder: (context, state) => const ForogotPassResPage(),
      ),
    ],
  );
}
