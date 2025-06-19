import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/messaging/presentation/mobile/chatting_page.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      enableFeedback: true,
      style: ListTileStyle.list,
      leading: const CircleAvatar(),
      title: Text('Username', style: txtStyle(20, whiteForText)),
      trailing: Text(
        '7:30 PM',
        style: txtStyle(15, whiteForText.withOpacity(0.4)),
      ),
      subtitle: Text(
        'Wht u doin?',
        style: txtStyle(15, Colors.grey.withOpacity(0.4)),
      ),
    );
  }
}
