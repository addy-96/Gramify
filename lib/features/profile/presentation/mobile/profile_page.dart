import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_event.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_state.dart';
import 'package:gramify/features/profile/presentation/mobile/post_overview.dart';
import 'package:ionicons/ionicons.dart';

class ProfilePageMobile extends StatefulWidget {
  const ProfilePageMobile({super.key, required this.userId});
  final String? userId;

  @override
  State<ProfilePageMobile> createState() => _ProfilePageMobileState();
}

class _ProfilePageMobileState extends State<ProfilePageMobile> {
  @override
  void initState() {
    super.initState();
    if (widget.userId == null) {
      context.read<ProfileBloc>().add(ProfileDataRequested());
    } else if (widget.userId != null) {
      context.read<ProfileBloc>().add(
        ProfileOfOtherUserRequested(userIDforAction: widget.userId!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOwnProfile = widget.userId == null;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is FollowedUserSuccessState &&
                        widget.userId != null) {
                      context.read<ProfileBloc>().add(
                        ProfileOfOtherUserRequested(
                          userIDforAction: widget.userId!,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    String username = 'Username';
                    if (isOwnProfile && state is ProfileDataFetchSuccessState) {
                      username = state.userdata.username;
                    } else if (!isOwnProfile &&
                        state is OtherUserProfileFetchedState) {
                      username = state.userdata.username;
                    }
                    if (state is ProfileLoadingState) {
                      return const ShimmerContainer(height: 60, width: 60);
                    }
                    return ShaderText(
                      textWidget: Text(username, style: txtStyleNoColor(22)),
                    );
                  },
                ),
                if (isOwnProfile)
                  IconButton(
                    onPressed:
                        () => context.read<AuthBloc>().add(LogOutRequested()),
                    icon: const Icon(Ionicons.log_out),
                  ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            child: Column(
              children: [
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProfileAvatarAndName(isOwnProfile: isOwnProfile),
                    if (!isOwnProfile)
                      _FollowMessageButtons(userID: widget.userId!),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: _ProfileCount(
                        isOwnProfile: isOwnProfile,
                        isFollowers: false,
                      ),
                    ),
                    Expanded(
                      child: _ProfileCount(
                        isOwnProfile: isOwnProfile,
                        isFollowers: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ProfileDataFetchSuccessState) {
                  return PostOverview(postMap: state.userdata.userPostMap);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileAvatarAndName extends StatelessWidget {
  final bool isOwnProfile;
  const ProfileAvatarAndName({super.key, required this.isOwnProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: const LinearGradient(colors: [thmegrad1, thmegrad2]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  String? imageUrl;
                  if (isOwnProfile && state is ProfileDataFetchSuccessState) {
                    imageUrl = state.userdata.profileImageUrl;
                  } else if (!isOwnProfile &&
                      state is OtherUserProfileFetchedState) {
                    imageUrl = state.userdata.profileImageUrl;
                  }
                  if (imageUrl == null) {
                    return const ShaderIcon(iconWidget: Icon(Ionicons.person));
                  }
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  );
                },
              ),
            ),
          ),
        ),
        const Gap(5),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            String fullname = 'Full Name';
            if (isOwnProfile && state is ProfileDataFetchSuccessState) {
              fullname = state.userdata.fullname;
            } else if (!isOwnProfile && state is OtherUserProfileFetchedState) {
              fullname = state.userdata.fullname;
            }
            return Text(
              fullname,
              style: txtStyle(
                15,
                whiteForText,
              ).copyWith(fontWeight: FontWeight.w100),
            );
          },
        ),
      ],
    );
  }
}

class _ProfileCount extends StatelessWidget {
  final bool isOwnProfile;
  final bool isFollowers;
  const _ProfileCount({required this.isOwnProfile, required this.isFollowers});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              int? count;
              if (isOwnProfile && state is ProfileDataFetchSuccessState) {
                count =
                    isFollowers
                        ? state.userdata.followersCount
                        : state.userdata.followingCount;
              } else if (!isOwnProfile &&
                  state is OtherUserProfileFetchedState) {
                count =
                    isFollowers
                        ? state.userdata.followersCount
                        : state.userdata.followingCount;
              }
              if (count != null) {
                return ShaderText(
                  textWidget: Text(
                    count.toString(),
                    style: txtStyle(
                      18,
                      whiteForText,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                );
              }
              return const ShimmerContainer(
                height: double.minPositive,
                width: 60,
              );
            },
          ),
          ShaderText(
            textWidget: Text(
              isFollowers ? 'Followers' : 'Following',
              style: txtStyle(15, whiteForText),
            ),
          ),
        ],
      ),
    );
  }
}

class _FollowMessageButtons extends StatelessWidget {
  final String userID;
  const _FollowMessageButtons({required this.userID});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is OtherUserProfileFetchedState) {
          if (state.userdata.isFollowing == true) {
            return Column(
              children: [
                _ProfileActionButton(label: 'Following', onTap: () {}),
                const Gap(10),
                _ProfileActionButton(label: 'Message', onTap: () {}),
              ],
            );
          } else if (state.userdata.isFollowing == false) {
            return _ProfileActionButton(
              label: 'Follow',
              onTap: () {
                context.read<ProfileBloc>().add(
                  FollowRequested(followedId: userID),
                );
              },
              textColor: Colors.white,
            );
          } else {
            return const Text('error received null from server!');
          }
        }
        if (state is ProfileErrorState) {
          return Text('error : ${state.errorMessage}');
        }
        return const ShimmerContainer(height: 30, width: 100);
      },
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? textColor;
  const _ProfileActionButton({
    required this.label,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(colors: [thmegrad1, thmegrad2]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Center(
              child: ShaderText(
                textWidget: Text(
                  label,
                  style:
                      textColor != null
                          ? txtStyle(18, textColor!)
                          : txtStyleNoColor(18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
