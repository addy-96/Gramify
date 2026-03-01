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

final class LogOutEvent extends AuthEvents {}

final class CheckAuthStatusEvent extends AuthEvents {}

final class CheckUsernameAvailablity extends AuthEvents {
  final String username;
  CheckUsernameAvailablity({required this.username});
}
