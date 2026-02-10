import 'package:gramify/features/auth/domain/entites/auth_token.dart';

sealed class AuthStates {}

final class AuthLoadingState extends AuthStates {}

final class AuthenticatedState extends AuthStates {
  final AuthToken authToken;
  AuthenticatedState({required this.authToken});
}

final class UnAuthenticatedState extends AuthStates {}

final class AuthErrorState extends AuthStates {
  final String message;
  AuthErrorState({required this.message});
}

final class ProfileNotFilledState extends AuthStates {}
