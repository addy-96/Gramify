import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/features/auth/presentation/widgets/signUp_input_box_web.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

/*

*/
//
// web signup page

class SignupPageWeb extends StatefulWidget {
  const SignupPageWeb({super.key});

  @override
  State<SignupPageWeb> createState() => _SignupPageWebState();
}

class _SignupPageWebState extends State<SignupPageWeb> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool validInput = false;

  validateInput() {
    if (_emailController.text.trim().isEmpty) {
      return csnack(context, 'Enter Email to proceed.');
    } else if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.') ||
        _emailController.text.trim().contains(' ')) {
      return csnack(context, 'Invalid email');
    }

    if (_fullNameController.text.trim().isEmpty) {
      return csnack(context, 'Enter FUll name to proceed.');
    } else if (_fullNameController.text.length < 5 ||
        _fullNameController.text.length > 25) {
      return csnack(context, 'Fullname should be between 5 to 25 charcters.');
    }

    if (_usernameController.text.trim().isEmpty) {
      return csnack(context, 'Enter username to proceed');
    } else if (_usernameController.text.trim().length < 8 ||
        _usernameController.text.trim().length > 19 ||
        _usernameController.text.contains(' ')) {
      return csnack(
        context,
        'Username should be between 8 to 19 charcters withou spaces',
      );
    }

    if (_passwordController.text.trim().isEmpty) {
      return csnack(context, 'Enter password to proceed');
    } else if (_passwordController.text.trim().length < 8 ||
        _passwordController.text.trim().length > 30) {
      return csnack(context, 'Password should be between 8 to 30 charcters');
    }

    validInput = true;
  }

  void _onSignup() async {
    validInput = false;
    validateInput();
    if (validInput) {
      /*      context.read<AuthBloc>().add(
        SignUpRequested( // add profile image url section
          email: _emailController.text,
          password: _passwordController.text,
          fullname: _fullNameController.text,
          username: _usernameController.text,
          
        ),
      ); */
    } else {
      log('Invalid Input');
    }
  }

  @override
  Widget build(BuildContext context) {
    final heiight = MediaQuery.of(context).size.height;
    final wiidth = MediaQuery.of(context).size.width;
    /*    log('height : $heiight');
    log('width : $wiidth');*/
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          return csnack(context, state.errorMessage);
        }

        if (state is AuthSignUpSuccess) {
          context.go('/wrapper/${state.userID}');
        }
      },
      builder: (context, state) {
        if (state is AuthFailure) {
          _emailController.clear();
          _fullNameController.clear();
          _usernameController.clear();
          _passwordController.clear();
        }

        if (state is AuthloadingState) {
          return formWithLoadingScreen(heiight, wiidth);
        }
        return formSection(heiight, wiidth);
      },
    );
  }

  //gneral form // default
  Widget formSection(double heiight, double wiidth) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            children: [
              Gap(heiight / 40),
              Container(
                height: 700,
                width: getWiidth(wiidth),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white60),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        ShaderIamge(
                          imageWidget: Image.asset(
                            'assets/images/logo_black.png',
                            width: getWiidth(wiidth) / 1.8,
                          ),
                        ),
                        Gap(heiight / 50),
                        Text(
                          'Sign up to see photos and videos from your friends.',
                          textAlign: TextAlign.center,
                          style: txtStyle(
                            13,
                            const Color(0xFFa8a892),
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        Gap(heiight / 60),
                        SizedBox(
                          height: 40,
                          child: CustomButton(
                            isFacebookButton: true,
                            buttonRadius: 14,
                            isFilled: true,
                            buttonText: 'Log in with Facebook',
                            onTapEvent: () {}, //yet to implement
                          ),
                        ),
                        Gap(heiight / 70),
                        _orDivider(),
                        SignupInputBoxWeb(
                          hintText: 'Email',
                          textcontroller: _emailController,
                        ),
                        SignupInputBoxWeb(
                          hintText: 'Full Name',
                          textcontroller: _fullNameController,
                        ),
                        SignupInputBoxWeb(
                          hintText: 'Username',
                          textcontroller: _usernameController,
                        ),
                        SignupInputBoxWeb(
                          hintText: 'Password',
                          textcontroller: _passwordController,
                          isPasswordField: true,
                        ),
                        const Gap(5),
                        _policyText(),
                        const Gap(20),
                        SizedBox(
                          height: 40,
                          child: CustomButton(
                            buttonRadius: 14,
                            isFilled: true,
                            buttonText: 'Sign up.',
                            isFacebookButton: false,
                            onTapEvent: () {
                              _onSignup();
                            }, //yet to implement
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(heiight / 40),
              Container(
                height: 95,
                width: getWiidth(wiidth),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white60),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?',
                        style: txtStyle(15, Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go('/login');
                        },
                        child: ShaderText(
                          textWidget: Text(
                            'Log in.',
                            style: txtStyleNoColor(
                              15,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //form with loading overaly
  Widget formWithLoadingScreen(double heiight, double wiidth) {
    return Stack(
      children: [
        formSection(heiight, wiidth),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black87.withOpacity(0.5)),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  //get responsive with for the form
  double getWiidth(double wiidth) {
    return wiidth <= 655
        ? wiidth / 1.5
        : wiidth <= 900
        ? wiidth / 2.5
        : wiidth <= 1200
        ? wiidth / 3.5
        : wiidth <= 1500
        ? wiidth / 4.5
        : 349;
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

  Widget _policyText() {
    return Column(
      children: [
        Text(
          'People who use our service may have uploaded your contact information to Gramify. Learn More',
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.fade,
          style: txtStyle(
            13,
            const Color(0xFFa8a892),
          ).copyWith(fontWeight: FontWeight.w200),
        ),
        const Gap(20),
        Text(
          'By signing up, you agree to our Terms , Privacy Policy and Cookies Policy.',
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.fade,
          style: txtStyle(
            13,
            const Color(0xFFa8a892),
          ).copyWith(fontWeight: FontWeight.w200),
        ),
      ],
    );
  }
}
