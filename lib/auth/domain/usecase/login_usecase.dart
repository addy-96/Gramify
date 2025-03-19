import 'package:fpdart/src/either.dart';
import 'package:gramify/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase/usecase_interface.dart';


class LoginUsecase implements UsecaseInterface<String, LoginUserParams> {
  LoginUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;
  @override
  Future<Either<Failure, String>> call(LoginUserParams params) async {
    return await authRepository.logUserIn(
      params.email,
      params.password,
    );
  }
}

class LoginUserParams {
  final String email;
  final String password;

  LoginUserParams({
    required this.email,
    required this.password,
  });
}
