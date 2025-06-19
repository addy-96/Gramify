import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gramify/features/auth/presentation/mobile/signup_page_mobile.dart';
import 'package:gramify/features/auth/presentation/web/signup_page_web.dart';

class SignupResPage extends StatelessWidget {
  const SignupResPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          return const SignupPageWeb();
        } else if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS ||
            constraints.maxWidth <= 700) {
          return const SignupPageMobile();
        }
        throw Exception('Unsupported platform');
      },
    );
  }
}
