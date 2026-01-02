
import 'package:gramify/features/auth/domain/entites/user.dart';

sealed class AuthStates  {}

final class AuthenticatedState extends AuthStates {
  final User logedInUser;
  AuthenticatedState({required this.logedInUser});
}

final class UnAuthenticatedState extends AuthStates {}