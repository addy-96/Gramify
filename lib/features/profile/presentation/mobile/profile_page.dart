import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_event.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_state.dart';
import 'package:gramify/features/profile/presentation/mobile/settings_page.dart';
import 'package:gramify/features/profile/presentation/widgets/profile_action_section.dart';
import 'package:gramify/features/profile/presentation/widgets/profile_count.dart';
import 'package:gramify/features/profile/presentation/widgets/profile_info_section.dart';
import 'package:gramify/features/profile/presentation/widgets/user_posts_section.dart';
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

  final TextStyle usernameStyle = txtStyle(
    subTitle22,
    Colors.white,
  ).copyWith(fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    final isOwnProfile = widget.userId == null;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.maxFinite,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileDataFetchSuccessState) {
                return Text(state.userdata.username, style: usernameStyle);
              } else if (state is OtherUserProfileFetchedState) {
                return Text(state.userdata.username, style: usernameStyle);
              } else if (state is ProfileLoadingState ||
                  state is ProfileInitialState) {
                return ShimmerContainer(
                  height: title24,
                  width: screenWidth / 3,
                );
              }
              return const Text('Error!');
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            icon: const Icon(Ionicons.reorder_three_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          ProfileInfoSection(),
          const Gap(5),
          const UserPostsSection(),
        ],
      ),
    );
  }
}
