import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase/usecase_interface.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';

class CheckUsernameUsecase
    implements UsecaseInterface<bool, CheckUsernameParams> {
  CheckUsernameUsecase({required this.authRepository});
  final AuthRepository authRepository;
  @override
  Future<Either<Failure, bool>> call(CheckUsernameParams params) async {
    return await authRepository.cehckUsername(
      enteredString: params.eneteredUsername,
    );
  }
}

class CheckUsernameParams {
  final String eneteredUsername;
  CheckUsernameParams({required this.eneteredUsername});
}
