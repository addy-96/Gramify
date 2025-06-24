import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_state.dart';

class UserPostsSection extends StatelessWidget {
  const UserPostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDataFetchSuccessState) {
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

          if (state is ProfileLoadingState) {
            return const ShimmerContainer(
              height: double.infinity,
              width: double.infinity,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
