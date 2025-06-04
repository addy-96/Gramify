import 'package:fpdart/fpdart.dart';
import 'package:gramify/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase/usecase_interface.dart';

class LogoutUsecase implements UsecaseInterface {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(param) async {
    return await authRepository.logUserOUt();
  }
}
