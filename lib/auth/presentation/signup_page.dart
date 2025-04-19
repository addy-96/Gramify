import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class SignupPageMobile extends StatefulWidget {
  const SignupPageMobile({super.key});

  @override
  State<SignupPageMobile> createState() => _SignupPageMobileState();
}

class _SignupPageMobileState extends State<SignupPageMobile> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_emailController.text.trim().isEmpty) {
      return csnack(context, 'Enter email to proceed', themeColor);
    } else if (!_emailController.text.trim().contains('@') ||
        !_emailController.text.trim().contains('.')) {
      return csnack(context, 'Invalid Email!', themeColor);
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => SignUpDetailsPageMobile(
              userEmail: _emailController.text.trim(),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final heeight = MediaQuery.of(context).size.height;
    final wiidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: /* (heeight / 3).toInt() */ 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                child: Column(
                  children: [
                    Text(
                      'What\'s your email address?',
                      style: txtStyle(
                        25,
                        whiteForText,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Enter the email address at which you can be contacted. No one will see this on your profile.',
                      textAlign: TextAlign.center,
                      style: txtStyle(15, whiteForText),
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            cursorColor: themeColor,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: txtStyle(
                                18,
                                whiteForText,
                              ).copyWith(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: themeColor,
                                ),

                                borderRadius: BorderRadius.circular(14),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: themeColor,
                                ),

                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            style: txtStyle(18, whiteForText),
                          ),
                          Gap(30),
                          SizedBox(
                            height: heeight / 12,
                            child: CustomButton(
                              buttonRadius: 8,
                              isFilled: true,
                              buttonText: 'Submit',
                              isFacebookButton: false,
                              onTapEvent: () {
                                _onSubmit();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context.replace('/login');
                    },
                    child: Text(
                      'Already have an account?',
                      style: txtStyle(
                        18,
                        themeColor,
                      ).copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpDetailsPageMobile extends StatefulWidget {
  const SignUpDetailsPageMobile({super.key, required this.userEmail});

  final String userEmail;

  @override
  State<SignUpDetailsPageMobile> createState() =>
      _SignUpDetailsPageMobileState();
}

class _SignUpDetailsPageMobileState extends State<SignUpDetailsPageMobile> {
  final TextEditingController _fullNameColtroller = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool validInput = false;

  validateInput() {
    if (_fullNameColtroller.text.trim().isEmpty) {
      return csnack(context, 'Enter FUll name to proceed.', themeColor);
    } else if (_fullNameColtroller.text.length < 5 ||
        _fullNameColtroller.text.length > 25) {
      return csnack(
        context,
        'Fullname should be between 5 to 25 charcters.',
        themeColor,
      );
    }

    if (_usernameController.text.trim().isEmpty) {
      return csnack(context, 'Enter username to proceed', themeColor);
    } else if (_usernameController.text.trim().length < 8 ||
        _usernameController.text.trim().length > 19 ||
        _usernameController.text.contains(' ')) {
      return csnack(
        context,
        'Username should be between 8 to 19 charcters withou spaces',
        themeColor,
      );
    }

    if (_passwordController.text.trim().isEmpty) {
      return csnack(context, 'Enter password to proceed', themeColor);
    } else if (_passwordController.text.trim().length < 8 ||
        _passwordController.text.trim().length > 30) {
      return csnack(
        context,
        'Password should be between 8 to 30 charcters',
        themeColor,
      );
    }

    validInput = true;
  }

  _onCreateAccount() {
    validInput = false;
    validateInput();
    if (validInput) {
      context.read<AuthBloc>().add(
        SignUpRequested(
          email: widget.userEmail,
          password: _passwordController.text.trim(),
          fullname: _fullNameColtroller.text.trim(),
          username: _usernameController.text.trim(),
        ),
      );
    } else {
      log('Invalid Input');
    }
  }

  @override
  Widget build(BuildContext context) {
    final heeight = MediaQuery.of(context).size.height;
    final wiidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpSuccess) {
          context.go('/wrapper/:${state.userID}');
        }

        if (state is AuthFailure) {
          csnack(context, state.errorMessage, Colors.red);
        }
      },

      builder: (context, state) {
        if (state is AuthloadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              foregroundColor: themeColor,
              backgroundColor: Colors.transparent, // Important!
              elevation: 0, // Optional: removes shadow
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(child: Text('Hello'));
                              },
                            );
                          },
                          child: Text(
                            widget.userEmail,
                            style: txtStyle(
                              22,
                              themeColor,
                            ).copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                        Gap(15),
                        Text(
                          'Enter your details',
                          style: txtStyle(
                            25,
                            whiteForText,
                          ).copyWith(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'No worries, this information can be changed later.',
                          textAlign: TextAlign.center,
                          style: txtStyle(15, whiteForText),
                        ),
                        Gap(10),
                        _inputField('Full Name', _fullNameColtroller),
                        Gap(15),
                        _inputField('Username', _usernameController),
                        Gap(15),
                        _inputField('Password', _passwordController),
                        Gap(20),
                        SizedBox(
                          height: heeight / 12,
                          child: CustomButton(
                            buttonRadius: 12,
                            isFilled: true,
                            buttonText: 'Create account',
                            isFacebookButton: false,
                            onTapEvent: () {
                              _onCreateAccount();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _inputField(String labelText, TextEditingController textController) {
    return TextField(
      controller: textController,
      cursorColor: themeColor,
      decoration: InputDecoration(
        labelText: labelText,

        labelStyle: txtStyle(18, whiteForText),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0.1, color: Colors.black38),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: themeColor),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

//
//
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
      return csnack(context, 'Enter Email to proceed.', themeColor);
    } else if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.') ||
        _emailController.text.trim().contains(' ')) {
      return csnack(context, 'Invalid email', themeColor);
    }

    if (_fullNameController.text.trim().isEmpty) {
      return csnack(context, 'Enter FUll name to proceed.', themeColor);
    } else if (_fullNameController.text.length < 5 ||
        _fullNameController.text.length > 25) {
      return csnack(
        context,
        'Fullname should be between 5 to 25 charcters.',
        themeColor,
      );
    }

    if (_usernameController.text.trim().isEmpty) {
      return csnack(context, 'Enter username to proceed', themeColor);
    } else if (_usernameController.text.trim().length < 8 ||
        _usernameController.text.trim().length > 19 ||
        _usernameController.text.contains(' ')) {
      return csnack(
        context,
        'Username should be between 8 to 19 charcters withou spaces',
        themeColor,
      );
    }

    if (_passwordController.text.trim().isEmpty) {
      return csnack(context, 'Enter password to proceed', themeColor);
    } else if (_passwordController.text.trim().length < 8 ||
        _passwordController.text.trim().length > 30) {
      return csnack(
        context,
        'Password should be between 8 to 30 charcters',
        themeColor,
      );
    }

    validInput = true;
  }

  void _onSignup() async {
    validInput = false;
    validateInput();
    if (validInput) {
      context.read<AuthBloc>().add(
        SignUpRequested(
          email: _emailController.text,
          password: _passwordController.text,
          fullname: _fullNameController.text,
          username: _usernameController.text,
        ),
      );
    } else {
      log('Invalid Input');
    }
  }

  @override
  Widget build(BuildContext context) {
    final heiight = MediaQuery.of(context).size.height;
    final wiidth = MediaQuery.of(context).size.width;
    log('height : $heiight');
    log('width : $wiidth');
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          return csnack(context, state.errorMessage, Colors.red);
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
                  padding: EdgeInsets.only(top: 30, left: 40, right: 40),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo_black.png',
                          color: themeColor,
                          width: getWiidth(wiidth) / 1.8,
                        ),
                        Gap(heiight / 50),
                        Text(
                          'Sign up to see photos and videos from your friends.',
                          textAlign: TextAlign.center,
                          style: txtStyle(
                            13,
                            Color(0xFFa8a892),
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        Gap(heiight / 60),
                        SizedBox(
                          height: 40,
                          child: CustomButton(
                            isFacebookButton: true,
                            buttonRadius: 8,
                            isFilled: true,
                            buttonText: 'Log in with Facebook',
                            onTapEvent: () {}, //yet to implement
                          ),
                        ),
                        Gap(heiight / 70),
                        _orDivider(),
                        _inputBox('Email', _emailController),
                        _inputBox('Full Name', _fullNameController),
                        _inputBox('Username', _usernameController),
                        _inputBox('Password', _passwordController),
                        Gap(5),
                        _policyText(),
                        Gap(20),
                        SizedBox(
                          height: 40,
                          child: CustomButton(
                            buttonRadius: 8,
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
                        child: Text(
                          'Log in.',
                          style: txtStyle(
                            15,
                            themeColor,
                          ).copyWith(fontWeight: FontWeight.bold),
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
          child: Center(child: CircularProgressIndicator(color: themeColor)),
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
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("OR", style: txtStyle(18, Colors.white70)),
        ),
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
      ],
    );
  }

  Widget _inputBox(String hintText, TextEditingController textcontroller) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: SizedBox(
        height: 38,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: textcontroller,
          style: txtStyle(14, Colors.white60),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              gapPadding: 8,
              borderSide: BorderSide(color: Color(0xFFa8a892), width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 8,
              borderSide: BorderSide(color: Color(0xFFa8a892), width: 0.5),
            ),
            border: OutlineInputBorder(
              gapPadding: 8,
              borderSide: BorderSide(color: Color(0xFFa8a892), width: 0.5),
            ),
            contentPadding: EdgeInsets.only(
              left: 6,
              right: 6,
              top: 8,
              bottom: 8,
            ),
            label: Text(hintText),
            labelStyle: txtStyle(13, Color(0xFFa8a892)),
          ),
        ),
      ),
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
            Color(0xFFa8a892),
          ).copyWith(fontWeight: FontWeight.w200),
        ),
        Gap(20),
        Text(
          'By signing up, you agree to our Terms , Privacy Policy and Cookies Policy.',
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.fade,
          style: txtStyle(
            13,
            Color(0xFFa8a892),
          ).copyWith(fontWeight: FontWeight.w200),
        ),
      ],
    );
  }
}
