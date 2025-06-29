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
import 'package:gramify/features/messaging/presentation/widgets/chats_section.dart';
import 'package:gramify/features/messaging/presentation/widgets/online_users_section.dart';
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
              return TextField(
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              );
            }
            return Text(
              'Messages',
              style: txtStyle(
                subTitle22,
                Colors.white70,
              ).copyWith(fontWeight: FontWeight.w400),
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
                  return const Icon(CupertinoIcons.multiply, size: subTitle20);
                }
                if (state is SearchBoxClosedUIState) {
                  return const Icon(Ionicons.search_outline, size: subTitle20);
                }
                return const Icon(Ionicons.search_outline, size: subTitle20);
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
                            style: txtStyle(bodyText16, Colors.white),
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
                              lastSeen: state.searchedUserList![index].dateTime,
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
    const OnlineUsersSection(),
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
