import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle _base({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.black,
    double height = 1.35,
    double letterSpacing = 0,
  }) {
    return Platform.isIOS
        ? TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            height: height,
            letterSpacing: letterSpacing,
          )
        : GoogleFonts.nunitoSans(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            height: height,
            letterSpacing: letterSpacing,
          );
  }

  // Titles
  static TextStyle titleLarge({Color color = Colors.black}) =>
      _base(fontSize: 28, fontWeight: FontWeight.w600, color: color);

  static TextStyle titleMedium({Color color = Colors.black}) =>
      _base(fontSize: 22, fontWeight: FontWeight.w600, color: color);

  static TextStyle titleSmall({Color color = Colors.black}) =>
      _base(fontSize: 18, fontWeight: FontWeight.w600, color: color);

  // Body
  static TextStyle bodyLarge({Color color = Colors.black}) =>
      _base(fontSize: 16, fontWeight: FontWeight.w400, color: color);

  static TextStyle bodyMedium({Color color = Colors.black}) =>
      _base(fontSize: 14, fontWeight: FontWeight.w400, color: color);

  static TextStyle bodySmall({Color color = Colors.black}) =>
      _base(fontSize: 12, fontWeight: FontWeight.w400, color: color);

  // Labels
  static TextStyle label({Color color = Colors.black}) =>
      _base(fontSize: 13, fontWeight: FontWeight.w500, color: color);

  // Caption
  static TextStyle caption({Color color = Colors.grey}) =>
      _base(fontSize: 12, fontWeight: FontWeight.w400, color: color);
}
