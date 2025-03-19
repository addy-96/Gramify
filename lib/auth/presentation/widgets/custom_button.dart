import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 18,
      decoration: BoxDecoration(
        color: Color(0xFF66FF00),
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text('Button', style: txtStyle(22, Colors.black54))),
    );
  }
}
