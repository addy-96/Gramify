import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 2, right: 2),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/test_picture.jpg',
                  height: MediaQuery.of(context).size.height / 2.2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black87,
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 2, color: Colors.black45),
                          ),
                          child: ShaderIcon(
                            iconWidget: Icon(Icons.person_outline),
                          ),
                        ),
                        Gap(10),
                        Text(
                          textAlign: TextAlign.center,
                          'aditya3401',
                          style: txtStyle(
                            22,
                            Colors.white70,
                          ).copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 0,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Ionicons.heart,
                              color: Colors.red[900],
                              opticalSize: 30,
                            ),
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Ionicons.share_social_outline),
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Ionicons.bookmark_outline),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Liked by so and souvnudnvhdn inuin udrnvidsnv iuadnovuydvn idhnvianvijavnijanvuoaoivajkv ihanvuinviaj vjianvuian.',
                style: txtStyle(15, whiteForText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
