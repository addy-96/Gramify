part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class LogInRequested extends AuthEvent {
  final String email;
  final String password;

  LogInRequested({required this.email, required this.password});
}

final class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullname;
  final String username;
  final String? profileIMageUrl;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.fullname,
    required this.username,
    required this.profileIMageUrl,
  });
}

final class LogOutRequested extends AuthEvent {}

final class ProfileImageSelectionRequested extends AuthEvent {}

final class UploadProfilePictureRequested extends AuthEvent {
  final File selectedProfileImage;
  final String username;
  UploadProfilePictureRequested({
    required this.selectedProfileImage,
    required this.username,
  });
}
