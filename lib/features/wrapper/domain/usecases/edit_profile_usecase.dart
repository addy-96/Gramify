import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase_interface.dart';
import 'package:gramify/features/wrapper/domain/entities/profile.dart';
import 'package:gramify/features/wrapper/domain/entities/user.dart';
import 'package:gramify/features/wrapper/domain/repositories/wrapper_repository.dart';

class EditProfileUsecase implements UsecaseInterface<User, EditProfileUsecaseParams> {
  final WrapperRepository wrapperRepository;

  EditProfileUsecase({required this.wrapperRepository});
  @override
  Future<Either<Failure, User>> call(EditProfileUsecaseParams params) async {
    return await wrapperRepository.editProfile(Profile());
  }
}

class EditProfileUsecaseParams {
  final String firstName;
  final String lastName;
  final String gender;
  final String pronoun;
  final String state;
  final String country;
  EditProfileUsecaseParams({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.pronoun,
    required this.state,
    required this.country,
  });
}
