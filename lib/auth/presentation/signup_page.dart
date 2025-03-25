import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/core/common/shared/colors.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class SignupPageMobile extends StatelessWidget {
  const SignupPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SignupPageWeb extends StatefulWidget {
  const SignupPageWeb({super.key});

  @override
  State<SignupPageWeb> createState() => _SignupPageWebState();
}

class _SignupPageWebState extends State<SignupPageWeb> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                        ),
                      ),
                      Gap(heiight / 70),
                      _orDivider(),
                      _inputBox('Email'),
                      _inputBox('Full Name'),
                      _inputBox('Username'),
                      _inputBox('Password'),
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
                        ),
                      ),
                    ],
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

  Widget _inputBox(String hintText) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: SizedBox(
        height: 38,
        child: TextField(
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
