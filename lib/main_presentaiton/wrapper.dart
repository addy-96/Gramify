import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/features/add_post/presentation/mobile/select_post_picture.dart';
import 'package:gramify/main_presentaiton/app_bloc/app_bloc.dart';
import 'package:gramify/main_presentaiton/app_bloc/app_event.dart';
import 'package:gramify/main_presentaiton/wrapper_bloc/wrapper_bloc.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/explore/presentation/mobile/explore_page_mobile.dart';
import 'package:gramify/features/home/presentation/home_res_page.dart';
import 'package:gramify/features/profile/presentation/mobile/profile_page.dart';
import 'package:ionicons/ionicons.dart';

class WrapperRes extends StatefulWidget {
  const WrapperRes({super.key, required this.userID});
  final String userID;

  @override
  State<WrapperRes> createState() => _WrapperResState();
}

class _WrapperResState extends State<WrapperRes> {
  Timer? _userOnlineTimer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppBloc>().add(SetUserOnlineEvent());
    });

    _userOnlineTimer = Timer.periodic(const Duration(minutes: 2), (_) {
      log('set user online');
      context.read<AppBloc>().add(SetUserOnlineEvent());
    });
  }

  @override
  void dispose() {
    _userOnlineTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          return WrapperWeb(userId: widget.userID);
        } else if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS ||
            constraints.maxWidth <= 700) {
          return WrapperMobile(userId: widget.userID);
        }
        throw Exception('Unsupported platform');
      },
    );
  }
}
/*









*/

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
        horizontalPadding: 20,
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
                      context.read<WrapperBloc>().add(
                        PageChageRequestedMobile(selectedIndex: i),
                      );
                    },

                    child: BlocBuilder<WrapperBloc, WrapperState>(
                      builder: (context, state) {
                        if (i == 0) {
                          if (state is HomePageSelectedMobile) {
                            return Icon(
                              Ionicons.home_sharp,
                              size: widget.iconSize,
                              color: widget.iconColor,
                            );
                          }
                          return Icon(
                            Ionicons.home_outline,
                            size: widget.iconSize,
                            color: widget.iconColor,
                          );
                        } else if (i == 1) {
                          if (state is UploadPageSelectedMobile) {
                            return Icon(
                              Ionicons.add_circle_sharp,
                              size: widget.iconSize,
                              color: widget.iconColor,
                            );
                          }
                          return Icon(
                            Ionicons.add_circle_outline,
                            size: widget.iconSize,
                            color: widget.iconColor,
                          );
                        } else if (i == 2) {
                          if (state is ExplorePageSelectedMobile) {
                            return Icon(
                              Ionicons.compass_sharp,
                              size: widget.iconSize,
                              color: widget.iconColor,
                            );
                          }
                          return Icon(
                            Ionicons.compass_outline,
                            size: widget.iconSize,
                            color: widget.iconColor,
                          );
                        } else {
                          if (state is ProfilePageSlectedMobile) {
                            return Icon(
                              Ionicons.person_sharp,
                              size: widget.iconSize,
                              color: widget.iconColor,
                            );
                          }
                          return Icon(
                            Ionicons.person_outline,
                            size: widget.iconSize,
                            color: widget.iconColor,
                          );
                        }
                      },
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

/*









*/
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    log(' screen width : $screenWidth');
    if (MediaQuery.of(context).size.width < 900) {
      return Scaffold(
        body: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(width: 3, color: Colors.white10),
                ),
              ),
              width: 80,
              height: double.infinity,

              child: Column(
                children: [
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconTabsForWeb(
                          icondata: Ionicons.home_outline,
                          index: 0,
                        ),
                        IconTabsForWeb(
                          icondata: Ionicons.heart_outline,
                          index: 1,
                        ),
                        IconTabsForWeb(
                          icondata: Ionicons.compass_outline,
                          index: 2,
                        ),
                        IconTabsForWeb(
                          icondata: Ionicons.create_outline,
                          index: 3,
                        ),
                        IconTabsForWeb(
                          icondata: Ionicons.send_outline,
                          index: 4,
                        ),
                        IconTabsForWeb(
                          icondata: Ionicons.search_outline,
                          index: 5,
                        ),
                        IconTabsForWeb(
                          icondata: Ionicons.person_outline,
                          index: 6,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Ionicons.log_out_outline,
                          size: title24,
                        ),
                      ),
                    ],
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
                if (state is MessagePageSelectedWeb) {
                  return const Center(child: Text('message'));
                }
                if (state is UploadPageSelectedWeb) {
                  return const Center(child: Text('Search'));
                }
                if (state is UploadPageSelectedWeb) {
                  return const Center(child: Text('Profile'));
                }
                return const Center(child: Text('Home'));
              },
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Row(
          children: [
            Container(
              height: screenHeight,
              width: screenWidth > 1120 ? 300 : screenWidth / 4,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 0.5,
                    color: whiteForText.withOpacity(0.2),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
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

                        const TabsForWeb(
                          icondata: Ionicons.send_outline,
                          title: 'Message',
                          index: 4,
                        ),

                        const TabsForWeb(
                          icondata: Ionicons.search_outline,
                          title: 'Search',
                          index: 5,
                        ),

                        const TabsForWeb(
                          icondata: Ionicons.person_outline,
                          title: 'Profile',
                          index: 6,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        splashColor: Colors.grey.shade900,
                        onTap: () {},
                        title: Text(
                          'Log out',
                          style: txtStyle(
                            subTitle22,
                            Colors.white,
                          ).copyWith(fontWeight: FontWeight.w500),
                        ),
                        leading: const Icon(
                          Ionicons.log_out_outline,
                          size: title26,
                        ),
                      ),
                    ],
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
                if (state is MessagePageSelectedWeb) {
                  return const Center(child: Text('message'));
                }
                if (state is SearchPageSelectedWeb) {
                  return const Center(child: Text('Search'));
                }
                if (state is ProfilePageSelectedWeb) {
                  return const Center(child: Text('Profile'));
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
              (state is UploadPageSelectedWeb && index == 3) ||
              (state is MessagePageSelectedWeb && index == 4) ||
              (state is SearchPageSelectedWeb && index == 5) ||
              (state is ProfilePageSelectedWeb && index == 6)) {
            return ShaderIcon(
              iconWidget: Icon(icondata, size: title32, color: whiteForText),
            );
          }
          return Icon(icondata, size: title24, color: whiteForText);
        },
      ),
      title: BlocBuilder<WrapperBloc, WrapperState>(
        builder: (context, state) {
          if ((state is HomePageSelectedWeb && index == 0) ||
              (state is NotificationPageSelectedWeb && index == 1) ||
              (state is ExplorePageSelectedWeb && index == 2) ||
              (state is UploadPageSelectedWeb && index == 3) ||
              (state is MessagePageSelectedWeb && index == 4) ||
              (state is SearchPageSelectedWeb && index == 5) ||
              (state is ProfilePageSelectedWeb && index == 6)) {
            return ShaderText(
              textWidget: Text(
                title,
                style: txtStyleNoColor(title30),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }
          return Text(
            title,
            style: txtStyle(subTitle22, whiteForText),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
    );
  }
}

class IconTabsForWeb extends StatelessWidget {
  const IconTabsForWeb({
    super.key,
    required this.icondata,
    required this.index,
  });

  final IconData icondata;
  final int index;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<WrapperBloc>().add(
          PageChageRequestedWeb(selectedIndex: index),
        );
      },
      icon: BlocBuilder<WrapperBloc, WrapperState>(
        builder: (context, state) {
          if ((state is HomePageSelectedWeb && index == 0) ||
              (state is NotificationPageSelectedWeb && index == 1) ||
              (state is ExplorePageSelectedWeb && index == 2) ||
              (state is UploadPageSelectedWeb && index == 3) ||
              (state is MessagePageSelectedWeb && index == 4) ||
              (state is SearchPageSelectedWeb && index == 5) ||
              (state is ProfilePageSelectedWeb && index == 6)) {
            return ShaderIcon(
              iconWidget: Icon(icondata, size: 35, color: whiteForText),
            );
          }
          return Icon(icondata, size: 20, color: whiteForText);
        },
      ),
    );
  }
}
