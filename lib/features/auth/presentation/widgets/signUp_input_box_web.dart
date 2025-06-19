import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';

class SignupInputBoxWeb extends StatefulWidget {
  const SignupInputBoxWeb({
    super.key,
    required this.hintText,
    required this.textcontroller,
    this.isPasswordField = false,
  });

  final String hintText;
  final TextEditingController textcontroller;
  final bool isPasswordField;

  @override
  State<SignupInputBoxWeb> createState() => _SignupInputBoxWebState();
}

class _SignupInputBoxWebState extends State<SignupInputBoxWeb> {
  var isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: SizedBox(
        height: 38,
        child: TextFormField(
          onChanged: (value) {
            widget.isPasswordField ? setState(() {}) : null;
          },
          obscureText: widget.isPasswordField && isPasswordHidden,
          controller: widget.textcontroller,
          style: txtStyle(14, Colors.white60),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            suffixIcon:
                widget.isPasswordField &&
                        widget.textcontroller.text.trim().isNotEmpty
                    ? IconButton(
                      onPressed: () {
                        log(isPasswordHidden.toString());
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                      icon: Icon(
                        isPasswordHidden
                            ? Ionicons.eye_outline
                            : Ionicons.eye_off_outline,
                      ),
                    )
                    : null,
            enabledBorder: const OutlineInputBorder(
              gapPadding: 8,
              borderSide: BorderSide(color: Color(0xFFa8a892), width: 0.5),
            ),
            focusedBorder: const OutlineInputBorder(
              gapPadding: 8,
              borderSide: BorderSide(color: Colors.white60, width: 2),
            ),
            border: const OutlineInputBorder(
              gapPadding: 8,
              borderSide: BorderSide(color: Color(0xFFa8a892), width: 0.5),
            ),
            contentPadding: const EdgeInsets.only(
              left: 6,
              right: 6,
              top: 8,
              bottom: 8,
            ),
            label: Text(widget.hintText),
            labelStyle: txtStyle(13, const Color(0xFFa8a892)),
          ),
        ),
      ),
    );
  }
}
