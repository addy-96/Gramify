import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

class SelectedpictureCubit extends Cubit<AssetEntity?> {
  SelectedpictureCubit() : super(null);

  void pictureSelected(AssetEntity selectedImage) async {
    emit(selectedImage);
  }
}
