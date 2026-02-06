import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/models.dart';
import 'package:gramify/core/usecase_interface.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase implements UsecaseInterface<bool, UsecaseNoParams> {
  final AuthRepository authRepository;
  LogoutUsecase({required this.authRepository});
  @override
  Future<Either<Failure, bool>> call(params) async{
    return await authRepository.logOut();
  }
}
