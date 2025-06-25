import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/features/add_post/presentation/mobile/select_post_picture.dart';
import 'package:gramify/main_presentaiton/app_bloc/wrapper_bloc/wrapper_bloc.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/explore/presentation/mobile/explore_page_mobile.dart';
import 'package:gramify/features/home/presentation/home_res_page.dart';
import 'package:gramify/features/profile/presentation/mobile/profile_page.dart';
import 'package:ionicons/ionicons.dart';

class WrapperRes extends StatelessWidget {
  const WrapperRes({super.key, required this.userID});
  final String userID;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          return WrapperWeb(userId: userID);
        } else if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS ||
            constraints.maxWidth <= 700) {
          return WrapperMobile(userId: userID);
        }
        throw Exception('Unsupported platform');
      },
    );
  }
}

//

class WrapperMobile extends StatefulWidget {
  const WrapperMobile({super.key, required this.userId});
  final String userId;

  @override
  State<WrapperMobile> createState() => _WrapperMobileState();
}

class _WrapperMobileState extends State<WrapperMobile> {
  @override
  void initState() {
    super.initState();
    context.read<WrapperBloc>().add(PageChageRequestedMobile(selectedIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<WrapperBloc, WrapperState>(
        builder: (context, state) {
          if (state is HomePageSelectedMobile) {
            return HomePageRes(loggedUserID: widget.userId);
          }
          if (state is UploadPageSelectedMobile) {
            return const SelectPostPicture();
          }
          if (state is ExplorePageSelectedMobile) {
            return const ExplorePageMobile();
          }
          if (state is ProfilePageSlectedMobile) {
            return const ProfilePageMobile(userId: null);
          }
          if (state is WrapperInitialState) {
            return HomePageRes(loggedUserID: widget.userId);
          }
          return HomePageRes(loggedUserID: widget.userId);
        },
      ),

      bottomNavigationBar: const CustomNavBarMobile(
        borderRadius: 14,
        horizontalPadding: 60,
        verticalPadding: 20,
        navitemsLength: 4,
        iconColor: Colors.black87,
        iconSize: 25,
        initialIndex: 0,
      ),
    );
  }
}

class CustomNavBarMobile extends StatefulWidget {
  const CustomNavBarMobile({
    super.key,
    required this.borderRadius,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.navitemsLength,
    required this.iconColor,
    required this.iconSize,
    required this.initialIndex,
  }) : assert(
         navitemsLength >= 2 && navitemsLength <= 4,
         'item.count >= 2 & item.count =< 4',
       );
  final int navitemsLength;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final Color iconColor;
  final double iconSize;
  final int initialIndex;

  @override
  State<CustomNavBarMobile> createState() => _CustomNavBarMobileState();
}

class _CustomNavBarMobileState extends State<CustomNavBarMobile> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.verticalPadding,
          bottom: widget.verticalPadding,
          left: widget.horizontalPadding,
          right: widget.horizontalPadding,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 13,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4E9F3D), Color(0xFF3AAFA9)],
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
              top: 12,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < widget.navitemsLength; i++)
                  InkWell(
                    onTap: () {
                      selectedIndex = i;
                      context.read<WrapperBloc>().add(
                        PageChageRequestedMobile(selectedIndex: i),
                      );
                      setState(() {});
                    },

                    child: Icon(
                      i == 0
                          ? (i == selectedIndex
                              ? Ionicons.home_sharp
                              : Ionicons.home_outline)
                          : i == 1
                          ? (i == selectedIndex
                              ? Ionicons.add_circle
                              : Ionicons.add_circle_outline)
                          : i == 2
                          ? (i == selectedIndex
                              ? Ionicons.compass
                              : Ionicons.compass_outline)
                          : i == 3
                          ? (i == selectedIndex
                              ? Ionicons.person_sharp
                              : Ionicons.person_outline)
                          : null,
                      color: widget.iconColor,
                      size: widget.iconSize,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
class WrapperWeb extends StatefulWidget {
  const WrapperWeb({super.key, required this.userId});
  final String userId;
  @override
  State<WrapperWeb> createState() => _WrapperWebState();
}

class _WrapperWebState extends State<WrapperWeb> {
  @override
  void initState() {
    super.initState();
    context.read<WrapperBloc>().add(PageChageRequestedWeb(selectedIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    final heeight = MediaQuery.of(context).size.height;
    final wiidth = MediaQuery.of(context).size.width;

    log(heeight.toString());
    log(wiidth.toString());
    if (MediaQuery.of(context).size.width < 800) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.square(50),
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [thmegrad1, thmegrad2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Row(
                children: [Icon(Ionicons.menu, color: Colors.black54)],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Row(
          children: [
            Container(
              height: heeight,
              width: wiidth > 1120 ? 300 : wiidth / 4,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 0.5,
                    color: whiteForText.withOpacity(0.2),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          'assets/images/test_picture.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                  const TabsForWeb(
                    icondata: Ionicons.home_outline,
                    title: 'Home',
                    index: 0,
                  ),
                  const TabsForWeb(
                    icondata: Ionicons.heart_outline,
                    title: 'Notification',
                    index: 1,
                  ),
                  const TabsForWeb(
                    icondata: Ionicons.compass_outline,
                    title: 'Explore',
                    index: 2,
                  ),
                  const TabsForWeb(
                    icondata: Ionicons.add_circle_outline,
                    title: 'Create',
                    index: 3,
                  ),
                ],
              ),
            ),
            BlocBuilder<WrapperBloc, WrapperState>(
              builder: (context, state) {
                if (state is HomePageSelectedWeb) {
                  return HomePageRes(loggedUserID: widget.userId);
                }
                if (state is NotificationPageSelectedWeb) {
                  return const Center(child: Text('Notification'));
                }
                if (state is ExplorePageSelectedWeb) {
                  return const Center(child: Text('Explore'));
                }
                if (state is UploadPageSelectedWeb) {
                  return const Center(child: Text('Upload'));
                }
                return const Center(child: Text('Home'));
              },
            ),
          ],
        ),
      );
    }
  }
}

class TabsForWeb extends StatelessWidget {
  const TabsForWeb({
    super.key,
    required this.icondata,
    required this.title,
    required this.index,
  });

  final IconData icondata;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<WrapperBloc>().add(
          PageChageRequestedWeb(selectedIndex: index),
        );
      },
      leading: BlocBuilder<WrapperBloc, WrapperState>(
        builder: (context, state) {
          if ((state is HomePageSelectedWeb && index == 0) ||
              (state is NotificationPageSelectedWeb && index == 1) ||
              (state is ExplorePageSelectedWeb && index == 2) ||
              (state is UploadPageSelectedWeb && index == 3)) {
            return ShaderIcon(
              iconWidget: Icon(icondata, size: 32, color: whiteForText),
            );
          }
          return Icon(icondata, size: 24, color: whiteForText);
        },
      ),
      title: BlocBuilder<WrapperBloc, WrapperState>(
        builder: (context, state) {
          if ((state is HomePageSelectedWeb && index == 0) ||
              (state is NotificationPageSelectedWeb && index == 1) ||
              (state is ExplorePageSelectedWeb && index == 2) ||
              (state is UploadPageSelectedWeb && index == 3)) {
            return ShaderText(
              textWidget: Text(
                title,
                style: txtStyleNoColor(title32),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }
          return Text(
            title,
            style: txtStyle(title24, whiteForText),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
    );
  }
}
