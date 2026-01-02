import 'package:flutter/material.dart';

class Utils {
  static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
