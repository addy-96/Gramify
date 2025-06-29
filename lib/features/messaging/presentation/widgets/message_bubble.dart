import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/cal_fun.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isRight,
    required this.message,
    required this.messageTime,
  });

  final bool isRight;
  final String message;
  final DateTime messageTime;

  @override
  Widget build(BuildContext context) {
    final bubbleRadius = BorderRadius.only(
      topLeft: const Radius.circular(14),
      topRight: const Radius.circular(14),
      bottomLeft: Radius.circular(isRight ? 14 : 0),
      bottomRight: Radius.circular(isRight ? 0 : 14),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Align(
        alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: bubbleRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(message, style: txtStyle(bodyText14, Colors.grey.shade400)),
              Text(
                calculateMessageTime(messageTime),
                style: txtStyle(10, Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
