import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_event.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_state.dart';
import 'package:gramify/features/messaging/presentation/mobile/chats_page.dart';
import 'package:gramify/features/messaging/presentation/widgets/message_bubble.dart';
import 'package:ionicons/ionicons.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({
    super.key,
    required this.userid,
    this.imageUrl,
    required this.username,
    required this.chatId,
  });

  final String userid;
  final String? imageUrl;
  final String username;
  final String chatId;

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController chatScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MessageBloc>().add(
      ChattingScreenRequested(userId: widget.userid),
    );
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
    chatScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 1),
            child: Container(
              height: 1,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white10),
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ChatsPage()),
              );
            },
            child: const Icon(
              Ionicons.chevron_back_outline,
              color: Colors.white,
              size: 22,
            ),
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              CircleAvatar(
                radius: screenWidth / 22,
                backgroundImage:
                    widget.imageUrl != null
                        ? NetworkImage(widget.imageUrl!)
                        : null,
                child:
                    widget.imageUrl != null
                        ? null
                        : Icon(Ionicons.person_outline, size: screenWidth / 25),
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.username,
                    style: txtStyle(subTitle20, Colors.white),
                  ),
                  Text('Online', style: txtStyle(small12, Colors.white)),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const Gap(5),
            Expanded(
              child: BlocConsumer<MessageBloc, MessageState>(
                builder: (context, state) {
                  if (state is MessageLoadingState) {
                    log('MessageLoadingState');
                    return Center(
                      child: Text(
                        'Loading Chats...',
                        style: txtStyle(22, Colors.grey.shade800),
                      ),
                    );
                  }
                  if (state is LoadUserMessageFailureState) {
                    log('LoadUserChatsFailureState');

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
                  if (state is LoadUserMessageState) {
                    return StreamBuilder(
                      stream: state.messages,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Text('Say Hi to ${widget.username}'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return MessageBubble(
                                isRight:
                                    state.loggedUserId ==
                                    snapshot.data![index].senderId,
                                message: snapshot.data![index].message,
                                messageTime: snapshot.data![index].messageTime,
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
                listener: (context, state) {
                  if (state is RoomSetState) {
                    context.read<MessageBloc>().add(
                      LoadMessagesRequested(chatID: state.chatID),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              height: screenHeight / 9,
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Colors.white10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: txtStyle(bodyText16, whiteForText),
                      maxLines: 30,
                      decoration: InputDecoration(
                        hintText: 'Type your message here...',
                        hintStyle: txtStyle(bodyText14, Colors.grey.shade700),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
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
                            receipintId: widget.userid,
                            message: messageController.text.trim(),
                            chatId: widget.chatId,
                          ),
                        );

                        messageController.clear();
                      },
                      icon: const ShaderIcon(iconWidget: Icon(Ionicons.send)),
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
