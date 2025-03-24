import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared/colors.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class InputBoxMobile extends StatelessWidget {
  const InputBoxMobile({super.key, required this.hintText});

  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),

      child: TextField(
        decoration: InputDecoration(
          labelText: hintText,
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
