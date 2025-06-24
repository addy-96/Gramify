import 'package:gramify/features/profile/domain/models/user_profile_model.dart';

class OtherUserProfileModel extends UserProfileModel {
  bool isFollowing;
  final String userID;
  OtherUserProfileModel({
    required this.userID,
    required super.username,
    required super.fullname,
    required super.profileImageUrl,
    required super.followersCount,
    required super.followingCount,
    required super.userPostMap,
    required this.isFollowing,
  });
}
