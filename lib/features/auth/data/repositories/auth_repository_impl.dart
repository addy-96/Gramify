import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/exceptions.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/shared_pref_repo.dart';
import 'package:gramify/features/auth/data/datasorces/auth_datasource.dart';
import 'package:gramify/features/auth/domain/entites/auth_token.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authDatasource, required this.pref});
  final AuthDatasource authDatasource;
  final SharedPreferences pref;

  @override
  Future<Either<Failure, bool>> changePassword({required String email, required String otp}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthToken>> login({required String email, required String password}) async {
    try {
      final authTokens = await authDatasource.login(email: email, password: password);
      pref.setString('accessToken', authTokens.accessToken);
      pref.setString('refreshToken', authTokens.refreshToken);
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
      pref.setString('accessToken', authTokens.accessToken);
      pref.setString('refreshToken', authTokens.refreshToken);
      return right(authTokens);
    } on ApiExceptions catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      pref.remove(SharedPrefRepo.accessToken);
      pref.remove(SharedPrefRepo.accessToken);
      return right(true);
    } catch (err) {
      return left(LocalFailure(err.toString()));
    }
  }
}
