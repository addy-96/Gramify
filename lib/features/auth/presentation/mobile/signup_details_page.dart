import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/mobile/add_prfile_picture.dart';
import 'package:gramify/features/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';

class SignUpDetailsPageMobile extends StatefulWidget {
  const SignUpDetailsPageMobile({super.key, required this.userEmail});

  final String userEmail;

  @override
  State<SignUpDetailsPageMobile> createState() =>
      _SignUpDetailsPageMobileState();
}

class _SignUpDetailsPageMobileState extends State<SignUpDetailsPageMobile> {
  final TextEditingController _fullNameColtroller = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool validInput = false;
  bool validUsername = false;

  validateInput() {
    if (_fullNameColtroller.text.trim().isEmpty) {
      return csnack(context, 'Enter FUll name to proceed.');
    } else if (_fullNameColtroller.text.length < 5 ||
        _fullNameColtroller.text.length > 25) {
      return csnack(context, 'Fullname should be between 5 to 25 charcters.');
    }

    if (_usernameController.text.trim().isEmpty) {
      return csnack(context, 'Enter username to proceed');
    } else if (_usernameController.text.trim().length > 19 ||
        _usernameController.text.trim().contains(' ')) {
      return csnack(
        context,
        'Username should be between 8 to 19 charcters without spaces!',
      );
    }
    if (!validUsername) {
      return;
    }

    if (_passwordController.text.trim().isEmpty) {
      return csnack(context, 'Enter password to proceed');
    } else if (_passwordController.text.trim().length < 8 ||
        _passwordController.text.trim().length > 30) {
      return csnack(context, 'Password should be between 8 to 30 charcters!');
    }

    validInput = true;
  }

  _onCreateAccount() {
    validInput = false;
    validateInput();
    if (validInput) {
      context.read<AuthBloc>().add(
        SignUpRequested(
          email: widget.userEmail,
          password: _passwordController.text,
          fullname: _fullNameColtroller.text,
          username: _usernameController.text,
          profileIMageUrl: null,
        ),
      );
    } else {
      log('Invalid Input');
    }
  }

  @override
  Widget build(BuildContext context) {
    final heeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => AddProfilePage(
                    username: _usernameController.text,
                    userId: state.userID,
                  ),
            ),
          );
        }

        if (state is AuthFailure) {
          csnack(context, state.errorMessage);
        }
      },

      builder: (context, state) {
        if (state is AuthloadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final scrrenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBar(
              backgroundColor: Colors.transparent,

              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const ShaderIcon(iconWidget: Icon(Ionicons.chevron_back)),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: scrrenHeight / 12,
                      left: screenWidth / 20,
                      right: screenWidth / 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Dialog(child: Text('Hello'));
                              },
                            );
                          },
                          child: Center(
                            child: ShaderText(
                              textWidget: Text(
                                widget.userEmail,
                                style: txtStyleNoColor(
                                  title24,
                                ).copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        const Gap(15),
                        Text(
                          'Enter your details',
                          style: txtStyle(
                            title28,
                            whiteForText,
                          ).copyWith(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'No worries, this information can be changed later.',
                          textAlign: TextAlign.center,
                          style: txtStyle(bodyText16, whiteForText),
                        ),
                        const Gap(10),
                        _inputField(
                          'Full Name',
                          _fullNameColtroller,
                          isPassword: false,
                          isUsername: false,
                        ),
                        const Gap(15),
                        _inputField(
                          'Username',
                          _usernameController,
                          isPassword: false,
                          isUsername: true,
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is CheckedUsernameState) {
                              if (_usernameController.text.trim().isEmpty) {
                                validUsername = false;
                                return const SizedBox.shrink();
                              } else if (_usernameController.text
                                      .trim()
                                      .isNotEmpty &&
                                  _usernameController.text.trim().length <
                                      usernameMINLenght) {
                                validUsername = false;
                                return Text(
                                  'Username should be atleast $usernameMINLenght charcters long',
                                  textAlign: TextAlign.justify,
                                  style: txtStyle(
                                    bodyText14,
                                    Colors.red,
                                  ).copyWith(fontWeight: FontWeight.normal),
                                );
                              } else if (state.isAvailable == true) {
                                validUsername = true;
                                return ShaderText(
                                  textWidget: Text(
                                    textAlign: TextAlign.start,
                                    'Username available!',
                                    style: txtStyleNoColor(
                                      bodyText14,
                                    ).copyWith(fontWeight: FontWeight.normal),
                                  ),
                                );
                              } else if (state.isAvailable == false) {
                                validUsername = false;
                                return Text(
                                  'Sorry, Username taken, choose another!',
                                  textAlign: TextAlign.justify,
                                  style: txtStyle(
                                    bodyText14,
                                    Colors.red,
                                  ).copyWith(fontWeight: FontWeight.normal),
                                );
                              }
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        const Gap(15),
                        _inputField(
                          'Password',
                          _passwordController,
                          isPassword: true,
                          isUsername: false,
                        ),
                        const Gap(20),
                        SizedBox(
                          height: heeight / 15,
                          child: CustomButton(
                            buttonRadius: 50,
                            isFilled: true,
                            buttonText: 'Create account',
                            isFacebookButton: false,
                            onTapEvent: () {
                              _onCreateAccount();
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
        );
      },
    );
  }

  Widget _inputField(
    String labelText,
    TextEditingController textController, {
    required bool isPassword,
    required bool isUsername,
  }) {
    return TextField(
      onChanged:
          !isUsername
              ? null
              : (value) {
                context.read<AuthBloc>().add(
                  CheckUsernameRequested(enteredString: value.trim()),
                );
              },
      obscureText: isPassword,
      keyboardType:
          isPassword ? TextInputType.visiblePassword : TextInputType.text,
      controller: textController,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: txtStyle(bodyText16, whiteForText),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.1, color: Colors.white60),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.white),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
