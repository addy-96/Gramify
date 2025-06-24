import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:gramify/features/profile/domain/models/other_user_profile_model.dart';
import 'package:gramify/features/profile/domain/models/user_profile_model.dart';
import 'package:gramify/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;

  ProfileRepositoryImpl({required this.profileRemoteDatasource});

  @override
  Future<Either<Failure, UserProfileModel?>> getProfileData() async {
    try {
      final res = await profileRemoteDatasource.getProfileData();
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, OtherUserProfileModel?>> getOtherUserProfileData({
    required String userIdForAction,
  }) async {
    try {
      final res = await profileRemoteDatasource.getProfileDataOfOtherUser(
        userID: userIdForAction,
      );
      return right(res as OtherUserProfileModel?);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> followRequested({
    required String followedUserId,
  }) async {
    try {
      final res = await profileRemoteDatasource.followRequested(
        userID: followedUserId,
      );
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unfollowRequested({
    required String followedUserID,
  }) async {
    try {
      final res = await profileRemoteDatasource.unfollowRequested(
        userID: followedUserID,
      );
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }
}
