import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/core/routes/go_routes.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/widgets/app_filled_button.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';
import 'package:gramify/core/widgets/app_text_field.dart';
import 'package:gramify/features/auth/presentation/widgets/screen_switch_text_btn.dart';
import 'package:gramify/features/auth/presentation/widgets/sso_button.dart';
import 'package:gramify/features/auth/presentation/widgets/terms_and_condition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodyxSmall, horizontal: AppSpacing.bodyxLarge),
        child: Column(
          spacing: AppSpacing.componentxMedium,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(AppSpacing.componentLarge),
            Text('Log in Your account', style: AppTextStyles.titleLarge().copyWith(fontWeight: FontWeight.bold)),
            AppTextField(hintText: 'Email Address', controller: _emailController),
            AppTextField(hintText: 'Password', suffixIcon: FontAwesomeIcons.eye, controller: _passwordController),
            const Gap(AppSpacing.bodySmall),
            Center(child: AppFilledButton(text: 'Log in', onTap: () {})),
            screenSwitchTextBtn("Forgot your password?", "Reset password", () {}),
            Center(child: Text('OR', style: AppTextStyles.bodyLarge().copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.bold))),
            Row(children: [kSsoButton(icon: FontAwesomeIcons.google), const Gap(AppSpacing.bodyLarge), kSsoButton(icon: FontAwesomeIcons.facebook)]),
            termsAndCondition('By logging in, you agree to our '),
            const Gap(AppSpacing.bodySmall),
            screenSwitchTextBtn("Dont't have an Account?", "Sign Up", () => context.goNamed(GoRoutes.registerRoute)),
          ],
        ),
      ),
    );
  }
}
