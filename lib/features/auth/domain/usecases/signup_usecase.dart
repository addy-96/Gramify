import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase_interface.dart';
import 'package:gramify/features/wrapper/domain/entities/user.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';

class SignupUsecase implements UsecaseInterface<User, SignUpParams> {
  SignupUsecase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(SignUpParams params) {
    return authRepository.signUp(email: params.email, password: params.password, username: params.username, phone: params.phone);
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String username;
  final String phone;

  SignUpParams({required this.email, required this.password, required this.username, required this.phone});
}
