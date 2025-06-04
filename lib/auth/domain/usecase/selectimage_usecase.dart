import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:gramify/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/usecase/usecase_interface.dart';

class SelectimageUsecase implements UsecaseInterface {
  final AuthRepository authRepository;
  SelectimageUsecase({required this.authRepository});

  @override
  Future<Either<Failure, dynamic>> call(param) async {
    return await authRepository.selectImageFromLocalStorage();
  }
}
