import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/profile/domain/models/other_user_profile_model.dart';
import 'package:gramify/features/profile/domain/models/user_profile_model.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, UserProfileModel?>> getProfileData();

  Future<Either<Failure, OtherUserProfileModel?>> getOtherUserProfileData({
    required String userIdForAction,
  });

  Future<Either<Failure, void>> followRequested({
    required String followedUserId,
  });

  Future<Either<Failure, void>> unfollowRequested({
    required String followedUserID,
  });
}
