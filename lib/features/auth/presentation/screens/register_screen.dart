import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/widgets/app_filled_button.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';
import 'package:gramify/core/widgets/app_snckbar.dart';
import 'package:gramify/core/widgets/app_text_field.dart';
import 'package:gramify/features/auth/domain/entites/user.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_events.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_states.dart';
import 'package:gramify/features/auth/presentation/widgets/sso_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _onRegiester() {
    context.read<AuthBloc>().add(
      SignUpEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phone: _phoneController.text.trim(),
        username: _usernameController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: BlocConsumer<AuthBloc, AuthStates>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: state.logedInUser)));
          }
          if (state is AuthErrorState) {
            return appSnackBar(context, state.message);
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
                child: Column(
                  spacing: AppSpacing.componentxMedium,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(AppSpacing.componentLarge),
                    Text('Create Your account', style: AppTextStyles.titleMedium().copyWith(fontWeight: FontWeight.bold)),
                    AppTextField(hintText: 'Username', controller: _usernameController),
                    AppTextField(hintText: 'Email Address', controller: _emailController),
                    AppTextField(hintText: 'Phone', controller: _phoneController),
                    AppTextField(hintText: 'Password', suffixIcon: FontAwesomeIcons.eye, controller: _passwordController),
                    const Gap(AppSpacing.bodySmall),
                    Center(child: AppFilledButton(text: 'Sign Up', onTap: _onRegiester)),
                    Center(child: Text('OR', style: AppTextStyles.bodyLarge().copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.bold))),
                    Row(children: [kSsoButton(icon: FontAwesomeIcons.google), const Gap(AppSpacing.bodyLarge), kSsoButton(icon: FontAwesomeIcons.facebook)]),
                    Text('By logging in, you agree to our Terms & Privacy.', style: AppTextStyles.caption().copyWith(fontWeight: FontWeight.w100, fontSize: 9)),
                    const Gap(AppSpacing.bodySmall),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(body: Center(child: Text(user.email)));
  }
}

  // Widget _authOption(String text, {bool showDivider = false}) => Expanded(
  //   child: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(text, style: AppTextStyles.bodyLarge().copyWith(fontWeight: FontWeight.bold)),
  //       showDivider ? Divider(color: Colors.black, indent: 5, thickness: 3, radius: BorderRadius.circular(100)) : const SizedBox.shrink(),
  //     ],
  //   ),
  // );

                // Padding(
                //   padding: const EdgeInsets.only(top: AppSpacing.bodyxxLarge),
                //   child: Row(
                //     spacing: AppSpacing.bodyxxLarge,
                //     children: [
                //       Expanded(
                //         child: BackdropFilter(
                //           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                //           blendMode: BlendMode.srcIn,
                //           child: Container(
                //             decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                //             height: Utils.getScreenHeight(context) / 14,
                //             child: Padding(
                //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //               child: Row(children: [_authOption('Sign Up'), _authOption('Login')]),
                //             ),
                //           ),
                //         ),
                //       ),
                //       const FaIcon(FontAwesomeIcons.magnifyingGlass),
                //       const FaIcon(FontAwesomeIcons.info),
                //       const FaIcon(FontAwesomeIcons.bell),
                //     ],
                //   ),
                // ),