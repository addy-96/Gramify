import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.amber),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.pink),
              ),
            ),
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
    return const Placeholder();
  }
}
