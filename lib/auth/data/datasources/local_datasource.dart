import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract interface class LocalDatasource {
  Future<File?> selectImageFromLocalStorage();
}

class LocalDatasourceImpl implements LocalDatasource {
  LocalDatasourceImpl({required this.imagePicker});

  final ImagePicker imagePicker;

  @override
  Future<File?> selectImageFromLocalStorage() async {
    try {
      final selectedimageXfile = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (selectedimageXfile == null) {
        return null;
      }
      final imagefile = File(selectedimageXfile.path);
      return imagefile;
    } catch (err) {
      log(err.toString());
    }
  }
}
