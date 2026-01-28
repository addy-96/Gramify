import 'package:flutter/material.dart';
import 'package:gramify/core/enums.dart';

class Utils {
  static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  static final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  static final RegExp _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$');

  static final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

  static final RegExp _phoneRegex = RegExp(r'^\d{10}$');

  static String? validateInput(Validator validator, String text) {
    switch (validator) {
      case Validator.email:
        return _emailRegex.hasMatch(text);

      case Validator.password:
        return _passwordRegex.hasMatch(text);

      case Validator.username:
        return _usernameRegex.hasMatch(text);

      case Validator.phone:
        return _phoneRegex.hasMatch(text);
    }
  }
}
