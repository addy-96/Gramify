import 'package:flutter/material.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({super.key, required this.onTap, required this.text});
  final GestureTapCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodyLarge),
        decoration: BoxDecoration(
          color: Colors.transparent, // transparent background
          border: Border.all(
            color: Appcolors.brandGreen, // same as filled button color
            width: 2,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.bodyLarge().copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Appcolors.brandGreen, // text color matches border
            ),
          ),
        ),
      ),
    );
  }
}
