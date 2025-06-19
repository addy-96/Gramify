import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_event.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_state.dart';
import 'package:gramify/features/home/presentation/widgets/post.dart';
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
  void initState() {
    super.initState();
    context.read<HomepageBloc>().add(FeedsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actionsPadding: const EdgeInsets.all(4),
        forceMaterialTransparency: true,
        title: SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12),
                  child: ShaderIamge(
                    imageWidget: Image.asset('assets/images/logo_black.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const ShaderIcon(
              iconWidget: Icon(Ionicons.heart_outline, size: 30),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => ChatsPage()));
            },
            icon: const ShaderIcon(
              iconWidget: Icon(Ionicons.send_outline, size: 30),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 9,
            width: double.infinity,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [thmegrad1, thmegrad2],
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          radius: MediaQuery.of(context).size.width / 12,
                        ),
                      ),
                    ),

                    const Positioned(
                      bottom: 4,
                      right: 4,
                      child: ShaderIcon(iconWidget: Icon(Ionicons.add_circle)),
                    ),
                  ],
                ),
                const Gap(10),
                for (var i = 0; i <= 10; i++)
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [thmegrad1, thmegrad2],
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: MediaQuery.of(context).size.width / 12,
                          ),
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
              ],
            ),
          ),
          const Gap(5),
          // Posts Section
          Expanded(
            child: BlocBuilder<HomepageBloc, HomepageState>(
              builder: (context, state) {
                if (state is HomePageLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FeedsFetchedState) {
                  return ListView.builder(
                    itemCount: state.feedList.length,
                    itemBuilder: (context, index) {
                      final feed = state.feedList[index];
                      return Column(
                        children: [
                          Post(
                            postId: feed.postId,
                            createdAt: feed.createdAt,
                            posterUserId: feed.posterUserId,
                            caption: feed.caption,
                            imageUrl: feed.imageUrl,
                            likesCount: feed.likesCount,
                            username: feed.username,
                          ),
                          const Gap(10),
                        ],
                      );
                    },
                  );
                }
                return const Center(
                  child: Text('No Feeds to show, follw more people : )'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
