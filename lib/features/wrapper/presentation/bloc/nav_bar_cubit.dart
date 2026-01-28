import 'package:flutter_bloc/flutter_bloc.dart';

class NavBarCubit extends Cubit<int> {
  NavBarCubit() : super(0);

  void updateIndex(int index) {
    if (index >= 0 && index <= 4) {
      emit(index);
    } else {
      emit(0);
      throw Exception('Index out of bounds for NavBarCubit');
    }
  }
}
