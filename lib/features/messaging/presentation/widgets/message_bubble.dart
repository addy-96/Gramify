import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isRight,
    required this.message,
  });

  final bool isRight;
  final String message;

  @override
  Widget build(BuildContext context) {
    final bubbleRadius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: Radius.circular(isRight ? 20 : 0),
      bottomRight: Radius.circular(isRight ? 0 : 20),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Align(
        alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: bubbleRadius,
            gradient:
                isRight
                    ? const LinearGradient(
                      colors: [thmegrad1, thmegrad2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                    : null,
            color:
                isRight
                    ? null
                    : Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withOpacity(0.95),
            border:
                isRight ? null : Border.all(color: thmegrad1.withOpacity(0.5)),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: bubbleRadius,
            ),
            child: Text(
              message,
              style: isRight ? txtStyle(16, whiteForText) : txtStyleNoColor(16),
            ),
          ),
        ),
      ),
    );
  }
}
