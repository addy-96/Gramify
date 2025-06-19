import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:gramify/features/add_post/presentation/mobile/camera_page_for_post.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';

class MakeStoryPage extends StatelessWidget {
  const MakeStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const ShaderText(textWidget: Text('Create Story'))),
      body: CameraAwesomeBuilder.custom(
        saveConfig: SaveConfig.photo(),
        onMediaCaptureEvent: (mediaCapture) async {
          await Future.delayed(const Duration(milliseconds: 1500));

          mediaCapture.captureRequest.path != null
              ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder:
                      (context) => PicturePage(
                        isStory: true,
                        filePath: mediaCapture.captureRequest.path!,
                      ),
                ),
              )
              : null;
        },
        builder:
            (state, preview) => Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.flash_auto),
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      state.when(
                        onPhotoMode: (photoState) => photoState.takePhoto(),
                      );
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: const LinearGradient(
                          colors: [thmegrad1, thmegrad2],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
