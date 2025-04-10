import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class InputBox extends StatelessWidget {
  const InputBox({super.key, required this.hintText});
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        hintText: hintText,
        hintStyle: txtStyle(18, Colors.white70),
      ),
    );
  }
}
