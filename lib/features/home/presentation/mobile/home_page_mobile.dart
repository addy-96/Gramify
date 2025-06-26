import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/features/home/presentation/widgets/post_section.dart';
import 'package:gramify/features/home/presentation/widgets/story_section.dart';
import 'package:gramify/features/messaging/presentation/mobile/chats_page.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
            onPressed: () async {},
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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(15),
          //   const StorySection(),
          Gap(5),
          PostSection(),
        ],
      ),
    );
  }
}
