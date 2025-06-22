import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
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
    final weeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: /* (heeight / 3).toInt() */ 3,
              child: Padding(
                padding: EdgeInsets.only(
                  top: heeight / 20,
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'What\'s your email address?',
                      style: txtStyle(
                        title26,
                        whiteForText,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Enter the email address at which you can be contacted. No one will see this on your profile.',
                      textAlign: TextAlign.center,
                      style: txtStyle(bodyText14, whiteForText),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: txtStyle(bodyText16, whiteForText),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.white60,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),

                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            style: txtStyle(bodyText16, whiteForText),
                          ),
                          const Gap(30),
                          SizedBox(
                            height: heeight / 15,
                            child: CustomButton(
                              buttonRadius: 50,
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
                          subTitle18,
                        ).copyWith(fontWeight: FontWeight.normal),
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
