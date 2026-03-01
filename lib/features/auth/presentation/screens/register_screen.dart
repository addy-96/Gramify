import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/core/debouncer.dart';
import 'package:gramify/core/enums.dart';
import 'package:gramify/core/routes/go_routes.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/core/widgets/app_filled_button.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';
import 'package:gramify/core/widgets/app_text_field.dart';
import 'package:gramify/core/widgets/app_snack.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_events.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_states.dart';
import 'package:gramify/features/auth/presentation/widgets/screen_switch_text_btn.dart';
import 'package:gramify/features/auth/presentation/widgets/sso_button.dart';
import 'package:gramify/features/auth/presentation/widgets/terms_and_condition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            context.goNamed(GoRoutes.wrapperRoute);
          }
          if (state.errorMessage != null) {
            appSnack(context, state.errorMessage!);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodyxSmall, horizontal: AppSpacing.bodyxLarge),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - AppSpacing.bodyxSmall * 2, // fill screen minus padding
                  ),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Gap(AppSpacing.componentLarge),
                          Text('Create Your account', style: AppTextStyles.titleLarge().copyWith(fontWeight: FontWeight.bold)),
                          AppTextField(
                            onChanged: _onChanged,
                            maxLength: 20,
                            inputType: TextInputType.text,
                            hintText: 'Username',
                            controller: _usernameController,
                            validator: (value) => Utils.validateTextFieldInput(Validator.username, value),
                          ),
                          if (state.usernameStatus == UsernameStatus.checking)
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                            ),
                          if (state.usernameStatus == UsernameStatus.available) const Icon(Icons.check, color: Colors.green),
                          if (state.usernameStatus == UsernameStatus.unavailable) const Icon(Icons.close, color: Colors.red),
                          AppTextField(
                            hintText: 'Email Address',
                            inputType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (value) => Utils.validateTextFieldInput(Validator.email, value),
                          ),
                          AppTextField(
                            maxLength: 10,
                            inputType: TextInputType.number,
                            hintText: 'Phone',
                            controller: _phoneController,
                            validator: (value) => Utils.validateTextFieldInput(Validator.phone, value),
                          ),
                          AppTextField(
                            maxLength: 20,
                            obsecure: true,
                            inputType: TextInputType.text,
                            hintText: 'Password',
                            suffixIcon: FontAwesomeIcons.eye,
                            controller: _passwordController,
                            validator: (value) => Utils.validateTextFieldInput(Validator.password, value),
                          ),
                          const Gap(AppSpacing.bodySmall),
                          Center(child: AppFilledButton(text: 'Sign Up', onTap: _onRegiester)),
                          Center(child: Text('OR', style: AppTextStyles.bodyLarge().copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.bold))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [kSsoButton(icon: FontAwesomeIcons.google), const Gap(AppSpacing.bodyLarge), kSsoButton(icon: FontAwesomeIcons.facebook)],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [termsAndCondition('By signing up, you agree to our ')]),
                          const Gap(AppSpacing.bodySmall),
                          screenSwitchTextBtn("Already have Account?", "Log in", () => context.goNamed(GoRoutes.loginRoute)),
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

  void _onRegiester() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignUpEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phone: _phoneController.text.trim(),
          username: _usernameController.text.trim(),
        ),
      );
    }
  }

  void _onChanged(String value) {
    if (value == "" || value.trim().isEmpty) return;
    _debouncer.run(() {
      context.read<AuthBloc>().add(CheckUsernameAvailablity(username: value));
    });
  }
}
