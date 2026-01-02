import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gramify/core/theme/spacing.dart';

Widget kSsoButton({required IconData icon}) => Expanded(
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodyLarge, horizontal: AppSpacing.bodymedium),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white, border: Border.all(width: 2, color: Colors.grey.shade400)),
    child: Center(child: FaIcon(icon)),
  ),
);
