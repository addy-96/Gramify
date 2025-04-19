import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gramify/auth/presentation/signup_page.dart';

class SignupResPage extends StatelessWidget {
  const SignupResPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          return SignupPageWeb();
        } else if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS ||
            constraints.maxWidth <= 700) {
          return SignupPageMobile();
        }
        throw Exception('Unsupported platform');
      },
    );
  }
}
