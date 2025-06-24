import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_event.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_state.dart';
import 'package:gramify/features/messaging/presentation/bloc/ui/messaging_ui_bloc.dart';
import 'package:gramify/features/messaging/presentation/bloc/ui/messaging_ui_event.dart';
import 'package:gramify/features/messaging/presentation/bloc/ui/messaging_ui_state.dart';
import 'package:gramify/features/messaging/presentation/widgets/chat_tile.dart';
import 'package:gramify/features/messaging/presentation/widgets/chats_section.dart';
import 'package:gramify/features/messaging/presentation/widgets/search_tile.dart';
import 'package:ionicons/ionicons.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  bool seracchBoxState = false;

  var searchBarOffset = const Offset(1, 1.5);

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BlocBuilder<MessagingUiBloc, MessagingUiState>(
          builder: (context, state) {
            if (state is SearchBoxOpenUIState) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(width: 1.5, color: Colors.white70),
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      context.read<MessageBloc>().add(
                        SearchUserRequested(
                          inputString: searchController.text.trim(),
                        ),
                      );
                    },
                    controller: searchController,
                    style: txtStyle(18, whiteForText),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: txtStyle(16, Colors.white30),
                      contentPadding: const EdgeInsets.all(8),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              );
            }
            return Text(
              'Messages',
              style: txtStyleNoColor(28).copyWith(fontWeight: FontWeight.w400),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              seracchBoxState = !seracchBoxState;
              context.read<MessagingUiBloc>().add(
                SearchBoxToggledUIevent(action: seracchBoxState),
              );
            },
            icon: BlocBuilder<MessagingUiBloc, MessagingUiState>(
              builder: (context, state) {
                if (state is SearchBoxOpenUIState) {
                  return const Icon(CupertinoIcons.multiply, size: 30);
                }
                if (state is SearchBoxClosedUIState) {
                  return const Icon(Ionicons.search_outline, size: 30);
                }
                return const Icon(Ionicons.search_outline, size: 30);
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<MessagingUiBloc, MessagingUiState>(
        builder: (context, state) {
          if (state is SearchBoxOpenUIState) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: BlocBuilder<MessageBloc, MessageState>(
                builder: (context, state) {
                  if (state is SearchedUserState) {
                    if ((state.searchedUserList == null ||
                            state.searchedUserList!.isEmpty) &&
                        (searchController.text.trim().isEmpty)) {
                      return Center(
                        child: ShaderText(
                          textWidget: Text(
                            'Try Searching...',
                            style: txtStyleNoColor(22),
                          ),
                        ),
                      );
                    } else if ((state.searchedUserList == null ||
                            state.searchedUserList!.isEmpty) &&
                        (searchController.text.trim().isNotEmpty)) {
                      return Center(
                        child: ShaderText(
                          textWidget: Text(
                            'No User Found!',
                            style: txtStyleNoColor(22),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: state.searchedUserList!.length,
                        itemBuilder:
                            (context, index) => SearchTile(
                              chatID: state.searchedUserList![index].chatID,
                              imageUrl:
                                  state
                                      .searchedUserList![index]
                                      .profileImageUrl,
                              userid: state.searchedUserList![index].userId,
                              username: state.searchedUserList![index].username,
                            ),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            );
          }
          return defaultBody();
        },
      ),
    );
  }
}

Widget defaultBody() => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i <= 5; i++)
            Container(
              padding: const EdgeInsets.all(6),
              child: const CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white10,
              ),
            ),
        ],
      ),
    ),
    const Gap(20),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Material(
          elevation: 20,
          type: MaterialType.card,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Text(
                  'Chats',
                  style: txtStyle(
                    subTitle18,
                    Colors.white60,
                  ).copyWith(fontWeight: FontWeight.normal),
                ),
                const ChatsSection(),
              ],
            ),
          ),
        ),
      ),
    ),
  ],
);
