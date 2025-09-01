import 'dart:developer';
import 'dart:io';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:gramify/features/add_post/presentation/bloc/cubit/selectedPicture_cubit.dart';
import 'package:gramify/features/add_post/presentation/mobile/post_creator_page.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';

class CameraPageForPost extends StatelessWidget {
  const CameraPageForPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CameraAwesomeBuilder.awesome(
          theme: AwesomeTheme(bottomActionsBackgroundColor: Colors.transparent, buttonTheme: AwesomeButtonTheme(backgroundColor: Colors.black38, foregroundColor: whiteForText)),
          availableFilters: awesomePresetFiltersList,
          saveConfig: SaveConfig.photoAndVideo(),
          onMediaCaptureEvent: (mediaCapture) async {
            await Future.delayed(const Duration(milliseconds: 1500)); // to start edit from here
            mediaCapture.captureRequest.path != null
                ? Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PicturePage(isStory: false, filePath: mediaCapture.captureRequest.path!)))
                : log('image is null');
          },
        ),
      ),
    );
  }
}

class PicturePage extends StatelessWidget {
  const PicturePage({required this.isStory, super.key, required this.filePath});
  final String filePath;
  final bool isStory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Image.file(File(filePath))),
          isStory
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: ShaderText(textWidget: Text('Retake', style: txtStyleNoColor(18))),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AddPostBloc>().add(UploadStoryRequested(storyImage: File(filePath)));
                      context.pop();
                    },
                    child: ShaderText(textWidget: Text('Add to Story', style: txtStyleNoColor(18))),
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      final File selectedImageFile = File(filePath);
                      context.read<SelectedpictureCubit>().pictureSelected(selectedImageFile);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PostCreatorPage()));
                    },
                    icon: const ShaderIcon(iconWidget: Icon(Ionicons.checkmark, size: 40)),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const CameraPageForPost()));
                    },
                    icon: const ShaderIcon(iconWidget: Icon(Ionicons.trash_bin_outline, size: 40)),
                  ),
                ],
              ),
          const Gap(10),
        ],
      ),
    );
  }
}
