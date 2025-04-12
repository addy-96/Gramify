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
