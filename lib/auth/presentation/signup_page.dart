import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared/colors.dart';

class SignupPageMobile extends StatelessWidget {
  const SignupPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SignupPageWeb extends StatelessWidget {
  const SignupPageWeb({super.key});

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
        child: Column(
          children: [
            Gap(heiight / 40),
            Container(
              height: heiight / 1.3,
              width:
                  wiidth >=  // to work here
                      ? wiidth / 4
                      : wiidth > 550 && wiidth <= 1200
                      ? wiidth / 1.7
                      : wiidth / 1.3,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white60),
                color: themeColor.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
