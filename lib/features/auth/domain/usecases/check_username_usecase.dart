import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase_interface.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';

class CheckUsernameUsecase implements UsecaseInterface<bool, CheckUsernameParams> {
  final AuthRepository authRepository;
  CheckUsernameUsecase({required this.authRepository});
  @override
  Future<Either<Failure, bool>> call(CheckUsernameParams params) {
    return authRepository.checkUsernameAvailabilty(typedUsername: params.typedUsername);
  }
}

class CheckUsernameParams {
  String typedUsername;
  CheckUsernameParams({required this.typedUsername});
}
