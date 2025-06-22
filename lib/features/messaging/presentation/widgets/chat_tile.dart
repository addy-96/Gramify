import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final supabase = Supabase.instance;
        log('tapped');
        try {
          var loggedUSerID = await getLoggedUserId();
          final getListOfChatId = await supabase.client
              .from(userTable)
              .select('chats')
              .eq('user_id', loggedUSerID);

          List<dynamic> listofFinalchats = [];
          final listOfUserChats = getListOfChatId.first['chats'];
          for (var chatId in listOfUserChats) {
            final getParticipants = await supabase.client
                .from(chatsTable)
                .select()
                .eq('chat_id', chatId);

            final par1 = getParticipants.first['participant_1'];
            final par2 = getParticipants.first['participant_2'];
            log('par1 : $par1');
            log('par2 : $par2');
            final endParticipantsId = par1 == loggedUSerID ? par2 : par1;
            listofFinalchats.add(endParticipantsId);
          }
          for (var item in listofFinalchats) {
            log(item.toString());
          }
        } catch (err) {}
      },
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
