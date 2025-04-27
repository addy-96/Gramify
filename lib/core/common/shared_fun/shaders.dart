import 'package:flutter/widgets.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';

class ShaderNormal extends StatelessWidget {
  const ShaderNormal({super.key, required this.childWidget});
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => LinearGradient(
            colors: [thmegrad1, thmegrad2],
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      blendMode: BlendMode.srcIn,
      child: childWidget,
    );
  }
}

class ShaderText extends StatelessWidget {
  const ShaderText({super.key, required this.textWidget});

  final Text textWidget;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => LinearGradient(
            colors: [thmegrad1, thmegrad2],
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: textWidget,
    );
  }
}

class ShaderIamge extends StatelessWidget {
  const ShaderIamge({super.key, required this.imageWidget});

  final Image imageWidget;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => LinearGradient(
            colors: [thmegrad1, thmegrad2],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      blendMode: BlendMode.srcIn,
      child: imageWidget,
    );
  }
}

class ShaderIcon extends StatelessWidget {
  const ShaderIcon({super.key, required this.iconWidget});

  final Icon iconWidget;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => LinearGradient(
            colors: [Color(0xFF4E9F3D), Color(0xFF3AAFA9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      blendMode: BlendMode.srcIn,
      child: iconWidget,
    );
  }
}
