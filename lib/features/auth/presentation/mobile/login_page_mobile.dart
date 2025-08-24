import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/cal_fun.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/features/auth/presentation/widgets/forgot_pass_button.dart';
import 'package:gramify/features/auth/presentation/widgets/input_box_mobile.dart';
import 'package:gramify/features/auth/presentation/widgets/langugae_selector_button.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart' show txtStyle;

class LoginPageMobile extends StatefulWidget {
  const LoginPageMobile({super.key});

  @override
  State<LoginPageMobile> createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void onLogIn() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      return csnack(context, 'Enter email to proceed!');
    }

    if (!_emailController.text.trim().contains('@') ||
        !_emailController.text.trim().contains('.')) {
      return csnack(context, 'Invalid Email!');
    }

    context.read<AuthBloc>().add(
      LogInRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = getHeight(context);
    final width = getWidth(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          return csnack(context, state.errorMessage);
        }

        if (state is AuthLogInSuccess) {
          context.replace('/wrapper/:${state.userID}');
        }
      },
      builder: (context, state) {
        if (state is AuthloadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Pushes elements apart
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            onLanguageSelector(context); // yet to implement
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'English (India)',
                                style: txtStyle(bodyText14, whiteForText),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: lightBlackforText,
                              ),
                            ],
                          ),
                        ),
                        Gap(height / 10),
                        ShaderIamge(
                          imageWidget: Image.asset(
                            'assets/images/logo_black.png',
                            width: width / 2,
                            height: height / 10,
                          ),
                        ),
                        Gap(height / 8),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 16),
                          child: Column(
                            children: [
                              InputBoxMobile(
                                hintText: 'Email',
                                textController: _emailController,
                                isPasswordfield: false,
                              ),
                              InputBoxMobile(
                                hintText: 'Password',
                                textController: _passwordController,
                                isPasswordfield: true,
                              ),
                              Gap(height / 25),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                                child: CustomButton(
                                  buttonRadius: 50,
                                  isFilled: true,
                                  buttonText: 'Log in',
                                  isFacebookButton: false,
                                  onTapEvent: () => onLogIn(), //yet to implemnt
                                ),
                              ),
                              forgotPasswordButton(context),
                              const Gap(30),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                                child: CustomButton(
                                  isFacebookButton: false,
                                  buttonRadius: 50,
                                  isFilled: true,
                                  buttonText: 'Create new account',
                                  onTapEvent: () {
                                    context.replace('/signup');
                                  }, //yet to implement
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
