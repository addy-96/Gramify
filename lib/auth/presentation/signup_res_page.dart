import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gramify/auth/presentation/signup_page.dart';

class SignupResPage extends StatelessWidget {
  const SignupResPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600 && !kIsWeb) {
          return SignupPageMobile();
        } else {
          return SignupPageWeb();
        }
      },
    );
  }
}
