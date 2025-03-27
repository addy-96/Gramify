part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthSignUpSuccess extends AuthState {}

final class AuthLogInSuccess extends AuthState {}

final class AuthFilure extends AuthState {
  final String errorMessage;
  AuthFilure({required this.errorMessage});
}
