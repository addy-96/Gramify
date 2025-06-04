import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/app_bloc/wrapper_bloc/wrapper_event.dart';
import 'package:gramify/app_bloc/wrapper_bloc/wrapper_state.dart';

class WrapperBloc extends Bloc<WrapperEvent, WrapperState> {
  WrapperBloc() : super(WrapperInitialState()) {
    on<PageChageRequestedMobile>((event, emit) {
      if (event.selectedIndex == 0) {
        emit(HomePageSelectedMobile());
      } else if (event.selectedIndex == 1) {
        emit(UploadPageSelectedMobile());
      } else if (event.selectedIndex == 2) {
        emit(ExplorePageSelectedMobile());
      } else if (event.selectedIndex == 3) {
        emit(ProfilePageSlectedMobile());
      }
    });
    on<PageChageRequestedWeb>((event, emit) {
      if (event.selectedIndex == 0) {
        emit(HomePageSelectedWeb());
      } else if (event.selectedIndex == 1) {
        emit(NotificationPageSelectedWeb());
      } else if (event.selectedIndex == 2) {
        emit(ExplorePageSelectedWeb());
      } else if (event.selectedIndex == 3) {
        emit(UploadPageSelectedWeb());
      }
    });
  }
}
