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
      param.fullname,
      param.profileImageUrl,
    );
  }
}

class UserSignUpParams {
  final String username;
  final String email;
  final String password;
  final String fullname;
  final String? profileImageUrl;

  UserSignUpParams({
    required this.email,
    required this.username,
    required this.password,
    required this.fullname,
    required this.profileImageUrl,
  });
}
