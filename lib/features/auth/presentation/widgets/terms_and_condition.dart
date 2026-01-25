import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/text_styles.dart';

Widget termsAndCondition(String initText) => RichText(
  text: TextSpan(
    style: AppTextStyles.label().copyWith(color: Colors.grey.shade500),
    children: [
      TextSpan(text: initText),
      TextSpan(text: "Terms ", style: AppTextStyles.bodyLarge().copyWith(color: Appcolors.brandGreen), recognizer: TapGestureRecognizer()..onTap = () {}),
      TextSpan(text: "& ", style: AppTextStyles.label()),
      TextSpan(text: "Privacy Policy", style: AppTextStyles.label().copyWith(color: Appcolors.brandGreen), recognizer: TapGestureRecognizer()..onTap = () {}),
    ],
  ),
);
