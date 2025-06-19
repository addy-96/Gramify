import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';

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
      csnack(context, 'No Profile Selected, continue with "Skip"');
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
          csnack(context, '${state.errorMessage} (try again letter)');
        }

        if (state is ProfileImageUploadSuccess) {
          context.go('/wrapper/${widget.userId}');
        }
      },
      builder: (context, state) {
        if (state is AuthloadingState) {
          return const Center(child: CircularProgressIndicator());
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
                            gradient: const LinearGradient(
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
                      padding: const EdgeInsets.all(12),
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
                                gradient: const LinearGradient(
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
                          const Gap(10),
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
                                gradient: const LinearGradient(
                                  colors: [thmegrad1, thmegrad2],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.5),
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
