import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase/usecase_interface.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';

class CheckEmailUsecase
    implements UsecaseInterface<bool, CheckEmailUsecaseParams> {
  CheckEmailUsecase({required this.authRepository});
  final AuthRepository authRepository;
  @override
  Future<Either<Failure, bool>> call(param) async {
    return await authRepository.checkEmail(email: param.email);
  }
}

class CheckEmailUsecaseParams {
  final String email;

  CheckEmailUsecaseParams({required this.email});
}
