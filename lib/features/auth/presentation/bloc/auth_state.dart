part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthloadingState extends AuthState {}

final class AuthSignUpSuccess extends AuthState {
  final String userID;
  final String username;

  AuthSignUpSuccess({required this.userID, required this.username});
}

final class AuthLogInSuccess extends AuthState {
  final String userID;
  final String username;

  AuthLogInSuccess({required this.userID, required this.username});
}

final class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure({required this.errorMessage});
}

final class AuthLogedOut extends AuthState {}

final class ProfileImageSelectedState extends AuthState {
  final File? selectedImage;
  ProfileImageSelectedState({required this.selectedImage});
}

final class ProfileSelectionErrorState extends AuthState {
  final String errorMessage;
  ProfileSelectionErrorState({required this.errorMessage});
}

final class ProfileImageUploadFialure extends AuthState {
  final String errorMessage;
  ProfileImageUploadFialure({required this.errorMessage});
}

final class ProfileImageUploadSuccess extends AuthState {}

final class CheckedUsernameState extends AuthState {
  final bool isAvailable;
  CheckedUsernameState({required this.isAvailable});
}

final class CheckedUsernameFailureState extends AuthState {
  final String errorMessage;
  CheckedUsernameFailureState({required this.errorMessage});
}

final class EmailExistenceLoader extends AuthState {}

final class IfEmailExistsState extends AuthState {
  final bool emailExist;
  IfEmailExistsState({required this.emailExist});
}

final class CheckEmailFailure extends AuthState {
  final String error;
  CheckEmailFailure({required this.error});
}
