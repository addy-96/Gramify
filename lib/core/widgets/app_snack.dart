import 'package:flutter/material.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/text_styles.dart';

dynamic appSnack(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.down,
          duration: const Duration(seconds: 2),
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Appcolors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 0.2, color: Colors.grey.shade300),
              // gradient: const LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.centerRight,
              //   colors: [Appcolors.gradientLight, Appcolors.white, Appcolors.gradientLight],
              // ),
            ),
            child: Center(child: Text(message, style: AppTextStyles.bodySmall())),
          ),
        ),
      );
