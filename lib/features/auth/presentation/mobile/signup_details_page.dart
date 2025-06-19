import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/mobile/add_prfile_picture.dart';
import 'package:gramify/features/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

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

  validateInput() {
    if (_fullNameColtroller.text.trim().isEmpty) {
      return csnack(context, 'Enter FUll name to proceed.');
    } else if (_fullNameColtroller.text.length < 5 ||
        _fullNameColtroller.text.length > 25) {
      return csnack(context, 'Fullname should be between 5 to 25 charcters.');
    }

    if (_usernameController.text.trim().isEmpty) {
      return csnack(context, 'Enter username to proceed');
    } else if (_usernameController.text.trim().length < 8 ||
        _usernameController.text.trim().length > 19 ||
        _usernameController.text.contains(' ')) {
      return csnack(
        context,
        'Username should be between 8 to 19 charcters withou spaces',
      );
    }

    if (_passwordController.text.trim().isEmpty) {
      return csnack(context, 'Enter password to proceed');
    } else if (_passwordController.text.trim().length < 8 ||
        _passwordController.text.trim().length > 30) {
      return csnack(context, 'Password should be between 8 to 30 charcters');
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

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBar(
              foregroundColor: themeColor,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                    child: Column(
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
                          child: ShaderText(
                            textWidget: Text(
                              widget.userEmail,
                              style: txtStyleNoColor(
                                22,
                              ).copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const Gap(15),
                        Text(
                          'Enter your details',
                          style: txtStyle(
                            25,
                            whiteForText,
                          ).copyWith(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'No worries, this information can be changed later.',
                          textAlign: TextAlign.center,
                          style: txtStyle(15, whiteForText),
                        ),
                        const Gap(10),
                        _inputField('Full Name', _fullNameColtroller),
                        const Gap(15),
                        _inputField('Username', _usernameController),
                        const Gap(15),
                        _inputField('Password', _passwordController),
                        const Gap(20),
                        SizedBox(
                          height: heeight / 15,
                          child: CustomButton(
                            buttonRadius: 15,
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

  Widget _inputField(String labelText, TextEditingController textController) {
    return TextField(
      controller: textController,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: labelText,

        labelStyle: txtStyle(18, whiteForText),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.1, color: Colors.white60),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.white),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
