import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/wrapper/domain/entities/profile.dart';
import 'package:gramify/features/wrapper/domain/entities/user.dart';

abstract class WrapperRepository {
  Future<Either<Failure, User>> fetchUser();
  Future<Either<Failure, User>> editProfile(Profile userProfile);
  Future<Either<Failure, String>> uploadUserProfileImage(String filePath);
}
