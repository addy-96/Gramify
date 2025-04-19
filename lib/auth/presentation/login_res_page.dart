import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gramify/auth/presentation/login_page.dart';

class LoginResPage extends StatelessWidget {
  const LoginResPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          return LoginPageWeb();
        } else if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS ||
            constraints.maxWidth <= 700) {
          return LoginPageMobile();
        }

        throw Exception('Unsupported platform');
      },
    );
  }
}
