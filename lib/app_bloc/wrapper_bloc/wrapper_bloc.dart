import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/app_bloc/wrapper_bloc/wrapper_event.dart';
import 'package:gramify/app_bloc/wrapper_bloc/wrapper_state.dart';

class WrapperBloc extends Bloc<WrapperEvent, WrapperState> {
  WrapperBloc() : super(WrapperInitialState()) {
    on<PageChageRequested>((event, emit) {
      if (event.selectedIndex == 0) {
        emit(HomePageSelected());
      } else if (event.selectedIndex == 1) {
        emit(ExplorePageSelected());
      } else if (event.selectedIndex == 2) {
        emit(NotifiactionPageSelected());
      } else if (event.selectedIndex == 3) {
        emit(ProfilePageSlected());
      }
    });
  }
}
