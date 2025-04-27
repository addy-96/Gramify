import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/auth/presentation/widgets/input_box_login_web.dart';
import 'package:gramify/auth/presentation/widgets/input_box_mobile.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

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
      return csnack(context, 'Enter email to proceed', themeColor);
    }

    if (!_emailController.text.trim().contains('@') ||
        !_emailController.text.trim().contains('.')) {
      return csnack(context, 'Invalid Email', themeColor);
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
    var heeight = MediaQuery.of(context).size.height;
    var wiidth = MediaQuery.of(context).size.width;
    log('height : $heeight');
    log('width : $wiidth');
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          return csnack(context, state.errorMessage, Colors.red);
        }

        if (state is AuthLogInSuccess) {
          context.replace('/wrapper/:${state.userID}');
        }
      },
      builder: (context, state) {
        if (state is AuthloadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              height: heeight,
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
                                style: txtStyle(15, whiteForText),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: lightBlackforText,
                              ),
                            ],
                          ),
                        ),
                        Gap(heeight / 10),
                        ShaderIamge(
                          imageWidget: Image.asset(
                            'assets/images/logo_black.png',
                            color: themeColor,
                            width: wiidth / 2,
                            height: heeight / 10,
                          ),
                        ),
                        Gap(heeight / 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              Gap(heeight / 25),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 12,
                                child: CustomButton(
                                  buttonRadius: 8,
                                  isFilled: true,
                                  buttonText: 'Log in',
                                  isFacebookButton: false,
                                  onTapEvent: () => onLogIn(), //yet to implemnt
                                ),
                              ),
                              forgotPasswordButton(),
                              Gap(30),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 14,
                                child: CustomButton(
                                  isFacebookButton: false,
                                  buttonRadius: 8,
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

  void onLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 1, // Full screen height
          minChildSize: 0.5, // Minimum height when dragged down
          maxChildSize: 1, // Maximum height
          expand: true,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: ListView(
                controller:
                    scrollController, // Enables scrolling inside the sheet
                children: [
                  Text('Yet To implement', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  Text('-'),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget forgotPasswordButton() => TextButton(
    onPressed: () {
      context.push('/forgot_password');
    },
    child: Text('Forgot Password?', style: txtStyle(18, whiteForText)),
  );
}

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
          ? csnack(context, 'Enter email to proceed', themeColor)
          : (!_emailController.text.contains('@') ||
              !_emailController.text.contains('.'))
          ? csnack(context, 'Invalid email!', themeColor)
          : csnack(context, 'Enter password to proceed', themeColor);
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
                                        Colors.red,
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
                                    log('height:  ${heeight.toString()}');
                                    log('width:  ${wiidth.toString()}');
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
                                          padding: EdgeInsets.only(
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
                                              Gap(20),
                                              InputBoxLoginWeb(
                                                enableOrDisable:
                                                    !userTryingLOgin,
                                                hintText: 'Password',
                                                textController:
                                                    _passwordController,
                                                isPasswordfield: true,
                                              ),
                                              Gap(30),
                                              userTryingLOgin
                                                  ? CustomButtonWithLoader(
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
                                              Gap(20),
                                              _orDivider(),
                                              Gap(20),
                                              _facebookLogin(
                                                isDisabled: userTryingLOgin,
                                              ),
                                              Gap(20),
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
                                                  log('tapping');
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
                Gap(40),
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

  //yet to implement facebook
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
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("OR", style: txtStyle(18, Colors.white70)),
        ),
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
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
          Gap(5),
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
