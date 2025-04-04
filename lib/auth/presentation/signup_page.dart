import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/core/common/shared/colors.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class SignupPageMobile extends StatelessWidget {
  const SignupPageMobile({super.key});

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
                        Colors.black,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Enter the email address at which you can be contacted. No one will see this on your profile.',
                      textAlign: TextAlign.center,
                      style: txtStyle(15, Colors.black87),
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: txtStyle(18, Colors.black),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.1,
                                  color: Colors.black38,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => SignUpDetailsPageMobile(),
                                  ),
                                );
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
                    onPressed: () {},
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
  const SignUpDetailsPageMobile({super.key});

  @override
  State<SignUpDetailsPageMobile> createState() =>
      _SignUpDetailsPageMobileState();
}

class _SignUpDetailsPageMobileState extends State<SignUpDetailsPageMobile> {
  @override
  Widget build(BuildContext context) {
    final heeight = MediaQuery.of(context).size.height;
    final wiidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                child: Column(
                  children: [
                    Text(
                      'Enter your details',
                      style: txtStyle(
                        25,
                        Colors.black,
                      ).copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'No worries, this information can be changed later.',
                      textAlign: TextAlign.center,
                      style: txtStyle(15, Colors.black87),
                    ),
                    Gap(10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: txtStyle(18, Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.1,
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    Gap(15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: txtStyle(18, Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.1,
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    Gap(15),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: txtStyle(18, Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.1,
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    Gap(20),
                    SizedBox(
                      height: heeight / 12,
                      child: CustomButton(
                        buttonRadius: 12,
                        isFilled: true,
                        buttonText: 'Create account',
                        isFacebookButton: false,
                        onTapEvent: () {},
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
  }
}

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

  void _onSignup() async {
    if (_formkey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        SignUpRequested(
          email: _emailController.text,
          password: _passwordController.text,
          fullname: _fullNameController.text,
          username: _usernameController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final heiight = MediaQuery.of(context).size.height;
    final wiidth = MediaQuery.of(context).size.width;
    log('height : $heiight');
    log('width : $wiidth');
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [webBackGrad1, webBackGrad2]),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
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
                        onPressed: () {},
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

  double getWiidth(double wiidth) {
    return wiidth <= 600
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
          validator: (value) {
            if (hintText == 'Email') {
              return textcontroller.text.trim().isEmpty
                  ? 'Please Enter the email to proceeed'
                  : !textcontroller.text.contains('@') ||
                      !textcontroller.text.contains('.') ||
                      !textcontroller.text.trim().contains(' ')
                  ? 'Invalid Email'
                  : '';
                  
            }
            
            else if (hintText == 'Full name') {
              return textcontroller.text.trim().length > 25
                  ? 'Full name can be max. 25 charchters.'
                  : '';
            }
            else if (hintText == 'Username') {
              return textcontroller.text.trim().length < 5 ||
                      textcontroller.text.trim().length > 15
                  ? 'Username should be between 5 to 15 charcters.'
                  : textcontroller.text.trim().contains(' ')
                  ? 'Sorry! No spaces allowed in Username'
                  : '';
            }
            else if (hintText == 'Password') {
              return textcontroller.text.trim().length < 8 ||
                      textcontroller.text.trim().length > 18
                  ? 'Password can be between 8 to 18 charcters'
                  : '';
            }
            return null;
          },
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
          'People who use our service may have uploaded your contact information to Instagram. Learn More',
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
