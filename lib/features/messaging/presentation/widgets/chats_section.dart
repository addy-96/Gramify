import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_event.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_state.dart';
import 'package:gramify/features/messaging/presentation/widgets/chat_tile.dart';

class ChatsSection extends StatefulWidget {
  const ChatsSection({super.key});

  @override
  State<ChatsSection> createState() => _ChatsSectionState();
}

class _ChatsSectionState extends State<ChatsSection> {
  @override
  void initState() {
    context.read<MessageBloc>().add(ChatsScreenRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<MessageBloc, MessageState>(
        listener: (context, state) {
          if (state is LoadUserChatsFailureState) {
            csnack(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is ChatsLoadedState) {
            if (state.chatsList.isEmpty) {
              return Center(
                child: Text(
                  'No chats, try starting one, click on search icon to search users!',
                  style: txtStyle(small12, Colors.grey.shade800),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.chatsList.length,
              itemBuilder:
                  (context, index) =>
                      ChatTile(chatUserModel: state.chatsList[index]),
            );
          }
          if (state is ChatLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: Text('No-State'));
        },
      ),
    );
  }
}
