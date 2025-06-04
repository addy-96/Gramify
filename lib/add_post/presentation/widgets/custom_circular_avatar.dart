import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';

class CustomCircularAvatar extends StatelessWidget {
  const CustomCircularAvatar({
    super.key,
    required this.outerDimenison,
    required this.innerDimenison,
    required this.iconSize,
    required this.iconData,
  });
  final double outerDimenison;
  final double innerDimenison;
  final double iconSize;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          child: ShaderNormal(
            childWidget: Container(
              height: outerDimenison,
              width: outerDimenison,
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.white),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
        ClipRRect(
          child: Container(
            height: innerDimenison,
            width: innerDimenison,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: ShaderIcon(iconWidget: Icon(iconData, size: iconSize)),
            ),
          ),
        ),
      ],
    );
  }
}
