import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/auth/domain/entites/auth_token.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AuthToken>> signUp({required String email, required password, required String username, required String phone});
  Future<Either<Failure, AuthToken>> login({required String email, required String password});
  Future<Either<Failure, bool>> changePassword({required String email, required String otp});
}
