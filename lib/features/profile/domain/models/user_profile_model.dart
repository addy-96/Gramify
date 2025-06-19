class UserProfileModel {
  final String username;
  final String fullname;
  final String? profileImageUrl;
  final int followersCount;
  final int followingCount;
  final Map<String, String> userPostMap;

  UserProfileModel({
    required this.userPostMap,
    required this.username,
    required this.fullname,
    required this.profileImageUrl,
    required this.followersCount,
    required this.followingCount,
  });
}
