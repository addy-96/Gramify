import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

void csnack(BuildContext context, String message, Color? color) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(message, style: txtStyle(18, Colors.white)),
        backgroundColor: color ?? themeColor,
      ),
    );
}
