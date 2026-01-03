import 'package:gramify/features/auth/domain/entites/user.dart';

sealed class AuthStates {}

final class AuthLoadingState extends AuthStates {}

final class AuthenticatedState extends AuthStates {
  final User logedInUser;
  AuthenticatedState({required this.logedInUser});
}

final class UnAuthenticatedState extends AuthStates {}

final class AuthErrorState extends AuthStates {
  final String message;
  AuthErrorState({required this.message});
}
