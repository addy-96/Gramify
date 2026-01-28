import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase_interface.dart';
import 'package:gramify/features/wrapper/domain/entities/user.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase implements UsecaseInterface<User, LoginParams> {
  LoginUsecase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return authRepository.login(email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
