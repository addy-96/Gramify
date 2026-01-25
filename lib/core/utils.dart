import 'package:flutter/material.dart';
import 'package:gramify/core/enums.dart';

class Utils {
  static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  static bool validateInput(Validator validator) {
    switch (validator) {
      case Validator.email:
        return false;
      case Validator.password:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Validator.username:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Validator.phone:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
