sealed class MessageEvent {}

final class SearchUserRequested extends MessageEvent {
  final String inputString;
  SearchUserRequested({required this.inputString});
}

final class ChattingScreenRequested extends MessageEvent {
  final String userId;

  ChattingScreenRequested({required this.userId});
}

final class SendMessageRequested extends MessageEvent {
  final String chatId;
  final String receipintId;
  final String message;

  SendMessageRequested({
    required this.chatId,
    required this.receipintId,
    required this.message,
  });
}
