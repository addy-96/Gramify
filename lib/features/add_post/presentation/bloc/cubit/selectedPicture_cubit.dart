import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedpictureCubit extends Cubit<File?> {
  SelectedpictureCubit() : super(null);

  void pictureSelected(File selectedImage) async {
    emit(selectedImage);
  }
}
