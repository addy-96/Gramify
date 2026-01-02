import 'package:flutter/material.dart';
import 'package:gramify/core/theme/colors.dart';

class AppGradientScaffold extends StatelessWidget {
  const AppGradientScaffold({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Appcolors.gradientBlueDeep, Appcolors.gradientBlueMidLight, Appcolors.gradientBlueMidLight.withValues(alpha: 0.3), Appcolors.white],
                ),
              ),
            ),
            body,
          ],
        ),
      ),
    );
  }
}
