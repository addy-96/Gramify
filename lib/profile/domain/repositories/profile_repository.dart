import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/profile/domain/models/user_profile_model.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, UserProfileModel?>> getProfileDate({
    required String? userId,
  });
}
