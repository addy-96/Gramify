class SearchUserModel {
  final String userId;
  final String username;
  final String? profileImageUrl;
  final String chatId;

  SearchUserModel({
    required this.chatId,
    required this.profileImageUrl,
    required this.userId,
    required this.username,
  });
}
