import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

Widget forgotPasswordButton(BuildContext context) => TextButton(
  onPressed: () {
    context.push('/forgot_password');
  },
  child: Text('Forgot Password?', style: txtStyle(18, whiteForText)),
);
