import 'dart:developer';
import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CameraAwesomeBuilder.awesome(
          saveConfig: SaveConfig.photoAndVideo(),
          onMediaCaptureEvent: (mediaCapture) async {
            log('reached 1');
            await Future.delayed(
              Duration(seconds: 5),
            ); // to start edit from here
            log('reached 2');
            mediaCapture.captureRequest.path != null
                ? Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => PicturePage(
                          filePath: mediaCapture.captureRequest.path!,
                        ),
                  ),
                )
                : log('isNUll');
          },
        ),
      ),
    );
  }
}

class PicturePage extends StatelessWidget {
  const PicturePage({super.key, required this.filePath});
  final String filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.file(File(filePath))));
  }
}
