import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:gramify/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:gramify/features/auth/data/datasources/local_datasource.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/core/errors/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.localDatasource,
  });
  final AuthRemoteDatasource authRemoteDatasource;
  final LocalDatasource localDatasource;
  @override
  Future<Either<Failure, String>> signUserUp(
    String username,
    String email,
    String password,
    String fullname,
    String? profileImageUrl,
  ) async {
    try {
      final res = await authRemoteDatasource.signUserUp(
        username: username,
        email: email,
        password: password,
        fullname: fullname,
        profileImageUrl: profileImageUrl,
      );
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logUserIn(
    String email,
    String password,
  ) async {
    try {
      final res = await authRemoteDatasource.logUserIn(
        email: email,
        password: password,
      );
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logUserOUt() async {
    try {
      final res = await authRemoteDatasource.logUserOut();

      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> uploadProfilePicture(
    File profilePicture,
    String username,
  ) async {
    try {
      final res = await authRemoteDatasource.uploadProfilePicture(
        profileImage: profilePicture,
        username: username,
      );
      return right(null);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, File?>> selectImageFromLocalStorage() async {
    try {
      final res = await localDatasource.selectImageFromLocalStorage();
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> cehckUsername({
    required String enteredString,
  }) async {
    try {
      final res = await authRemoteDatasource.checkUsername(
        enteredUsername: enteredString,
      );
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmail({required String email}) async {
    try {
      final res = await authRemoteDatasource.checkIfEmailExist(
        email: email,
      );
      return right(res);
    } catch (err) {
      
     return left(Failure(message: err.toString()));
    }
  }
}
