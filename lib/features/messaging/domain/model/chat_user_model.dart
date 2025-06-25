class ChatUserModel {
  final String receepintUserId;
  final String receepintFullname;
  final String? receipintProfile;
  final String chatId;
  final String lastMessage;
  final DateTime createdAt;
  final DateTime lastUpdated;

  ChatUserModel({
    required this.lastUpdated,
    required this.createdAt,
    required this.lastMessage,
    required this.chatId,
    required this.receepintFullname,
    required this.receepintUserId,
    required this.receipintProfile,
  });
}
