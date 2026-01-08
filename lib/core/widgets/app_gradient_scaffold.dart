import 'package:flutter/material.dart';
import 'package:gramify/core/theme/colors.dart';

class AppGradientScaffold extends StatelessWidget {
  const AppGradientScaffold({super.key, required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 0.6],
            colors: [Appcolors.gradientMint, Appcolors.gradientLight, Appcolors.white],
          ),
        ),
        child: SafeArea(child: body),
      ),
    );
  }
}
