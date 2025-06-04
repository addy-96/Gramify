import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/auth/presentation/widgets/custom_button.dart';
import 'package:gramify/auth/presentation/widgets/signUp_input_box_web.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sup;

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
      return csnack(context, 'Enter email to proceed', null);
    } else if (!_emailController.text.trim().contains('@') ||
        !_emailController.text.trim().contains('.')) {
      return csnack(context, 'Invalid Email!', null);
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
                    Gap(10),
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
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.white60,
                                ),

                                borderRadius: BorderRadius.circular(14),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),

                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            style: txtStyle(18, whiteForText),
                          ),
                          Gap(30),
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
      return csnack(context, 'Enter FUll name to proceed.', themeColor);
    } else if (_fullNameColtroller.text.length < 5 ||
        _fullNameColtroller.text.length > 25) {
      return csnack(
        context,
        'Fullname should be between 5 to 25 charcters.',
        themeColor,
      );
    }

    if (_usernameController.text.trim().isEmpty) {
      return csnack(context, 'Enter username to proceed', themeColor);
    } else if (_usernameController.text.trim().length < 8 ||
        _usernameController.text.trim().length > 19 ||
        _usernameController.text.contains(' ')) {
      return csnack(
        context,
        'Username should be between 8 to 19 charcters withou spaces',
        themeColor,
      );
    }

    if (_passwordController.text.trim().isEmpty) {
      return csnack(context, 'Enter password to proceed', themeColor);
    } else if (_passwordController.text.trim().length < 8 ||
        _passwordController.text.trim().length > 30) {
      return csnack(
        context,
        'Password should be between 8 to 30 charcters',
        themeColor,
      );
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
          csnack(context, state.errorMessage, Colors.red);
        }
      },

      builder: (context, state) {
        if (state is AuthloadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
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
                                return Dialog(child: Text('Hello'));
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
                        Gap(15),
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
                        Gap(10),
                        _inputField('Full Name', _fullNameColtroller),
                        Gap(15),
                        _inputField('Username', _usernameController),
                        Gap(15),
                        _inputField('Password', _passwordController),
                        Gap(20),
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
          borderSide: BorderSide(width: 0.1, color: Colors.white60),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.white),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({
    super.key,
    required this.username,
    required this.userId,
  });

  final String username;
  final String userId;

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  File? selectedImage;

  _onSelectProfileImage() {
    context.read<AuthBloc>().add(ProfileImageSelectionRequested());
  }

  _onSave() {
    if (selectedImage == null) {
      csnack(context, 'No Profile Selected, continue with "Skip"', null);
      return;
    }
    context.read<AuthBloc>().add(
      UploadProfilePictureRequested(
        selectedProfileImage: selectedImage!,
        username: widget.username,
      ),
    );
  }

  _onSkip() {
    context.go('/wrapper/${widget.userId}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ProfileImageUploadFialure) {
          csnack(context, '${state.errorMessage} (try again letter)', null);
        }

        if (state is ProfileImageUploadSuccess) {
          context.go('/wrapper/${widget.userId}');
        }
      },
      builder: (context, state) {
        if (state is AuthloadingState) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  ShaderText(
                    textWidget: Text(
                      'Welcome ${widget.username}!',
                      style: txtStyleNoColor(25),
                    ),
                  ),
                  ShaderText(
                    textWidget: Text(
                      'Add Profile Picture',
                      style: txtStyleNoColor(22),
                    ),
                  ),
                  ShaderText(
                    textWidget: Text(
                      '(Click on the Circle below to add or replace profile picture)',
                      style: txtStyleNoColor(12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: LinearGradient(
                              colors: [thmegrad1, thmegrad2],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height / 8,
                              ),
                              onTap: () {
                                _onSelectProfileImage();
                              },
                              child: BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  if (state is ProfileImageSelectedState) {
                                    selectedImage = state.selectedImage;
                                    return CircleAvatar(
                                      backgroundColor:
                                          Theme.of(
                                            context,
                                          ).scaffoldBackgroundColor,
                                      radius:
                                          MediaQuery.of(context).size.height /
                                          8,
                                      backgroundImage:
                                          state.selectedImage != null
                                              ? FileImage(state.selectedImage!)
                                              : null,
                                      child:
                                          state.selectedImage == null
                                              ? Center(
                                                child: ShaderIcon(
                                                  iconWidget: Icon(
                                                    Ionicons.person_add_sharp,
                                                    size:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.height /
                                                        10,
                                                  ),
                                                ),
                                              )
                                              : null,
                                    );
                                  }
                                  return CircleAvatar(
                                    backgroundColor:
                                        Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor,
                                    radius:
                                        MediaQuery.of(context).size.height / 8,
                                    child: Center(
                                      child: ShaderIcon(
                                        iconWidget: Icon(
                                          Ionicons.person_add_sharp,
                                          size:
                                              MediaQuery.of(
                                                context,
                                              ).size.height /
                                              10,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              _onSave();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 14,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [thmegrad1, thmegrad2],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Save',
                                  style: txtStyle(22, Colors.black87),
                                ),
                              ),
                            ),
                          ),
                          Gap(10),
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              _onSkip();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 14,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [thmegrad1, thmegrad2],
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.5),
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color:
                                        Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor,
                                  ),
                                  child: Center(
                                    child: ShaderText(
                                      textWidget: Text(
                                        'Skip',
                                        style: txtStyleNoColor(22),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
/*

*/
//
// web signup page

class SignupPageWeb extends StatefulWidget {
  const SignupPageWeb({super.key});

  @override
  State<SignupPageWeb> createState() => _SignupPageWebState();
}

class _SignupPageWebState extends State<SignupPageWeb> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool validInput = false;

  validateInput() {
    if (_emailController.text.trim().isEmpty) {
      return csnack(context, 'Enter Email to proceed.', themeColor);
    } else if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.') ||
        _emailController.text.trim().contains(' ')) {
      return csnack(context, 'Invalid email', themeColor);
    }

    if (_fullNameController.text.trim().isEmpty) {
      return csnack(context, 'Enter FUll name to proceed.', themeColor);
    } else if (_fullNameController.text.length < 5 ||
        _fullNameController.text.length > 25) {
      return csnack(
        context,
        'Fullname should be between 5 to 25 charcters.',
        themeColor,
      );
    }

    if (_usernameController.text.trim().isEmpty) {
      return csnack(context, 'Enter username to proceed', themeColor);
    } else if (_usernameController.text.trim().length < 8 ||
        _usernameController.text.trim().length > 19 ||
        _usernameController.text.contains(' ')) {
      return csnack(
        context,
        'Username should be between 8 to 19 charcters withou spaces',
        themeColor,
      );
    }

    if (_passwordController.text.trim().isEmpty) {
      return csnack(context, 'Enter password to proceed', themeColor);
    } else if (_passwordController.text.trim().length < 8 ||
        _passwordController.text.trim().length > 30) {
      return csnack(
        context,
        'Password should be between 8 to 30 charcters',
        themeColor,
      );
    }

    validInput = true;
  }

  void _onSignup() async {
    validInput = false;
    validateInput();
    if (validInput) {
      /*      context.read<AuthBloc>().add(
        SignUpRequested( // add profile image url section
          email: _emailController.text,
          password: _passwordController.text,
          fullname: _fullNameController.text,
          username: _usernameController.text,
          
        ),
      ); */
    } else {
      log('Invalid Input');
    }
  }

  @override
  Widget build(BuildContext context) {
    final heiight = MediaQuery.of(context).size.height;
    final wiidth = MediaQuery.of(context).size.width;
    /*    log('height : $heiight');
    log('width : $wiidth');*/
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          return csnack(context, state.errorMessage, Colors.red);
        }

        if (state is AuthSignUpSuccess) {
          context.go('/wrapper/${state.userID}');
        }
      },
      builder: (context, state) {
        if (state is AuthFailure) {
          _emailController.clear();
          _fullNameController.clear();
          _usernameController.clear();
          _passwordController.clear();
        }

        if (state is AuthloadingState) {
          return formWithLoadingScreen(heiight, wiidth);
        }
        return formSection(heiight, wiidth);
      },
    );
  }

  //gneral form // default
  Widget formSection(double heiight, double wiidth) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            children: [
              Gap(heiight / 40),
              Container(
                height: 700,
                width: getWiidth(wiidth),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white60),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 40, right: 40),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        ShaderIamge(
                          imageWidget: Image.asset(
                            'assets/images/logo_black.png',
                            color: themeColor,
                            width: getWiidth(wiidth) / 1.8,
                          ),
                        ),
                        Gap(heiight / 50),
                        Text(
                          'Sign up to see photos and videos from your friends.',
                          textAlign: TextAlign.center,
                          style: txtStyle(
                            13,
                            Color(0xFFa8a892),
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        Gap(heiight / 60),
                        SizedBox(
                          height: 40,
                          child: CustomButton(
                            isFacebookButton: true,
                            buttonRadius: 8,
                            isFilled: true,
                            buttonText: 'Log in with Facebook',
                            onTapEvent: () {}, //yet to implement
                          ),
                        ),
                        Gap(heiight / 70),
                        _orDivider(),
                        SignupInputBoxWeb(
                          hintText: 'Email',
                          textcontroller: _emailController,
                        ),
                        SignupInputBoxWeb(
                          hintText: 'Full Name',
                          textcontroller: _fullNameController,
                        ),
                        SignupInputBoxWeb(
                          hintText: 'Username',
                          textcontroller: _usernameController,
                        ),
                        SignupInputBoxWeb(
                          hintText: 'Password',
                          textcontroller: _passwordController,
                          isPasswordField: true,
                        ),
                        Gap(5),
                        _policyText(),
                        Gap(20),
                        SizedBox(
                          height: 40,
                          child: CustomButton(
                            buttonRadius: 8,
                            isFilled: true,
                            buttonText: 'Sign up.',
                            isFacebookButton: false,
                            onTapEvent: () {
                              _onSignup();
                            }, //yet to implement
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(heiight / 40),
              Container(
                height: 95,
                width: getWiidth(wiidth),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white60),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?',
                        style: txtStyle(15, Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go('/login');
                        },
                        child: ShaderText(
                          textWidget: Text(
                            'Log in.',
                            style: txtStyleNoColor(
                              15,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //form with loading overaly
  Widget formWithLoadingScreen(double heiight, double wiidth) {
    return Stack(
      children: [
        formSection(heiight, wiidth),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black87.withOpacity(0.5)),
          child: Center(child: CircularProgressIndicator(color: themeColor)),
        ),
      ],
    );
  }

  //get responsive with for the form
  double getWiidth(double wiidth) {
    return wiidth <= 655
        ? wiidth / 1.5
        : wiidth <= 900
        ? wiidth / 2.5
        : wiidth <= 1200
        ? wiidth / 3.5
        : wiidth <= 1500
        ? wiidth / 4.5
        : 349;
  }

  Widget _orDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("OR", style: txtStyle(18, Colors.white70)),
        ),
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
      ],
    );
  }

  Widget _policyText() {
    return Column(
      children: [
        Text(
          'People who use our service may have uploaded your contact information to Gramify. Learn More',
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.fade,
          style: txtStyle(
            13,
            Color(0xFFa8a892),
          ).copyWith(fontWeight: FontWeight.w200),
        ),
        Gap(20),
        Text(
          'By signing up, you agree to our Terms , Privacy Policy and Cookies Policy.',
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.fade,
          style: txtStyle(
            13,
            Color(0xFFa8a892),
          ).copyWith(fontWeight: FontWeight.w200),
        ),
      ],
    );
  }
}
