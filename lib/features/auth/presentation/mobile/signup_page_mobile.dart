import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/features/auth/presentation/mobile/signup_details_page.dart';
import 'package:gramify/features/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

class SignupPageMobile extends StatefulWidget {
  const SignupPageMobile({super.key});

  @override
  State<SignupPageMobile> createState() => _SignupPageMobileState();
}

class _SignupPageMobileState extends State<SignupPageMobile> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_emailController.text.trim().isEmpty) {
      return csnack(context, 'Enter email to proceed');
    } else if (!_emailController.text.trim().contains('@') ||
        !_emailController.text.trim().contains('.')) {
      return csnack(context, 'Invalid Email!');
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => SignUpDetailsPageMobile(
              userEmail: _emailController.text.trim(),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final heeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: /* (heeight / 3).toInt() */ 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                child: Column(
                  children: [
                    Text(
                      'What\'s your email address?',
                      style: txtStyle(
                        25,
                        whiteForText,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Enter the email address at which you can be contacted. No one will see this on your profile.',
                      textAlign: TextAlign.center,
                      style: txtStyle(15, whiteForText),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: txtStyle(
                                18,
                                whiteForText,
                              ).copyWith(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.white60,
                                ),

                                borderRadius: BorderRadius.circular(14),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),

                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            style: txtStyle(18, whiteForText),
                          ),
                          const Gap(30),
                          SizedBox(
                            height: heeight / 15,
                            child: CustomButton(
                              buttonRadius: 15,
                              isFilled: true,
                              buttonText: 'Submit',
                              isFacebookButton: false,
                              onTapEvent: () {
                                _onSubmit();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context.replace('/login');
                    },
                    child: ShaderText(
                      textWidget: Text(
                        'Already have an account?',
                        style: txtStyleNoColor(
                          18,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
