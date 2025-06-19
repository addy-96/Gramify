import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gramify/features/auth/presentation/mobile/login_page_mobile.dart';
import 'package:gramify/features/auth/presentation/web/login_page_web.dart';

class LoginResPage extends StatelessWidget {
  const LoginResPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          return const LoginPageWeb();
        } else if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS ||
            constraints.maxWidth <= 700) {
          return const LoginPageMobile();
        }

        throw Exception('Unsupported platform');
      },
    );
  }
}
