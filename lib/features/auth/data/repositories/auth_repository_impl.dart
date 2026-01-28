import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/exceptions.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/auth/data/datasorces/auth_datasource.dart';
import 'package:gramify/features/wrapper/domain/entities/user.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authDatasource});
  final AuthDatasource authDatasource;

  @override
  Future<Either<Failure, bool>> changePassword({required String email, required String otp}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> login({required String email, required String password}) async {
    try {
      final userModel = await authDatasource.login(email: email, password: password);
      if (userModel == null) {
        return left(const ServerFailure('User is null'));
      }
      return right(userModel);
    } on ApiExceptions catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({required String email, required password, required String username, required String phone}) async {
    try {
      final userModel = await authDatasource.signUp(email: email, password: password, username: username, phone: phone);
      if (userModel == null) {
        return left(const ServerFailure('User is null'));
      }
      return right(userModel);
    } on ApiExceptions catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
