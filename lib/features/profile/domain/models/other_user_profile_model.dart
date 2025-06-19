import 'package:gramify/features/profile/domain/models/user_profile_model.dart';

class OtherUserProfileModel extends UserProfileModel {
  final bool? isFollowing;
  OtherUserProfileModel({
    required super.username,
    required super.fullname,
    required super.profileImageUrl,
    required super.followersCount,
    required super.followingCount,
    required super.userPostMap,
    required this.isFollowing,
  });
}
