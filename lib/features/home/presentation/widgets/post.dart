import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
    required this.postId,
    required this.createdAt,
    required this.posterUserId,
    required this.caption,
    required this.imageUrl,
    required this.likesCount,
    required this.username,
  });

  final String postId;
  final DateTime createdAt;
  final String posterUserId;
  final String caption;
  final String imageUrl;
  final int likesCount;
  final String username;

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.height / 2.5;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      child: InkWell(
        enableFeedback: false,
        borderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  FadeInImage.assetNetwork(
                    placeholderFit: BoxFit.contain,
                    placeholder: 'assets/images/logo_black.png',
                    placeholderColor:
                        Colors.white, // Make sure this asset exists
                    image: imageUrl,
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 100),
                    imageErrorBuilder:
                        (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          height: imageHeight,
                        ),
                  ),

                  // Gradient overlay
                  Container(
                    height: imageHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),

                  // User info
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.black45),
                          ),
                          child: const ShaderIcon(
                            iconWidget: Icon(Icons.person_outline),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          username,
                          style: txtStyle(
                            20,
                            Colors.white70,
                          ).copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  // Post actions
                  Positioned(
                    bottom: 5,
                    left: 10,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.heart_outline,
                            color: Colors.red[800],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Ionicons.share_social_outline),
                          color: Colors.white,
                        ),
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

              // Caption
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(caption, style: txtStyle(18, whiteForText)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
