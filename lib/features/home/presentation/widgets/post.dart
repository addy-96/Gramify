import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/cal_fun.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/home/domain/models/post_model.dart';
import 'package:gramify/features/home/presentation/widgets/comments_model_sheet.dart';
import 'package:gramify/features/home/presentation/widgets/like_button.dart';
import 'package:ionicons/ionicons.dart';

class Post extends StatelessWidget {
  const Post({super.key, required this.post});

  final PostModel post;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWeidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        height: screenHeight / 1.7,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Colors.white12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: Row(
                children: [
                  Container(
                    height:
                        screenWeidth < 600
                            ? 30
                            : screenWeidth >= 600 && screenWeidth <= 1300
                            ? 35
                            : 40,
                    width:
                        screenWeidth < 600
                            ? 30
                            : screenWeidth >= 600 && screenWeidth <= 1300
                            ? 35
                            : 40,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child:
                        post.posterProfileImageUrl != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                post.posterProfileImageUrl!,
                                fit: BoxFit.cover,
                              ),
                            )
                            : const Icon(
                              Ionicons.person_outline,
                              size: bodyText16,
                            ),
                  ),
                  const Gap(10),
                  Text(
                    post.fullname,
                    style: txtStyle(
                      bodyText16,
                      Colors.white,
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const Gap(15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.assetNetwork(
                    placeholderFit: BoxFit.contain,
                    placeholder: 'assets/images/logo_black.png',
                    placeholderColor:
                        Colors.white10, // Make sure this asset exists
                    image: post.postimageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 100),
                    imageErrorBuilder:
                        (context, error, stackTrace) =>
                            Container(color: Colors.grey[300]),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                LikeButton(
                  isLiked: post.isLiked,
                  postId: post.postId,
                  likesCount: post.likesCount,
                ),
                IconButton(
                  onPressed: () {
                    openCommentModalSheet(context, postId: post.postId);
                  },
                  icon: Row(
                    children: [
                      const Icon(Ionicons.chatbubbles_outline),
                      const Gap(2),
                      post.commentsCount != 0
                          ? Text(
                            post.commentsCount.toString(),
                            style: txtStyle(small12, Colors.white).copyWith(),
                            textAlign: TextAlign.center,
                          )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.send_outline),
                  color: Colors.white,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Ionicons.bookmark_outline),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            post.caption != null
                ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    post.caption,
                    style: txtStyle(bodyText14, whiteForText),
                  ),
                )
                : const SizedBox.shrink(),
            Row(
              mainAxisAlignment:
                  post.commentsCount == 0
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.spaceBetween,
              children: [
                post.commentsCount != 0
                    ? TextButton(
                      onPressed: () {
                        openCommentModalSheet(context, postId: post.postId);
                      },
                      child: Text(
                        'View all Comments (${post.commentsCount})',
                        style: txtStyle(
                          small12,
                          Colors.grey.shade600,
                        ).copyWith(fontWeight: FontWeight.w400),
                      ),
                    )
                    : const SizedBox.shrink(),
                Row(
                  children: [
                    Icon(
                      Ionicons.time_outline,
                      size: 18,
                      color: Colors.grey.shade700,
                    ),
                    const Gap(5),
                    Text(
                      calculatePostUploadTime(post.createdAt),
                      style: txtStyle(
                        small12,
                        Colors.grey.shade600,
                      ).copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            // Caption
          ],
        ),
      ),
    );
  }
}
