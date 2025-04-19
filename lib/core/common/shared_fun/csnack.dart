import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

void csnack(BuildContext context, String message, Color? color) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          message,
          style: txtStyle(
            18,
            Colors.black87,
          ).copyWith(fontWeight: FontWeight.w500),
        ),
        backgroundColor: color ?? themeColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 12),
        elevation: 10,
        clipBehavior: Clip.hardEdge,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
}
