import 'package:fpdart/fpdart.dart';
import 'package:gramify/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase/usecase_interface.dart';

class SignupUsecase implements UsecaseInterface<String, UserSignUpParams> {
  final AuthRepository authRepository;

  SignupUsecase({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(UserSignUpParams param) async {
    return await authRepository.signUserUp(
      param.username,
      param.email,
      param.password,
    );
  }
}

class UserSignUpParams {
  final String username;
  final String email;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.username,
    required this.password,
  });
}
