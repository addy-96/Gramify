import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_event.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_state.dart';
import 'package:ionicons/ionicons.dart';

class OnlineUsersSection extends StatefulWidget {
  const OnlineUsersSection({super.key});

  @override
  State<OnlineUsersSection> createState() => _OnlineUsersSectionState();
}

class _OnlineUsersSectionState extends State<OnlineUsersSection> {
  @override
  void initState() {
    super.initState();
    context.read<MessageBloc>().add(GetOnlineUserRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is OnlineUserFetchErrorState) {
          log('in error state');
          log(state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is OnlineUserFetchedState) {
          if (state.listOfOnlineUser.isEmpty) {
            return const SizedBox.shrink();
          } else if (state.listOfOnlineUser.isNotEmpty) {
            return ListView.builder(
              itemCount: state.listOfOnlineUser.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage:
                          state.listOfOnlineUser[index].profileImageUrl != null
                              ? NetworkImage(
                                state.listOfOnlineUser[index].profileImageUrl!,
                              )
                              : null,
                      child:
                          state.listOfOnlineUser[index].profileImageUrl != null
                              ? const Icon(Ionicons.person_outline)
                              : null,
                    ),
                    const Gap(5),
                    Text(
                      state.listOfOnlineUser[index].username,
                      style: txtStyle(bodyText14, Colors.white),
                    ),
                  ],
                );
              },
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
