import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/auth/presentation/widgets/input_box.dart';
import 'package:gramify/auth/presentation/widgets/input_box_mobile.dart';
import 'package:gramify/core/common/shared/colors.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class LoginPageMobile extends StatelessWidget {
  const LoginPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    var heeight = MediaQuery.of(context).size.height;
    var wiidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: heeight,
          child: Column(
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
                          style: txtStyle(15, lightBlackforText),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: lightBlackforText,
                        ),
                      ],
                    ),
                  ),
                  Gap(heeight / 10),
                  Image.asset(
                    'assets/images/logo_black.png',
                    color: themeColor,
                    width: wiidth / 3,
                    height: heeight / 10,
                  ),
                  Gap(heeight / 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        InputBoxMobile(hintText: 'Email'),
                        InputBoxMobile(hintText: 'Password'),
                        Gap(heeight / 25),
                        CustomButton(
                          buttonRadius: 18,
                          isFilled: true,
                          buttonText: 'Log in',
                        ),
                        forgotPasswordButton(),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomButton(
                  buttonRadius: 18,
                  isFilled: false,
                  buttonText: 'Create new account',
                ),
              ),
            ],
          ),
        ),
      ),
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
      log('tapped line 121');
    },
    child: Text('Forgot Password?', style: txtStyle(18, Colors.black87)),
  );
}

class LoginPageWeb extends StatelessWidget {
  const LoginPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final heeight = MediaQuery.of(context).size.height;
    final wiidth = MediaQuery.of(context).size.width;
    log('height:  ${heeight.toString()}');
    log('width:  ${wiidth.toString()}');
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [webBackGrad1, webBackGrad2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
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
                          ? Image.asset(
                            height: heeight / 1.4,
                            width: wiidth / 3,
                            'assets/images/web_login_asset.png',
                            fit: BoxFit.contain,

                            alignment: Alignment.center,
                          )
                          : Container(),
                      Flexible(
                        child: Column(
                          children: [
                            Container(
                              height: heeight / 2,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          height: heeight / 10,
                                          width: wiidth / 7,
                                          'assets/images/logo_black.png',
                                          color: Colors.white,
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
                                          InputBox(hintText: 'Email'),
                                          Gap(20),
                                          InputBox(hintText: 'Password'),
                                          Gap(30),
                                          CustomButton(
                                            buttonRadius: 12,
                                            isFilled: true,
                                            buttonText: 'Log in',
                                          ),
                                          Gap(20),
                                          _orDivider(),
                                          Gap(20),
                                          _facebookLogin(),
                                          Gap(20),
                                          _forgotPasswordButtton(),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Sign up',
                                        style: txtStyle(
                                          18,
                                          themeColor,
                                        ).copyWith(fontWeight: FontWeight.w700),
                                      ),
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

  Widget _forgotPasswordButtton() {
    return TextButton(
      onPressed: () {},
      child: Text('Forgot Password?', style: txtStyle(22, Colors.white)),
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
}

Widget _facebookLogin() {
  return TextButton(
    onPressed: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.facebook_outlined, color: Colors.blueAccent, size: 30),
        Gap(5),
        Text(
          'Log in with facebook',
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: txtStyle(
            18,
            Colors.blueAccent,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
