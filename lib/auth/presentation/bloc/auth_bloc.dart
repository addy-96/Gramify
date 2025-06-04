import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/auth/domain/usecase/login_usecase.dart';
import 'package:gramify/auth/domain/usecase/logout_usecase.dart';
import 'package:gramify/auth/domain/usecase/selectimage_usecase.dart';
import 'package:gramify/auth/domain/usecase/signup_usecase.dart';
import 'package:gramify/auth/domain/usecase/upload_profilepicture_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  final LogoutUsecase logoutUsecase;
  final SelectimageUsecase selectimageUsecase;
  final UploadProfilepictureUsecase uploadProfilepictureUsecase;

  AuthBloc({
    required this.loginUsecase,
    required this.signupUsecase,
    required this.logoutUsecase,
    required this.selectimageUsecase,
    required this.uploadProfilepictureUsecase,
  }) : super(AuthInitialState()) {
    //
    on<LogInRequested>(_onLogInRequested);

    //
    on<SignUpRequested>(_onSignUpRequested);

    //
    on<LogOutRequested>(_onLogOutRequested);

    //
    on<ProfileImageSelectionRequested>(_onProfileImageSelectionRequested);

    //
    on<UploadProfilePictureRequested>(_onUploadProfilePictureRequested);
  }

  _onLogInRequested(LogInRequested event, Emitter<AuthState> emit) async {
    emit(AuthloadingState());
    final res = await loginUsecase.call(
      LoginUserParams(email: event.email, password: event.password),
    );

    res.fold(
      (l) => emit(AuthFailure(errorMessage: l.message)),
      (r) => emit(
        AuthLogInSuccess(
          userID: r,
          username: r,

          /// error in username here
        ),
      ),
    );
  }

  _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthloadingState());
    final res = await signupUsecase.call(
      UserSignUpParams(
        email: event.email,
        username: event.username,
        password: event.password,
        fullname: event.fullname,
        profileImageUrl: event.profileIMageUrl,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(errorMessage: l.message)),
      (r) => emit(
        AuthSignUpSuccess(userID: r, username: r),
      ), /////////error here with username
    );
  }

  _onLogOutRequested(LogOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthloadingState());
    final res = await logoutUsecase.call(null);
    emit(AuthLogedOut());
  }

  _onProfileImageSelectionRequested(
    ProfileImageSelectionRequested event,
    Emitter<AuthState> emit,
  ) async {
    final res = await selectimageUsecase.call(null);
    File? selectedFile;
    res.fold((l) => ProfileSelectionErrorState(errorMessage: l.message), (r) {
      selectedFile = r;
    });
    emit(ProfileImageSelectedState(selectedImage: selectedFile));
  }

  _onUploadProfilePictureRequested(
    UploadProfilePictureRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthloadingState());

    final res = await uploadProfilepictureUsecase.call(
      UploadPicturParams(
        selectedProfileImage: event.selectedProfileImage,
        username: event.username,
      ),
    );

    res.fold(
      (l) => emit(ProfileImageUploadFialure(errorMessage: l.message)),
      (r) => emit(ProfileImageUploadSuccess()),
    );
  }
}
