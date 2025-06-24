import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_event.dart';
import 'package:gramify/features/home/presentation/bloc/post_bloc/post_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/post_bloc/post_event.dart';
import 'package:ionicons/ionicons.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final String postId;
  final int likesCount;

  const LikeButton({
    super.key,
    required this.isLiked,
    required this.postId,
    required this.likesCount,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Trigger like action (update on server via PostBloc)
        context.read<PostBloc>().add(PostLikeActionRequested(postId: postId));

        // Update the UI feed (via HomepageBloc)
        context.read<HomepageBloc>().add(
          UpdateFeedPostLikeStatus(
            postId: postId,
            isLiked: !isLiked, // toggle
          ),
        );
      },
      icon: Row(
        children: [
          Icon(
            isLiked ? Ionicons.heart : Ionicons.heart_outline,
            color: Colors.red[800],
          ),
          const Gap(2),
          likesCount != 0
              ? Text(
                likesCount.toString(),
                style: txtStyle(small12, Colors.white70).copyWith(),
                textAlign: TextAlign.center,
              )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
