import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/inputfield_constrants.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class InputBoxLoginWeb extends StatefulWidget {
  const InputBoxLoginWeb({
    super.key,
    required this.hintText,
    required this.textController,
    required this.enableOrDisable,
    required this.isPasswordfield,
  });
  final String hintText;
  final TextEditingController textController;
  final bool enableOrDisable;
  final bool isPasswordfield;

  @override
  State<InputBoxLoginWeb> createState() => _InputBoxLoginWebState();
}

class _InputBoxLoginWebState extends State<InputBoxLoginWeb> {
  bool isPassowordhidden = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.isPasswordfield ? passwordMAXLength : emailMAXLength,
      onChanged:
          widget.isPasswordfield
              ? (value) {
                setState(() {});
              }
              : null,
      controller: widget.textController,
      enabled: widget.enableOrDisable,
      style: TextStyle(color: Colors.white),
      obscureText: widget.isPasswordfield && isPassowordhidden,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        counterText: '',
        suffixIcon:
            widget.isPasswordfield
                ? widget.textController.text.trim().isEmpty
                    ? null
                    : IconButton(
                      onPressed: () {
                        setState(() {
                          isPassowordhidden = !isPassowordhidden;
                        });
                      },
                      icon:
                          isPassowordhidden
                              ? Icon(CupertinoIcons.eye_fill)
                              : Icon(CupertinoIcons.eye_slash_fill),
                    )
                : null,
        filled: true,

        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        hintText: widget.hintText,
        hintStyle: txtStyle(18, Colors.white70),
      ),
    );
  }
}
