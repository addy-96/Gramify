import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/auth/domain/entites/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUp({required String email, required password, required String username});
  Future<Either<Failure, User>> login({required String email, required String password});
  Future<Either<Failure, bool>> changePassword({required String email, required String otp});
}
