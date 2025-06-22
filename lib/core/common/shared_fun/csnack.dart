import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

void csnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        duration: const Duration(seconds: 3),
        content: ShaderText(
          textWidget: Text(
            message,
            style: txtStyle(
              bodyText16,
              whiteForText,
            ).copyWith(fontWeight: FontWeight.normal),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 44, 45),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        elevation: 30,
        dismissDirection: DismissDirection.up,
      ),
    );
}
