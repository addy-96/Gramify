import 'package:flutter/material.dart';

class InputBoxMobile extends StatelessWidget {
  const InputBoxMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),

      child: TextField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
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
