import 'dart:io';
import 'package:gramify/core/errors/local_mobile_exception.dart';
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
      throw LocalMobileException(message: err.toString());
    }
  }
}
