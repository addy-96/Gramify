import 'package:flutter/material.dart';

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
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                height: screenHeight / 14,
                width: screenWidth / 6,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white24),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              for (var i = 0; i <= 4; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 0,
                  ),
                  child: Container(
                    height: screenHeight / 14,
                    width: screenWidth / 6,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white24),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
