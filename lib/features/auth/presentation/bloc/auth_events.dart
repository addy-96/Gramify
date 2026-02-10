import 'package:gramify/features/auth/domain/entites/auth_token.dart';

sealed class AuthEvents {}

final class LoginEvent extends AuthEvents {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

final class SignUpEvent extends AuthEvents {
  final String email;
  final String password;
  final String phone;
  final String username;

  SignUpEvent({required this.email, required this.password, required this.phone, required this.username});
}

final class CheckIfUserFilledProfileEvent extends AuthEvents {
  final AuthToken authToken;
  CheckIfUserFilledProfileEvent({required this.authToken});
}

final class LogOutEvent extends AuthEvents {}

final class CheckAuthStatusEvent extends AuthEvents {}
