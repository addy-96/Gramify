import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/app_bloc/wrapper_bloc/wrapper_bloc.dart';
import 'package:gramify/app_bloc/wrapper_bloc/wrapper_event.dart';
import 'package:gramify/app_bloc/wrapper_bloc/wrapper_state.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/home/presentation/home_page.dart';
import 'package:gramify/test.dart';

import 'package:ionicons/ionicons.dart';

class WrapperRes extends StatelessWidget {
  const WrapperRes({super.key, required this.userID});
  final String userID;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (Platform.isAndroid) {
          return WrapperMobile(userId: userID);
        } else {
          return WrapperWeb();
        }
      },
    );
  }
}

class WrapperMobile extends StatefulWidget {
  const WrapperMobile({super.key, required this.userId});
  final String userId;

  @override
  State<WrapperMobile> createState() => _WrapperMobileState();
}

class _WrapperMobileState extends State<WrapperMobile> {
  var currentNavbarIndex = 0;

  @override
  Widget build(BuildContext context) {
    log('wrapper called');
    return Scaffold(
      body: BlocBuilder<WrapperBloc, WrapperState>(
        builder: (context, state) {
          if (state is HomePageSelected) {
            return HomePageRes(loggedUserID: widget.userId);
          }
          if (state is ExplorePageSelected) {
            return Test(receivedText: 'Explore');
          }
          if (state is NotifiactionPageSelected) {
            return Test(receivedText: 'Notification');
          }
          if (state is ProfilePageSlected) {
            return Test(receivedText: 'Profile');
          }
          return Test(receivedText: 'HomePage');
        },
      ),
      bottomNavigationBar: CustomNavBarMobile(
        borderRadius: 22,
        horizontalPadding: 40,
        verticalPadding: 30,
        navitemsLength: 4,
        iconColor: Colors.black,
        iconSize: 30,
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
    return Padding(
      padding: EdgeInsets.only(
        top: widget.verticalPadding,
        bottom: widget.verticalPadding,
        left: widget.horizontalPadding,
        right: widget.horizontalPadding,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 11,
        width: double.infinity,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < widget.navitemsLength; i++)
                InkWell(
                  onTap: () {
                    selectedIndex = i;
                    context.read<WrapperBloc>().add(
                      PageChageRequested(selectedIndex: i),
                    );
                    setState(() {});
                  },
                  child: Container(
                    child: Icon(
                      i == 0
                          ? (i == selectedIndex
                              ? Ionicons.home_sharp
                              : Ionicons.home_outline)
                          : i == 1
                          ? (i == selectedIndex
                              ? Ionicons.compass_sharp
                              : Ionicons.compass_outline)
                          : i == 2
                          ? (i == selectedIndex
                              ? Ionicons.heart_sharp
                              : Ionicons.heart_outline)
                          : i == 3
                          ? (i == selectedIndex
                              ? Ionicons.person_sharp
                              : Ionicons.person_outline)
                          : null,
                      color: widget.iconColor,
                      size: widget.iconSize,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class WrapperWeb extends StatelessWidget {
  const WrapperWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


/*           borderRadius: 18,
          initialIndex: currentNavbarIndex,
          onPageChanged: (value) {
            setState(() {
              currentNavbarIndex = value;
            });
          },
          selectedIconColor: Colors.black,
          unselectedIconColor: Colors.black,
          hapticFeedback: true,
          horizontalPadding: 30,
          items: [
            FloatingNavBarItem(
              title: 'Home',
              page: HomePageMobile(loggedUserId: widget.userId),
              useImageIcon: false,
              iconData:
                  currentNavbarIndex == 0
                      ? iconListSelected[0]
                      : iconListUnselected[0],
            ),
            FloatingNavBarItem(
              title: 'Explore',
              page: Test(receivedText: 'Explore'),
              useImageIcon: false,

              iconData:
                  currentNavbarIndex == 1
                      ? iconListSelected[1]
                      : iconListUnselected[1],
            ),
            FloatingNavBarItem(
              title: 'Notification',
              page: Test(receivedText: 'Notifiaction'),
              useImageIcon: false,
              iconData:
                  currentNavbarIndex == 2
                      ? iconListSelected[2]
                      : iconListUnselected[2],
            ),
            FloatingNavBarItem(
              title: 'Profile',
              page: Test(receivedText: 'Profile'),
              useImageIcon: false,
              iconData:
                  currentNavbarIndex == 3
                      ? iconListSelected[3]
                      : iconListUnselected[3],
            ),
          ], */