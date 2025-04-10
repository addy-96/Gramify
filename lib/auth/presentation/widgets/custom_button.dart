import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonRadius,
    required this.isFilled,
    required this.buttonText,
    required this.isFacebookButton,
    required this.onTapEvent,
  });
  final double buttonRadius;
  final bool isFilled;
  final String buttonText;
  final bool isFacebookButton;
  final GestureTapCallback onTapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapEvent,
      child: Container(
        height: MediaQuery.of(context).size.height / 18,
        decoration: BoxDecoration(
          color:
              isFilled && isFacebookButton
                  ? facebookBlue
                  : isFilled
                  ? themeColor
                  : Colors.transparent,
          border:
              isFilled
                  ? Border.all(width: 1, color: Colors.black)
                  : Border.all(width: 1, color: themeColor),
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: txtStyle(
              isFilled && isFacebookButton ? 13 : 22,
              isFilled && isFacebookButton
                  ? Colors.white
                  : isFilled
                  ? Colors.black54
                  : themeColor,
            ).copyWith(
              fontWeight:
                  isFilled && isFacebookButton
                      ? FontWeight.bold
                      : !isFilled
                      ? FontWeight.w400
                      : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
