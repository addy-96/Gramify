import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/models.dart';
import 'package:gramify/core/usecase_interface.dart';
import 'package:gramify/features/wrapper/domain/entities/user.dart';
import 'package:gramify/features/wrapper/domain/repositories/wrapper_repository.dart';

class GetUserUsecase implements UsecaseInterface<User, UsecaseNoParams> {
  final WrapperRepository wrapperRepository;
  GetUserUsecase({required this.wrapperRepository});
  @override
  Future<Either<Failure, User>> call(UsecaseNoParams params) async {
    return await wrapperRepository.fetchUser();
  }
}
