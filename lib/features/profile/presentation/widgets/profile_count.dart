import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_state.dart';

class ProfileCount extends StatelessWidget {
  const ProfileCount({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileDataFetchSuccessState) {
              return Text(
                index == 1
                    ? '0'
                    : index == 2
                    ? state.userdata.followersCount.toString()
                    : state.userdata.followingCount.toString(),
                style: txtStyle(
                  bodyText16,
                  Colors.white,
                ).copyWith(fontWeight: FontWeight.w700),
              );
            }
            if (state is OtherUserProfileFetchedState) {
              return Text(
                index == 1
                    ? '0'
                    : index == 2
                    ? state.userdata.followersCount.toString()
                    : state.userdata.followingCount.toString(),
                style: txtStyle(
                  bodyText16,
                  Colors.white,
                ).copyWith(fontWeight: FontWeight.w700),
              );
            }
            return const Text('');
          },
        ),
        Text(
          index == 1
              ? 'posts'
              : index == 2
              ? 'followers'
              : 'following',
          style: txtStyle(
            bodyText14,
            Colors.white,
          ).copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
