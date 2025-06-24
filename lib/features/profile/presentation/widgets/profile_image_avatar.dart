import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_state.dart';
import 'package:ionicons/ionicons.dart';

class ProfileImageAvatar extends StatelessWidget {
  const ProfileImageAvatar({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileDataFetchSuccessState) {
          return CircleAvatar(
            radius: screenWidth / 12,
            backgroundColor: Colors.grey.shade800,
            backgroundImage:
                state.userdata.profileImageUrl != null
                    ? NetworkImage(state.userdata.profileImageUrl!, scale: 1)
                    : null,
            child:
                state.userdata.profileImageUrl == null
                    ? const Icon(Ionicons.person_outline)
                    : null,
          );
        }
        if (state is OtherUserProfileFetchedState) {
          return CircleAvatar(
            radius: screenWidth / 12,
            backgroundColor: Colors.grey.shade800,
            backgroundImage:
                state.userdata.profileImageUrl != null
                    ? NetworkImage(state.userdata.profileImageUrl!, scale: 1)
                    : null,
            child:
                state.userdata.profileImageUrl == null
                    ? const Icon(Ionicons.person_outline)
                    : null,
          );
        }
        return CircleAvatar(
          backgroundColor: Colors.grey.shade800,
          radius: screenWidth / 12,
          child: const Icon(Ionicons.person_outline),
        );
      },
    );
  }
}
