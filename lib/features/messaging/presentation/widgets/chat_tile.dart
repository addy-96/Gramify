import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/calculate_upload_time.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/messaging/domain/model/chat_user_model.dart';
import 'package:gramify/features/messaging/presentation/mobile/chatting_page.dart';
import 'package:ionicons/ionicons.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chatUserModel});
  final ChatUserModel chatUserModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) => ChattingPage(
                  userid: chatUserModel.receepintUserId,
                  username: chatUserModel.receepintFullname,
                  chatId: chatUserModel.chatId,
                ),
          ),
        );
      },
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      enableFeedback: true,
      style: ListTileStyle.list,
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage:
            chatUserModel.receipintProfile != null
                ? NetworkImage(chatUserModel.receipintProfile!)
                : null,
        child:
            chatUserModel.receipintProfile == null
                ? const Icon(Ionicons.person_outline)
                : null,
      ),
      title: Text(
        chatUserModel.receepintFullname,
        style: txtStyle(bodyText16, Colors.white),
      ),
      trailing: Text(
        calulateChatLatTime(chatUserModel.createdAt),
        style: txtStyle(15, whiteForText.withOpacity(0.4)),
      ),
      subtitle: Text(
        chatUserModel.lastMessage,
        style: txtStyle(15, Colors.grey.withOpacity(0.4)),
      ),
    );
  }
}

/*          final loggedUserId = await getLoggedUserId();
          final getUserChats =
              await supabase.client
                  .from(userTable)
                  .select('chats')
                  .eq('user_id', loggedUserId)
                  .single();

          final List<dynamic> userChatsList = getUserChats['chats'];
          final List<String> talkedUSerChats = [];
          log('before : $userChatsList');
          for (var chatId in userChatsList) {
            final res =
                await supabase.client
                    .from(messageTable)
                    .select()
                    .eq('chat_id', chatId)
                    .maybeSingle();
            if (res != null) {
              talkedUSerChats.add(chatId);
            }
          }
          for (var chatID in talkedUSerChats) {
            final getParticipants =
                await supabase.client
                    .from(chatsTable)
                    .select('participant_1, participant_2')
                    .eq('chat_id', chatID)
                    .single();

            final String otherParticipant;
            if (getParticipants['participant_1'] == loggedUserId) {
              otherParticipant = getParticipants['participant_2'];
            } else {
              otherParticipant = getParticipants['participant_1'];
            }
            final getotherParticpantData =
                await supabase.client
                    .from(userTable)
                    .select()
                    .eq('user_id', otherParticipant)
                    .single();
          } */
