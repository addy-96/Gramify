import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/features/auth/presentation/widgets/input_box_login_web.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class LoginPageWeb extends StatefulWidget {
  const LoginPageWeb({super.key});

  @override
  State<LoginPageWeb> createState() => _LoginPageWebState();
}

class _LoginPageWebState extends State<LoginPageWeb> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool userTryingLOgin = false;

  void onLogIn() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      return _emailController.text.trim().isEmpty
          ? csnack(context, 'Enter email to proceed')
          : (!_emailController.text.contains('@') ||
              !_emailController.text.contains('.'))
          ? csnack(context, 'Invalid email!')
          : csnack(context, 'Enter password to proceed');
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
    final heeight = MediaQuery.of(context).size.height;
    final wiidth = MediaQuery.of(context).size.width;

    return defaultLoginScreen(heeight, wiidth);
  }

  Widget defaultLoginScreen(double heeight, double wiidth) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(heeight / 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    wiidth > 1500
                        ? Stack(
                          children: [
                            Image.asset(
                              height: heeight / 1.4,
                              width: wiidth / 3,
                              'assets/images/web_login_asset.png',
                              fit: BoxFit.contain,

                              alignment: Alignment.center,
                            ),
                          ],
                        )
                        : Container(),
                    Flexible(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              height: heeight > 760 ? heeight / 1.7 : 550,
                              width: getWidth(wiidth),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Colors.white70,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthFailure) {
                                      userTryingLOgin = false;
                                      return csnack(
                                        context,
                                        state.errorMessage,
                                      );
                                    }

                                    if (state is AuthLogInSuccess) {
                                      context.go('/wrapper/:${state.userID}');
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AuthloadingState) {
                                      userTryingLOgin = true;
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: ShaderIamge(
                                            imageWidget: Image.asset(
                                              height: 200,
                                              width: 300,
                                              'assets/images/logo_black.png',
                                              color: themeColor,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 22,
                                            right: 22,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          child: Column(
                                            children: [
                                              InputBoxLoginWeb(
                                                enableOrDisable:
                                                    !userTryingLOgin,
                                                hintText: 'Email',
                                                textController:
                                                    _emailController,
                                                isPasswordfield: false,
                                              ),
                                              const Gap(20),
                                              InputBoxLoginWeb(
                                                enableOrDisable:
                                                    !userTryingLOgin,
                                                hintText: 'Password',
                                                textController:
                                                    _passwordController,
                                                isPasswordfield: true,
                                              ),
                                              const Gap(30),
                                              userTryingLOgin
                                                  ? const CustomButtonWithLoader(
                                                    buttonRadius: 12,
                                                    isFilled: true,
                                                  )
                                                  : CustomButton(
                                                    isFacebookButton: false,
                                                    buttonRadius: 12,
                                                    isFilled: true,
                                                    buttonText: 'Log in',
                                                    onTapEvent: onLogIn,
                                                  ),
                                              const Gap(20),
                                              _orDivider(),
                                              const Gap(20),
                                              _facebookLogin(
                                                isDisabled: userTryingLOgin,
                                              ),
                                              const Gap(20),
                                              _forgotPasswordButtton(
                                                isDisabled: userTryingLOgin,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Gap(heeight / 100),
                          Container(
                            height: heeight / 12,
                            width: getWidth(wiidth),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: Colors.white70,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: txtStyle(18, Colors.white70),
                                  ),
                                  BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) {
                                      return TextButton(
                                        onPressed:
                                            userTryingLOgin
                                                ? null
                                                : () {
                                                  context.go(
                                                    '/signup',
                                                    extra: null,
                                                  );
                                                },
                                        child: ShaderText(
                                          textWidget: Text(
                                            'Sign up',
                                            style: txtStyleNoColor(18).copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getWidth(double wiidth) {
    return wiidth < 600
        ? wiidth / 1.2
        : wiidth >= 600 && wiidth <= 1000
        ? wiidth / 1.5
        : wiidth > 1000 && wiidth <= 1600
        ? wiidth / 2.6
        : wiidth > 1600
        ? 450
        : 450;
  }

  Widget _forgotPasswordButtton({required bool isDisabled}) {
    return TextButton(
      onPressed: isDisabled ? null : () {},
      child: Text(
        'Forgot Password?',
        style: txtStyle(22, isDisabled ? Colors.white38 : Colors.white),
      ),
    );
  }

  Widget _orDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text("OR", style: txtStyle(18, Colors.white70)),
        ),
        const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
      ],
    );
  }

  Widget _facebookLogin({required bool isDisabled}) {
    return TextButton(
      onPressed: isDisabled ? null : () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.facebook_outlined,
            color:
                isDisabled
                    ? Colors.blueAccent.withOpacity(0.2)
                    : Colors.blueAccent,
            size: 30,
          ),
          const Gap(5),
          Text(
            'Log in with facebook',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: txtStyle(
              18,
              isDisabled
                  ? Colors.blueAccent.withOpacity(0.2)
                  : Colors.blueAccent,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
