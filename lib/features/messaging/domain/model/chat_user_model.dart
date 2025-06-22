class ChatUserModel {
  final String user_id;
  final String fullname;
  final String? imageUrl;
  final String chat_id;

  ChatUserModel({
    required this.user_id,
    required this.fullname,
    required this.imageUrl,
    required this.chat_id,
  });
}
