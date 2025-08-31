import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_fun/cal_fun.dart';
import 'package:gramify/features/add_post/presentation/mobile/camera_page_for_post.dart';
import 'package:gramify/features/home/presentation/widgets/post_section.dart';
import 'package:gramify/features/home/presentation/widgets/story_section.dart';
import 'package:gramify/features/messaging/presentation/mobile/chats_page.dart';
import 'package:ionicons/ionicons.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key, required this.loggedUserId});
  final String loggedUserId;

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CameraPageForPost()));
          },
          icon: Icon(Ionicons.camera_outline, size: getWidth(context) / 15),
        ),

        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actionsPadding: const EdgeInsets.all(4),
        forceMaterialTransparency: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Ionicons.heart_outline, size: getWidth(context) / 15)),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChatsPage()));
            },
            icon: Icon(Ionicons.chatbox_ellipses_outline, size: getWidth(context) / 15),
          ),
        ],
      ),
      body: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Gap(15), StorySection(), Gap(5), PostSection(),],),
    );
  }
}
