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

  SignUpRequested({
    required this.email,
    required this.password,
    required this.fullname,
    required this.username,
  });
}
