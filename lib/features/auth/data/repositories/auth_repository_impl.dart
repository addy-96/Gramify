import 'package:fpdart/src/either.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/auth/data/datasorces/auth_datasource.dart';
import 'package:gramify/features/auth/domain/entites/user.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authDatasource});
  final AuthDatasource authDatasource;
  
  @override
  Future<Either<Failure, bool>> changePassword({required String email, required String otp}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, User>> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, User>> signUp({required String email, required password, required String username}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

}
