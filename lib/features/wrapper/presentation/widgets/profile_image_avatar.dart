import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/utils.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageAvatar extends StatefulWidget {
  ProfileImageAvatar({super.key, required this.imageFile});
  File? imageFile;

  @override
  State<ProfileImageAvatar> createState() => _ProfileImageAvatarState();
}

class _ProfileImageAvatarState extends State<ProfileImageAvatar> {
  _onSelectImage() async {
    final XFile? pickedImage = await Utils.pickImageFromGallery();
    if (pickedImage != null) {
      setState(() {
        widget.imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onSelectImage();
      },
      child: DottedBorder(
        options: const CircularDottedBorderOptions(
          dashPattern: [6, 10],
          strokeWidth: 6,
          padding: EdgeInsets.all(0),
          color: Appcolors.gradientMint, // needed if gradient is used
        ),
        child: Container(
          padding: const EdgeInsets.all(4),
          height: Utils.getScreenWidth(context) / 2,
          width: Utils.getScreenWidth(context) / 2,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
          child: Center(
            child:
                widget.imageFile != null
                    ? Image.file(widget.imageFile!)
                    : FaIcon(FontAwesomeIcons.solidCamera, color: Colors.grey.shade500, size: Utils.getScreenWidth(context) / 5),
          ),
        ),
      ),
    );
  }
}
