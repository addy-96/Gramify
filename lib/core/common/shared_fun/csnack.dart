import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

void csnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: ShaderText(
          textWidget: Text(
            message,
            style: txtStyle(
              18,
              Colors.white,
            ).copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        elevation: 50,
        clipBehavior: Clip.antiAliasWithSaveLayer,

        dismissDirection: DismissDirection.horizontal,
      ),
    );
}
