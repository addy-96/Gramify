import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUserUp(
    final String username,
    final String email,
    final String password,
    final String fullname,
    final String? profileImageUrl,
  );
  Future<Either<Failure, String>> logUserIn(
    final String email,
    final String password,
  );
  Future<Either<Failure, void>> logUserOUt();

  Future<Either<Failure, void>> uploadProfilePicture(
    final File profilePicture,
    final String username,
  );

  Future<Either<Failure, File?>> selectImageFromLocalStorage();

  Future<Either<Failure, bool>> cehckUsername({required String enteredString});
}
