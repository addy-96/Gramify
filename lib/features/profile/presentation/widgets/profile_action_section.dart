import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_event.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_state.dart';
import 'package:gramify/features/profile/presentation/mobile/edit_profile_page.dart';
import 'package:ionicons/ionicons.dart';

class ProfileActionSection extends StatelessWidget {
  const ProfileActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileDataFetchSuccessState) {
          return Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => EditProfilePage(
                              bio: state.userdata.bio,
                              fullname: state.userdata.fullname,
                              username: state.userdata.username,
                              gender: state.userdata.gender,
                              profileImgeUrl: state.userdata.profileImageUrl,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        style: txtStyle(
                          bodyText14,
                          Colors.white,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Share Profile',
                        style: txtStyle(
                          bodyText14,
                          Colors.white,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Ionicons.person_add_outline, size: bodyText16),
                ),
              ),
            ],
          );
        }
        if (state is ProfileLoadingState) {
          return const ShimmerContainer(
            height: double.minPositive,
            width: double.minPositive,
          );
        }
        if (state is OtherUserProfileFetchedState) {
          if (state.userdata.isFollowing) {
            return Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.black26,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: Container(
                                height: screenHeight / 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white10,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 18,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,

                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Would You like to unfollow ${state.userdata.username}?',
                                              maxLines: 2,
                                              softWrap: true,
                                              style: txtStyle(
                                                bodyText16,
                                                Colors.white70,
                                              ).copyWith(
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(10),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: txtStyle(
                                                  bodyText14,
                                                  Colors.white70,
                                                ).copyWith(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Gap(10),
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                context.read<ProfileBloc>().add(
                                                  UnfollowRequested(
                                                    otherUserProfileModel:
                                                        state.userdata,
                                                  ),
                                                );
                                              },
                                              child: ShaderText(
                                                textWidget: Text(
                                                  'Unfollow',
                                                  style: txtStyleNoColor(
                                                    bodyText14,
                                                  ).copyWith(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShaderText(
                              textWidget: Text(
                                'Following',
                                style: txtStyle(
                                  small12,
                                  Colors.white,
                                ).copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Gap(10),
                            const ShaderIcon(
                              iconWidget: Icon(
                                Ionicons.chevron_down_sharp,
                                size: bodyText14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Message',
                          style: txtStyle(
                            small12,
                            Colors.white,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Ionicons.person_add, size: 12),
                  ),
                ),
              ],
            );
          }
          if (!state.userdata.isFollowing) {
            return Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      context.read<ProfileBloc>().add(
                        FollowRequested(otherUserProfileModel: state.userdata),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          colors: [thmegrad1, thmegrad2],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Follow',
                          style: txtStyle(
                            small12,
                            Colors.black,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Ionicons.person_add, size: 12),
                  ),
                ),
              ],
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
