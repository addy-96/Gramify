import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/home/presentation/widgets/post.dart';
import 'package:ionicons/ionicons.dart';

class HomePageRes extends StatelessWidget {
  const HomePageRes({super.key, required this.loggedUserID});
  final String loggedUserID;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          return HomePageWeb(loggedUserId: loggedUserID);
        } else if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS ||
            constraints.maxWidth <= 700) {
          return HomePageMobile(loggedUserId: loggedUserID);
        }
        throw Exception('Unsupported platform');
      },
    );
  }
}

class HomePageMobile extends StatelessWidget {
  const HomePageMobile({super.key, required this.loggedUserId});
  final String loggedUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actionsPadding: EdgeInsets.all(4),
        forceMaterialTransparency: true,
        title: SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
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
            onPressed: () {},
            icon: ShaderIcon(
              iconWidget: Icon(Ionicons.heart_outline, size: 30),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: ShaderIcon(iconWidget: Icon(Ionicons.send_outline, size: 30)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(4),
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
                          Positioned(
                            right: 0,
                            bottom: 8,
                            child: ShaderIcon(
                              iconWidget: Icon(Ionicons.add_circle, size: 35),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ShaderNormal(
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
                            gradient: LinearGradient(
                              colors: [thmegrad1, thmegrad2],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.all(4),
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
            Gap(5),
            // Posts Section
            Post(),
            Post(),
            Post(),
          ],
        ),
      ),
    );
  }
}

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({super.key, required this.loggedUserId});
  final String loggedUserId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(100),
        Column(
          children: [
            SizedBox(
              height: 100,
              width: 500,
              child: Padding(
                padding: EdgeInsets.all(4),
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
                          Positioned(
                            right: 0,
                            bottom: 8,
                            child: ShaderIcon(
                              iconWidget: Icon(Ionicons.add_circle, size: 35),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ShaderNormal(
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
                            gradient: LinearGradient(
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

            Gap(40),
            Expanded(
              child: SizedBox(
                width: 400,
                child: SingleChildScrollView(
                  child: Column(children: [Post(), Post(), Post(), Post()]),
                ),
              ),
            ),
          ],
        ),
        Gap(40),
      ],
    );
  }
}
