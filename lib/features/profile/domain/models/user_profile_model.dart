class UserProfileModel {
  final String username;
  final String fullname;
  final String? profileImageUrl;
  final int followersCount;
  final int followingCount;
  final String? bio;
  final Map<String, String> userPostMap;
  final String? gender;

  UserProfileModel({
    required this.userPostMap,
    required this.username,
    required this.fullname,
    required this.profileImageUrl,
    required this.followersCount,
    required this.followingCount,
    required this.bio,
    required this.gender,
  });
}
