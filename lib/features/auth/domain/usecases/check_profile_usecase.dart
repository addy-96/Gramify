import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/models.dart';
import 'package:gramify/core/usecase_interface.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';

class CheckProfileUsecase implements UsecaseInterface<bool, UsecaseNoParams> {
  final AuthRepository authRepository;
  CheckProfileUsecase({required this.authRepository});
  @override
  Future<Either<Failure, bool>> call(UsecaseNoParams params) async {
    return await authRepository.checkIfProfileFilled();
  }
}

