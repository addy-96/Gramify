import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gramify/core/theme/text_styles.dart';

class AppTextField extends StatefulWidget {
  AppTextField({super.key, required this.hintText, this.suffixIcon, required this.controller, this.validator, this.maxLength, this.inputType, this.obsecure});
  final String hintText;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  final int? maxLength;
  final TextInputType? inputType;
  bool? obsecure = false;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final double radius = 20.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: TextFormField(
        keyboardType: widget.inputType,
        maxLength: widget.maxLength,
        obscureText: widget.obsecure ?? false,
        validator: widget.validator,
        controller: widget.controller,
        style: AppTextStyles.bodyLarge(),
        cursorColor: Colors.black,
        cursorRadius: const Radius.circular(10),
        cursorWidth: 2,
        cursorErrorColor: Colors.red,
        decoration: InputDecoration(
          counterText: '',
          hintText: widget.hintText,
          suffixIcon:
              widget.suffixIcon != null
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (widget.obsecure != null) {
                            setState(() => widget.obsecure = !widget.obsecure!);
                          }
                        },
                        icon: FaIcon(widget.suffixIcon, color: Colors.grey.shade500),
                      ),
                    ],
                  )
                  : null,
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
