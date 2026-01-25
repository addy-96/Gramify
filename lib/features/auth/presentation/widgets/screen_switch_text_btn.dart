import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/text_styles.dart';

Widget screenSwitchTextBtn(String initText, String btnText, GestureTapCallback onTap, [bool hasDivider = true]) => Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
  hasDivider ?  Divider(color: Colors.grey.shade500.withValues(alpha: 0.1), thickness: 2, radius: BorderRadius.circular(10)) : const SizedBox.shrink(),
    RichText(
      text: TextSpan(
        style: AppTextStyles.bodyLarge().copyWith(color: Colors.grey.shade500),
        children: [
          TextSpan(text: "$initText "),
          TextSpan(
            text: btnText,
            style: AppTextStyles.bodyLarge().copyWith(color: Appcolors.brandGreen),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = onTap
          ),
        ],
      ),
    ),
    const Gap(10),
  ],
);
