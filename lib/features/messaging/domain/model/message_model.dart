class MessageModel {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime messageTime;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.messageTime,
  });
}
