import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gramify/core/theme/text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key, required this.hintText, this.suffixIcon, required this.controller});
  final String hintText;
  final IconData? suffixIcon;
  final TextEditingController controller;

  final double radius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: AppTextStyles.bodyLarge(),
        cursorColor: Colors.black,
        cursorRadius: const Radius.circular(10),
        cursorWidth: 2,
        cursorErrorColor: Colors.red,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon != null ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [FaIcon(suffixIcon, color: Colors.grey.shade500)]) : null,
          hintStyle: AppTextStyles.bodyLarge().copyWith(fontWeight: FontWeight.bold, color: Colors.grey.shade500),
          contentPadding: const EdgeInsets.all(20),
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius), borderSide: const BorderSide(width: 2, color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius), borderSide: const BorderSide(width: 2, color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius), borderSide: const BorderSide(width: 2, color: Colors.transparent)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius), borderSide: const BorderSide(width: 2, color: Colors.transparent)),
        ),
      ),
    );
  }
}
