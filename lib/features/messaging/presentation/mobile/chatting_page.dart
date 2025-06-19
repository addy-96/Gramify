import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/messaging/domain/model/message_model.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_event.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_state.dart';
import 'package:gramify/features/messaging/presentation/mobile/chats_page.dart';
import 'package:ionicons/ionicons.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({
    super.key,
    required this.userid,
    this.imageUrl,
    required this.username,
    required this.chatId,
  });
  final String chatId;
  final String userid;
  final String? imageUrl;
  final String username;

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [thmegrad1, thmegrad2],
              ),
            ),
            child: Row(
              children: [
                const Gap(5),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ChatsPage(),
                      ),
                    );
                  },
                  child: Icon(
                    Ionicons.chevron_back_outline,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          widget.imageUrl != null
                              ? NetworkImage(widget.imageUrl!)
                              : null,
                      child:
                          widget.imageUrl != null
                              ? null
                              : const Icon(Ionicons.person_outline),
                    ),
                    title: Text(
                      widget.username,
                      style: txtStyle(
                        22,
                        Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    subtitle: const Text('Online'),
                    subtitleTextStyle: txtStyle(
                      15,
                      Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<MessageBloc, MessageState>(
                builder: (context, state) {
                  if (state is MessageLoadingState) {
                    return Center(
                      child: Text(
                        'Loading Chats...',
                        style: txtStyle(22, Colors.grey.shade800),
                      ),
                    );
                  }
                  if (state is LoadUserChatsFailureState) {
                    return Center(
                      child: Text(
                        'Sorry! ${state.errorMessage}',
                        style: txtStyle(22, Colors.grey.shade800),
                      ),
                    );
                  }
                  if (state is MessageSentState) {
                    messageController.clear();
                  }
                  if (state is LoadUserChatsState) {
                    if (state.messages == null || state.messages!.isEmpty) {
                      return Center(
                        child: Text(
                          'Say Hi to ${widget.username}',
                          style: txtStyle(22, Colors.grey.shade800),
                        ),
                      );
                    }

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.messages!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          state.messages![index].message,
                          style: txtStyle(22, whiteForText),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
                listener: (context, state) {},
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              height: 80,
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Colors.white10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      child: TextField(
                        controller: messageController,
                        style: txtStyle(22, whiteForText),
                        maxLines: 30,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: const LinearGradient(
                        colors: [thmegrad1, thmegrad2],
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          if (messageController.text.trim().isEmpty) {
                            csnack(context, 'Please enter a message :)');
                            return;
                          }
                          context.read<MessageBloc>().add(
                            SendMessageRequested(
                              chatId: widget.chatId,
                              receipintId: widget.userid,
                              message: messageController.text.trim(),
                            ),
                          );
                          messageController.clear();
                        },
                        icon: const ShaderIcon(iconWidget: Icon(Ionicons.send)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
