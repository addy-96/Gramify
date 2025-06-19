import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
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
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: TextField(
        onChanged: (value) {
          setState(() {});
        },
        maxLength: widget.isPasswordfield ? passwordMAXLength : emailMAXLength,
        obscureText: widget.isPasswordfield && isPasswordHidden,
        controller: widget.textController,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          counterText: '',
          suffixIcon:
              widget.isPasswordfield &
                      widget.textController.text.trim().isNotEmpty
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon:
                        isPasswordHidden
                            ? const ShaderIcon(
                              iconWidget: Icon(
                                CupertinoIcons.eye,
                                color: themeColor,
                              ),
                            )
                            : const Icon(
                              CupertinoIcons.eye_slash,
                              color: Colors.white70,
                            ),
                  )
                  : null,
          labelText: widget.hintText,
          labelStyle: txtStyle(
            15,
            whiteForText,
          ).copyWith(fontWeight: FontWeight.bold),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white60, width: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        style: txtStyle(18, whiteForText),
      ),
    );
  }
}
