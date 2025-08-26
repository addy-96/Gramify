import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/core/common/shared_fun/cal_fun.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/auth/presentation/widgets/custom_button.dart';

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
    final height = getHeight(context);
    final width = getWidth(context);
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
                  const Gap(30),
                  Text('Welcome!', style: txtStyleNoColor(22)),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Add Profile Picture', style: txtStyleNoColor(22)),
                        Text(
                          '(Click below to add profile picture)',
                          style: txtStyleNoColor(14),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(40),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            _onSelectProfileImage();
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is ProfileImageSelectedState) {
                                selectedImage = state.selectedImage;
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    gradient: const LinearGradient(
                                      colors: [thmegrad1, thmegrad2],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      radius: width / 4,
                                      backgroundColor: Colors.black,
                                      child:
                                          selectedImage != null
                                              ? ClipRRect(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      100,
                                                    ),
                                                child: Image.file(
                                                  selectedImage!,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                              : const Icon(
                                                Icons.add_a_photo,
                                                color: Colors.white,
                                                size: 50,
                                              ),
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    radius: width / 4,
                                    backgroundColor: Colors.transparent,
                                    child: const Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Gap(10),
                        Text(
                          widget.username,
                          style: txtStyleNoColor(
                            22,
                          ).copyWith(fontWeight: FontWeight.bold),
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
                          CustomButton(
                            buttonRadius: 30,
                            isFilled: true,
                            buttonText: 'Save',
                            isFacebookButton: false,
                            onTapEvent: _onSave,
                          ),
                          const Gap(10),
                          ShaderNormal(
                            childWidget: CustomButton(
                              buttonRadius: 30,
                              isFilled: false,
                              buttonText: 'Skip',
                              isFacebookButton: false,
                              onTapEvent: _onSkip,
                            ),
                          ),
                          const Gap(10),
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
