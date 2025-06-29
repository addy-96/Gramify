import 'package:flutter/material.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/cal_fun.dart';
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
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder:
                (context) => ChattingPage(
                  userid: chatUserModel.receepintUserId,
                  username: chatUserModel.receepintFullname,
                  chatId: chatUserModel.chatId,
                  lastSeen: chatUserModel.receipintLastSeen,
                ),
          ),
        );
      },
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      enableFeedback: true,
      style: ListTileStyle.list,
      leading: CircleAvatar(
        radius: MediaQuery.of(context).size.width / 20,
        backgroundColor: Colors.grey.shade800,
        backgroundImage:
            chatUserModel.receipintProfile != null
                ? NetworkImage(chatUserModel.receipintProfile!)
                : null,
        child:
            chatUserModel.receipintProfile == null
                ? Icon(
                  Ionicons.person_outline,
                  size: bodyText16,
                  color: Colors.grey.shade500,
                )
                : null,
      ),
      title: Text(
        chatUserModel.receepintFullname,
        style: txtStyle(bodyText16, Colors.white),
      ),
      trailing: Text(
        calulateChatLatTime(chatUserModel.createdAt),
        style: txtStyle(small12, whiteForText.withOpacity(0.4)),
      ),
      subtitle: Text(
        chatUserModel.lastMessage,
        style: txtStyle(bodyText14, Colors.grey.withOpacity(0.4)),
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
