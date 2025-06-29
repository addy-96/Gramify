import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_state.dart';
import 'package:gramify/features/profile/presentation/widgets/profile_action_section.dart';
import 'package:gramify/features/profile/presentation/widgets/profile_count.dart';
import 'package:gramify/features/profile/presentation/widgets/profile_image_avatar.dart';

class ProfileInfoSection extends StatelessWidget {
  ProfileInfoSection({super.key});

  final TextStyle fullnameStyle = txtStyle(
    bodyText16,
    Colors.white,
  ).copyWith(fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.white24)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 18,
          vertical: 15,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProfileImageAvatar(),
                const Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileDataFetchSuccessState) {
                            return Text(
                              state.userdata.fullname,
                              style: fullnameStyle,
                            );
                          } else if (state is OtherUserProfileFetchedState) {
                            return Text(
                              state.userdata.fullname,
                              style: fullnameStyle,
                            );
                          } else if (state is ProfileLoadingState ||
                              state is ProfileInitialState) {
                            return ShimmerContainer(
                              height: bodyText16,
                              width: screenWidth / 5,
                            );
                          }
                          return const Text('Error!');
                        },
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfileCount(index: 1),
                          ProfileCount(index: 2),
                          ProfileCount(index: 3),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(15),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileDataFetchSuccessState) {
                  if (state.userdata.bio != null) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            state.userdata.bio!,
                            style: txtStyle(
                              small12,
                              Colors.white,
                            ).copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }
                if (state is ProfileLoadingState) {
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ShimmerContainer(height: bodyText14, width: 100),
                    ],
                  );
                }
                if (state is OtherUserProfileFetchedState) {
                  if (state.userdata.bio != null) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            state.userdata.bio!,
                            softWrap: true,
                            style: txtStyle(
                              small12,
                              Colors.white,
                            ).copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }
                return const SizedBox.shrink();
              },
            ),

            const Gap(17),
            const ProfileActionSection(),
          ],
        ),
      ),
    );
  }
}
