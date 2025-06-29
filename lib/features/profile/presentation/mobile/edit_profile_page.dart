import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_event.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({
    super.key,

    required this.fullname,
    required this.username,
    required this.gender,
    required this.bio,
    required this.profileImgeUrl,
  });

  final String fullname;
  final String username;
  final String? gender;
  final String? bio;
  String? profileImgeUrl;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _fullnameController;
  late TextEditingController _usernameController;
  late TextEditingController _genderController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _fullnameController = TextEditingController(text: widget.fullname);
    _usernameController = TextEditingController(text: widget.username);
    _genderController = TextEditingController(text: widget.gender);
    _bioController = TextEditingController(text: widget.bio);
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _usernameController.dispose();
    _genderController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  File? pickedImage;

  void selectProfilePicture() async {
    final imagePicker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    Navigator.of(context).pop();
    if (imagePicker == null) {
      return;
    }
    pickedImage = File(imagePicker.path);
    Future.delayed(const Duration(seconds: 1));
    showSelectedImage(pickedimage: pickedImage!);
  }

  void showSelectedImage({required File pickedimage}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.grey.shade900,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(20),
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.12,
                backgroundImage: FileImage(pickedimage),
              ),
              const Gap(20),
              OutlinedButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(
                    ProfilePictureEditRequeested(profilePicture: pickedimage),
                  );
                  Navigator.of(context).pop();
                },
                child: ShaderText(
                  textWidget: Text(
                    'Set Profile Picture!',
                    style: txtStyle(small12, Colors.white),
                  ),
                ),
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }

  void onSave() async {
    bool isFullnameChanged = false;
    bool isUsernameChanged = false;
    bool isGenderChanged = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: txtStyle(
            title24,
            Colors.white,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Center(
          child: ListView(
            children: [
              Center(
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfilePictureEditFailureState) {
                      csnack(
                        context,
                        'Error in Uploading proofile picture ${state.errorMessage.toString()}',
                      );
                    }
                    if (state is ProfilePictureEditEditSuccessState) {
                      widget.profileImgeUrl = state.newImageUrl;
                      csnack(context, 'Profile Updated Succesfully!');
                    }
                  },
                  builder: (context, state) {
                    if (state is ProfilePictureUploadingState) {
                      return CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.09,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is ProfilePictureEditEditSuccessState) {
                      if (state.newImageUrl != null) {
                        return CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.09,
                          backgroundImage: NetworkImage(state.newImageUrl!),
                        );
                      } else {
                        return CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.09,

                          child: const Icon(Ionicons.person_outline),
                        );
                      }
                    }
                    return CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.09,
                      backgroundImage:
                          widget.profileImgeUrl != null
                              ? NetworkImage(widget.profileImgeUrl!)
                              : null,
                      child:
                          widget.profileImgeUrl == null
                              ? const Icon(Ionicons.person_outline)
                              : null,
                    );
                  },
                ),
              ),
              const Gap(5),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfilePictureUploadingState) {
                    return Center(
                      child: Text(
                        'Hold on, updating your profile picture',
                        style: txtStyle(small12, Colors.grey.shade500),
                      ),
                    );
                  }
                  return TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetAnimationDuration: const Duration(
                              milliseconds: 100,
                            ),
                            insetAnimationCurve: Curves.bounceInOut,
                            backgroundColor: Colors.grey.shade900,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                const Gap(10),
                                OutlinedButton(
                                  onPressed: () {
                                    selectProfilePicture();
                                  },
                                  child: Text(
                                    'Update Profile Picture',
                                    style: txtStyle(small12, Colors.green),
                                  ),
                                ),
                                widget.profileImgeUrl != null
                                    ? OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        context.read<ProfileBloc>().add(
                                          ProfilePictureEditRequested(
                                            profilePicture: null,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Remove Profile Picture',
                                        style: txtStyle(small12, Colors.red),
                                      ),
                                    )
                                    : const SizedBox.shrink(),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: txtStyle(small12, Colors.white),
                                  ),
                                ),

                                const Gap(10),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'Edit Profile Picture ',
                      style: txtStyle(bodyText16, Colors.white),
                    ),
                  );
                },
              ),
              const Gap(15),
              EditProileInputField(
                lableText: 'Fullname',
                textEditingController: _fullnameController,
                hintText: 'Type your fullname here.',
                maxLenght: fullnameMAXLength,
              ),
              const Gap(15),
              EditProileInputField(
                lableText: 'Username',
                textEditingController: _usernameController,
                hintText: 'Type your Username here.',
                maxLenght: usernameMAXLenght,
              ),
              const Gap(15),
              EditProileInputField(
                lableText: 'Gender',
                textEditingController: _genderController,
                hintText: 'Tap To Select Gender.',
                maxLenght: 10,
              ),
              const Gap(15),
              EditProileInputField(
                hintText: 'Type your profile bio here.',
                maxLenght: 150,
                lableText: 'Bio',
                textEditingController: _bioController,
              ),
              const Gap(20),
              InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [thmegrad1, thmegrad2],
                    ),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: txtStyle(
                        bodyText14,
                        Colors.black,
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProileInputField extends StatelessWidget {
  const EditProileInputField({
    super.key,
    required this.hintText,
    required this.lableText,
    required this.textEditingController,
    required this.maxLenght,
  });
  final String hintText;
  final TextEditingController textEditingController;
  final String lableText;
  final int maxLenght;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLenght,
      controller: textEditingController,
      style: txtStyle(bodyText14, Colors.white),
      maxLines: hintText == 'bio' || hintText == 'Bio' ? 5 : 1,
      onTap:
          lableText == 'Gender'
              ? () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Select Gender',
                            style: txtStyle(
                              bodyText16,
                              Colors.white,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Male',
                              style: txtStyle(small12, Colors.white),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Female',
                              style: txtStyle(small12, Colors.white),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Others',
                              style: txtStyle(small12, Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              : null,
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        labelText: lableText,
        hintStyle: txtStyle(bodyText14, Colors.grey.shade800),
        labelStyle: txtStyle(
          bodyText14,
          Colors.grey.shade700,
        ).copyWith(fontWeight: FontWeight.w600),
        enabledBorder: OutlineInputBorder(
          gapPadding: 8,
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade900),
        ),
        disabledBorder: OutlineInputBorder(
          gapPadding: 8,
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade900),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 8,
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade900),
        ),
        border: OutlineInputBorder(
          gapPadding: 8,
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 2, color: Colors.grey.shade900),
        ),
      ),
    );
  }
}
