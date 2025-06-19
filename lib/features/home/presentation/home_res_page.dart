import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gramify/features/home/presentation/mobile/home_page_mobile.dart';
import 'package:gramify/features/home/presentation/web/home_page_web.dart';

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
