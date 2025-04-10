import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gramify/auth/presentation/login_page.dart';

class LoginResPage extends StatelessWidget {
  const LoginResPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600 && !kIsWeb) {
          return LoginPageMobile();
        } else {
          return LoginPageWeb();
        }
      },
    );
  }
}
