import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:ionicons/ionicons.dart';

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({super.key, required this.loggedUserId});
  final String loggedUserId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(100),
        Column(
          children: [
            SizedBox(
              height: 100,
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(width: 4, color: Colors.white),
                            ),
                            width: 95,
                          ),
                          const Positioned(
                            right: 0,
                            bottom: 8,
                            child: ShaderIcon(
                              iconWidget: Icon(Ionicons.add_circle, size: 35),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const ShaderNormal(
                      childWidget: VerticalDivider(
                        thickness: 2,
                        endIndent: 10,
                        indent: 10,
                        width: 20,
                      ),
                    ),
                    for (var i = 0; i <= 10; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [thmegrad1, thmegrad2],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(46),
                            ),
                            width: 85,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(46),
                              child: Image.asset(
                                'assets/images/test_picture.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const Gap(40),
            const Expanded(
              child: SizedBox(
                width: 400,
                child: SingleChildScrollView(child: Column(children: [])),
              ),
            ),
          ],
        ),
        const Gap(40),
      ],
    );
  }
}
