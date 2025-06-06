import 'dart:developer';

import 'package:fpdart/src/either.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/profile/data/datasources/profile_remote_datasource.dart';
import 'package:gramify/profile/domain/models/user_profile_model.dart';
import 'package:gramify/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;

  ProfileRepositoryImpl({required this.profileRemoteDatasource});

  @override
  Future<Either<Failure, UserProfileModel?>> getProfileDate({
    required String? userId,
  }) async {
    try {
      final res = await profileRemoteDatasource.getProfileData(userID: userId);
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }
}
