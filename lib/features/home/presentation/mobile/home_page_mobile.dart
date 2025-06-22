import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final devicePxRatioo = MediaQuery.of(context).devicePixelRatio;
    log(devicePxRatioo.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
            onPressed: () {},
            icon: Icon(Ionicons.camera_outline, size: screenWidth / 15),
          ),
        ),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actionsPadding: const EdgeInsets.all(4),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ChatsPage()),
              );
            },
            icon: Icon(
              Ionicons.chatbox_ellipses_outline,
              size: screenWidth / 15,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(15),
          //   const StorySection(),
          const Gap(5),
          PostSection(),
        ],
      ),
    );
  }
}
