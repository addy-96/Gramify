import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/messaging/presentation/bloc/ui/messaging_ui_bloc.dart';
import 'package:gramify/features/messaging/presentation/bloc/ui/messaging_ui_event.dart';
import 'package:gramify/features/messaging/presentation/mobile/chatting_page.dart';
import 'package:ionicons/ionicons.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    super.key,
    required this.imageUrl,
    required this.userid,
    required this.username,
    required this.chatID,
  });
  final String userid;
  final String? imageUrl;
  final String username;
  final String chatID;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<MessagingUiBloc>().add(
          SearchBoxToggledUIevent(action: false),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder:
                (context) => ChattingPage(
                  userid: userid,
                  username: username,
                  imageUrl: imageUrl,
                  chatId: chatID,
                ),
          ),
        );
      },
      splashColor: null,
      enableFeedback: false,

      leading: CircleAvatar(
        radius: bodyText16,
        backgroundImage: imageUrl == null ? null : NetworkImage(imageUrl!),
        child:
            imageUrl == null
                ? const ShaderIcon(
                  iconWidget: Icon(Ionicons.person_outline, size: bodyText16),
                )
                : null,
      ),
      title: Text(username, style: txtStyle(bodyText16, whiteForText)),
    );
  }
}
