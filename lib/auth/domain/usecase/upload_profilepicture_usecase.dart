import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:gramify/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase/usecase_interface.dart';

class UploadProfilepictureUsecase
    implements UsecaseInterface<void, UploadPicturParams> {
  UploadProfilepictureUsecase({required this.authRepository});

  final AuthRepository authRepository;
  @override
  Future<Either<Failure, void>> call(param) async {
    return await authRepository.uploadProfilePicture(
      param.selectedProfileImage,
      param.username,
    );
  }
}

class UploadPicturParams {
  UploadPicturParams({
    required this.selectedProfileImage,
    required this.username,
  });
  final File selectedProfileImage;
  final String username;
}
