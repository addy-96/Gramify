import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/text_styles.dart';

class PronounMenu extends StatefulWidget {
  const PronounMenu({super.key, required this.index});
  final int index;

  @override
  State<PronounMenu> createState() => _PronounMenuState();
}

class _PronounMenuState extends State<PronounMenu> {
  int selected = 0;

  Widget pronounItem(int i, String text) {
    final isSelected = selected == i;

    return InkWell(
      onTap: () => setState(() => selected = i),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 2, color: isSelected ? Appcolors.brandGreen : Colors.grey.shade500),
              color: isSelected ? Appcolors.gradientMint : Colors.transparent,
            ),
          ),
          const Gap(5),
          Text(text, style: AppTextStyles.bodySmall()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [pronounItem(0, 'He/Him'), pronounItem(1, 'She/Her'), pronounItem(2, 'They/Them')]);
  }
}
