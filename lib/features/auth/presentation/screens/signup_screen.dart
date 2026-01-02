import 'package:flutter/material.dart';
import 'package:gramify/core/theme/colors.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Appcolors.gradientBlueDeep, Appcolors.gradientBlueMidLight, Appcolors.white, Appcolors.white, Appcolors.white],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
