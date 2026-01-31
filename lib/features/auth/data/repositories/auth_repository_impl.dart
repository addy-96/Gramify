import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/exceptions.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/auth/data/datasorces/auth_datasource.dart';
import 'package:gramify/features/auth/domain/entites/auth_token.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authDatasource});
  final AuthDatasource authDatasource;

  @override
  Future<Either<Failure, bool>> changePassword({required String email, required String otp}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthToken>> login({required String email, required String password}) async {
    try {
      final authTokens = await authDatasource.login(email: email, password: password);
      return right(authTokens);
    } on ApiExceptions catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> signUp({required String email, required password, required String username, required String phone}) async {
    try {
      final authTokens = await authDatasource.signUp(email: email, password: password, username: username, phone: phone);
      return right(authTokens);
    } on ApiExceptions catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
