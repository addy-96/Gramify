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
        if (_emailRegex.hasMatch(text)) {
          return null;
        }
        return "Please enter a valid email address";

      case Validator.password:
        if (_passwordRegex.hasMatch(text)) {
          return null;
        }
        return "Password must be at least 8 characters and include a number";

      case Validator.username:
        if (_usernameRegex.hasMatch(text)) {
          return null;
        }
        return "Username must be 3–20 characters and contain only letters, numbers, or underscores";

      case Validator.phone:
        if (_phoneRegex.hasMatch(text)) {
          return null;
        }
        return "Please enter a valid 10-digit phone number";
    }
  }
}
