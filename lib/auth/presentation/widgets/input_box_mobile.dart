import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/inputfield_constrants.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class InputBoxMobile extends StatefulWidget {
  const InputBoxMobile({
    super.key,
    required this.hintText,
    required this.textController,
    required this.isPasswordfield,
  });

  final String hintText;
  final TextEditingController textController;
  final bool isPasswordfield;

  @override
  State<InputBoxMobile> createState() => _InputBoxMobileState();
}

class _InputBoxMobileState extends State<InputBoxMobile> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),

      child: TextField(
        onChanged: (value) {
          setState(() {});
        },
        maxLength: widget.isPasswordfield ? passwordMAXLength : emailMAXLength,
        obscureText: widget.isPasswordfield && passwordVisible,
        controller: widget.textController,
        decoration: InputDecoration(
          counterText: '',
          suffixIcon:
              widget.isPasswordfield &
                      widget.textController.text.trim().isNotEmpty
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon:
                        passwordVisible
                            ? Icon(CupertinoIcons.eye)
                            : Icon(CupertinoIcons.eye_slash),
                  )
                  : null,
          labelText: widget.hintText,
          labelStyle: txtStyle(15, lightBlackforText),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 0.2),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
