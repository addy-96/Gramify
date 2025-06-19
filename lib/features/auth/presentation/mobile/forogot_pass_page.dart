import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/features/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/features/auth/presentation/widgets/input_box_mobile.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class ForogotPassResPage extends StatelessWidget {
  const ForogotPassResPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600 && !kIsWeb) {
          return const ForogotPassMobile();
        } else {
          return const ForogotPassWeb();
        }
      },
    );
  }
}

class ForogotPassMobile extends StatefulWidget {
  const ForogotPassMobile({super.key});

  @override
  State<ForogotPassMobile> createState() => _ForogotPassMobileState();
}

class _ForogotPassMobileState extends State<ForogotPassMobile> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
          child: Column(
            children: [
              Text(
                'Enter your email address.',
                style: txtStyle(22, Colors.white70),
              ),
              const Gap(10),
              InputBoxMobile(
                hintText: 'Email',
                textController: _emailController,
                isPasswordfield: false,
              ),
              const Gap(10),
              SizedBox(
                height: 50,
                child: CustomButton(
                  buttonRadius: 12,
                  isFilled: true,
                  buttonText: 'Send',
                  isFacebookButton: false,
                  onTapEvent: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForogotPassWeb extends StatelessWidget {
  const ForogotPassWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
