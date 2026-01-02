import 'package:flutter/material.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodyLarge),
      decoration: BoxDecoration(color: Appcolors.gradientBlueButton, borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Text(
          'Sign Up',
          style: AppTextStyles.bodyLarge().copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = Colors.white,
          ),
        ),
      ),
    );
  }
}
