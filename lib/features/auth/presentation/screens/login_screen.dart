import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/core/enums.dart';
import 'package:gramify/core/routes/go_routes.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/core/widgets/app_filled_button.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';
import 'package:gramify/core/widgets/app_text_field.dart';
import 'package:gramify/core/widgets/gsnack.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_events.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_states.dart';
import 'package:gramify/features/auth/presentation/widgets/screen_switch_text_btn.dart';
import 'package:gramify/features/auth/presentation/widgets/sso_button.dart';
import 'package:gramify/features/auth/presentation/widgets/terms_and_condition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEvent(email: _emailController.text.trim(), password: _passwordController.text.trim()));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: BlocConsumer<AuthBloc, AuthStates>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            context.goNamed(GoRoutes.wrapperRoute);
          }
          if (state is AuthErrorState) {
            gSnack(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodyxSmall, horizontal: AppSpacing.bodyxLarge),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - AppSpacing.bodyxSmall * 2),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Gap(AppSpacing.componentLarge),
                          Text('Log in Your account', style: AppTextStyles.titleLarge().copyWith(fontWeight: FontWeight.bold)),
                          const Gap(AppSpacing.bodymedium),
                          AppTextField(
                            hintText: 'Email Address',
                            controller: _emailController,
                            inputType: TextInputType.emailAddress,
                            validator: (value) => Utils.validateTextFieldInput(Validator.email, value),
                          ),
                          const Gap(AppSpacing.bodyxLarge),
                          AppTextField(
                            hintText: 'Password',
                            controller: _passwordController,
                            suffixIcon: FontAwesomeIcons.eye,
                            obsecure: true,
                            validator: (value) => Utils.validateTextFieldInput(Validator.password, value),
                          ),
                          const Gap(AppSpacing.bodyxLarge),
                          Center(child: AppFilledButton(text: 'Log in', onTap: _onLogin)),
                          const Gap(AppSpacing.bodymedium),
                          screenSwitchTextBtn("Forgot your password?", "Reset password", () {}),
                          Center(child: Text('OR', style: AppTextStyles.bodyLarge().copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.bold))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [kSsoButton(icon: FontAwesomeIcons.google), const Gap(AppSpacing.bodyLarge), kSsoButton(icon: FontAwesomeIcons.facebook)],
                          ),
                          const Gap(AppSpacing.bodymedium),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [termsAndCondition('By logging in, you agree to our ')]),
                          const Gap(AppSpacing.bodyLarge),
                          screenSwitchTextBtn("Dont't have an Account?", "Sign Up", () => context.goNamed(GoRoutes.registerRoute)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
