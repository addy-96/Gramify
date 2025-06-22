import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
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
      borderRadius: BorderRadius.circular(buttonRadius),
      child: Container(
        height:
            MediaQuery.of(context).size.height > 680
                ? MediaQuery.of(context).size.height / 18
                : 50,
        decoration: BoxDecoration(
          gradient:
              isFilled && !isFacebookButton
                  ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [thmegrad1, thmegrad2],
                  )
                  : null,

          color: isFilled && isFacebookButton ? facebookBlue : null,

          border:
              isFilled
                  ? Border.all(width: 1, color: Colors.black)
                  : Border.all(width: 2),
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: txtStyle(
              isFilled && isFacebookButton ? bodyText14 : bodyText16,
              isFilled && isFacebookButton
                  ? Colors.white
                  : isFilled
                  ? Colors.black54
                  : Colors.black26,
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

class CustomButtonWithLoader extends StatelessWidget {
  const CustomButtonWithLoader({
    super.key,
    required this.buttonRadius,
    required this.isFilled,
  });
  final double buttonRadius;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: MediaQuery.of(context).size.height / 18,
        decoration: BoxDecoration(
          color: Colors.black54,
          border:
              isFilled
                  ? Border.all(width: 1, color: Colors.black26)
                  : Border.all(width: 1),
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
