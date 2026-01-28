import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/text_styles.dart';

Widget screenSwitchTextBtn(String initText, String btnText, GestureTapCallback onTap) => Padding(
  padding: const EdgeInsets.only(bottom: 10.0),
  child: RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: AppTextStyles.bodyLarge().copyWith(color: Colors.grey.shade500),
      children: [
        TextSpan(text: "$initText "),
        TextSpan(text: btnText, style: AppTextStyles.bodyLarge().copyWith(color: Appcolors.brandGreen), recognizer: TapGestureRecognizer()..onTap = onTap),
      ],
    ),
  ),
);
