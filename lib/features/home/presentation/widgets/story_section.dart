import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/features/add_post/presentation/mobile/make_story_page.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

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
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(14),
                      child: Image.network('https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg', fit: BoxFit.cover, height: double.infinity),
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
              for (var i = 0; i <= 4; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    height: screenHeight / 14,
                    width: screenWidth / 6,
                    decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.white24), borderRadius: BorderRadius.circular(14)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
