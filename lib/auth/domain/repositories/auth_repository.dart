import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUserUp(
    final String username,
    final String email,
    final String password,
  );
  Future<Either<Failure, String>> logUserIn(
    final String email,
    final String password,
  );
}
