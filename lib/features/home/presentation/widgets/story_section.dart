import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';
import 'package:gramify/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:gramify/features/add_post/presentation/mobile/make_story_page.dart';
import 'package:gramify/features/home/presentation/bloc/story_bloc/story_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/story_bloc/story_event.dart';
import 'package:gramify/features/home/presentation/bloc/story_bloc/story_state.dart';

class StorySection extends StatefulWidget {
  const StorySection({super.key});

  @override
  State<StorySection> createState() => _StorySectionState();
}

class _StorySectionState extends State<StorySection> {
  @override
  void initState() {
    context.read<StoryBloc>().add(GetAllUserStoriesRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: screenHeight / 9,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                height: screenHeight / 14,
                width: screenWidth / 6,
                decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.white24), borderRadius: BorderRadius.circular(14)),
                child: Stack(
                  children: [
                    BlocConsumer<AddPostBloc, AddPostState>(
                      listener: (context, state) {
                        if (state is StoryUploadFailureState) {
                          csnack(context, state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        if (state is UplaodingStoryState) {
                          return const CircularProgressIndicator();
                        }
                        return ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(14),
                          child: Image.network('https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg', fit: BoxFit.cover, height: double.infinity),
                        );
                      },
                    ),
                    Center(
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MakeStoryPage()));
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              const VerticalDivider(),
              const Gap(10),
              BlocBuilder<StoryBloc, StoryState>(
                builder: (context, state) {
                  if (state is LoadingAllStoryState) {
                    return Row(
                      children: [
                        for (var i = 0; i <= 4; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ClipRRect(borderRadius: BorderRadiusGeometry.circular(14), child: ShimmerContainer(height: screenHeight / 14, width: screenWidth / 6)),
                          ),
                      ],
                    );
                  } else if (state is AllStoriesLoadedState) {
                    final listOfStories = state.stories;
                    for (var story in listOfStories) {
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          height: screenHeight / 14,
                          width: screenWidth / 6,
                          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey.shade500), borderRadius: BorderRadius.circular(14)),
                          child: Image.network(story.imageUrl),
                        ),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
