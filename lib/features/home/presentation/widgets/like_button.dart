import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_event.dart';
import 'package:gramify/features/home/presentation/bloc/post_bloc/post_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/post_bloc/post_event.dart';
import 'package:ionicons/ionicons.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final String postId;

  const LikeButton({Key? key, required this.isLiked, required this.postId})
    : super(key: key);

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
      icon: Icon(
        isLiked ? Ionicons.heart : Ionicons.heart_outline,
        color: Colors.red[800],
      ),
    );
  }
}
