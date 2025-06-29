class SearchUserModel {
  final String userId;
  final String username;
  final String? profileImageUrl;
  final String chatID;
  final DateTime dateTime;

  SearchUserModel({
    required this.profileImageUrl,
    required this.userId,
    required this.username,
    required this.chatID,
    required this.dateTime
  });
}
