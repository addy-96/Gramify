import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared/colors.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonRadius,
    required this.isFilled,
    required this.buttonText,
  });
  final double buttonRadius;
  final bool isFilled;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 18,
      decoration: BoxDecoration(
        color: isFilled ? Color(0xFF66FF00) : Colors.transparent,
        border:
            isFilled
                ? Border.all(width: 1, color: Colors.black)
                : Border.all(width: 1, color: themeColor),
        borderRadius: BorderRadius.circular(buttonRadius),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: txtStyle(22, isFilled ? Colors.black54 : themeColor).copyWith(
            fontWeight: !isFilled ? FontWeight.w400 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
