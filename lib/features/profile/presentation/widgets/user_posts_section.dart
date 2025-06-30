import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_state.dart';
import 'package:gramify/main_presentaiton/wrapper_bloc/wrapper_bloc.dart';
import 'package:ionicons/ionicons.dart';

class UserPostsSection extends StatelessWidget {
  const UserPostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDataFetchSuccessState) {
            if (state.userdata.userPostMap.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Creat your first post!',
                    style: txtStyle(subTitle18, Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<WrapperBloc>().add(
                        PageChageRequestedMobile(selectedIndex: 1),
                      );
                    },
                    child: ShaderText(
                      textWidget: Text(
                        'Creat now',
                        style: txtStyleNoColor(
                          bodyText16,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );
            }
            return GridView.builder(
              itemCount: state.userdata.userPostMap.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                final entry = state.userdata.userPostMap.entries.elementAt(
                  index,
                );
                final imageUrl = entry.value;
                log(imageUrl);
                return Image.network(imageUrl);
              },
            );
          }
          if (state is OtherUserProfileFetchedState) {
            if (!state.userdata.isFollowing) {
              if (state.userdata.isPrivate) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Account is private!',
                      style: txtStyle(
                        subTitle18,
                        Colors.white,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Gap(5),
                    TextButton(
                      onPressed: () {},
                      child: ShaderIcon(
                        iconWidget: Icon(
                          Ionicons.lock_closed_outline,
                          size: MediaQuery.of(context).size.width * 0.2,
                        ),
                      ),
                    ),
                    const Gap(5),
                    Text(
                      'Follow to see user posts!',
                      style: txtStyle(bodyText14, Colors.grey.shade700),
                    ),
                  ],
                );
              } else if (!state.userdata.isPrivate) {
                //to return user posts
              }
            }
            if (state.userdata.isFollowing) {
              // to return user posts
            }
          }

          if (state is OtherUserProfileFetchedState) {}
          if (state is ProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
