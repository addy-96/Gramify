import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/wrapper/presentation/bloc/wrapper_event.dart';
import 'package:gramify/features/wrapper/presentation/bloc/wrapper_state.dart';

class WrapperBloc extends Bloc<WrapperEvent, WrapperState> {
  WrapperBloc() : super(WrapperInitState()) {
    on<FetchUserEvent>(_onFetchUserEvent);
    on<EditProfileEvent>(_onEditProfile);
    on<UploadUserProfileImageEvent>(_onUploadUserProfileImage);
  }

  Future<void> _onFetchUserEvent(FetchUserEvent event, Emitter<WrapperState> emit) async {
    emit(WrapperLoadingState());
    try {} catch (e) {}
  }

  Future<void> _onEditProfile(EditProfileEvent event, Emitter<WrapperState> emit) async {
    emit(WrapperLoadingState());
    try {} catch (e) {}
  }

  Future<void> _onUploadUserProfileImage(UploadUserProfileImageEvent event, Emitter<WrapperState> emit) async {
    emit(WrapperLoadingState());
    try {} catch (e) {}
  }
}
