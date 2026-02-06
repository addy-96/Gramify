import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/text_styles.dart';

class AppDropDown extends StatefulWidget {
  const AppDropDown({super.key, required this.defaultText, required this.options});
  final String defaultText;
  final List<String> options;

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  OverlayEntry? _overlayEntry;
  String? selectedOption;

  void _showMenu() async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _overlayEntry?.remove();
            _overlayEntry = null;
          },
          child: Stack(
            children: [
              Positioned(
                top: position.dy + size.height,
                left: 40,
                right: 40,
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          widget.options
                              .map(
                                (option) => InkWell(
                                  splashColor: Appcolors.gradientMint,
                                  onTap: () {
                                    _overlayEntry?.remove();
                                    _overlayEntry = null;
                                    setState(() {
                                      selectedOption = option;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: option == selectedOption ? Appcolors.gradientMint.withValues(alpha: 0.5) : Colors.transparent,
                                    ),
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    child: Text(option, style: AppTextStyles.bodyLarge()),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _showMenu();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedOption ?? widget.defaultText,
              style: AppTextStyles.bodyLarge().copyWith(fontWeight: FontWeight.bold, color: selectedOption == null ? Colors.grey.shade500 : Colors.black),
            ),
            FaIcon(FontAwesomeIcons.caretDown, size: 16, color: Colors.grey.shade500),
          ],
        ),
      ),
    );
  }
}
