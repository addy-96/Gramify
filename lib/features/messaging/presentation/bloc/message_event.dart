sealed class MessageEvent {}

final class SearchUserRequested extends MessageEvent {
  final String inputString;
  SearchUserRequested({required this.inputString});
}

final class ChatsScreenRequested extends MessageEvent {}

final class ChattingScreenRequested extends MessageEvent {
  final String userId;

  ChattingScreenRequested({required this.userId});
}

final class SendMessageRequested extends MessageEvent {
  final String receipintId;
  final String message;
  final String chatId;

  SendMessageRequested({
    required this.receipintId,
    required this.message,
    required this.chatId,
  });
}

final class LoadMessagesRequested extends MessageEvent {
  final String chatID;

  LoadMessagesRequested({required this.chatID});
}

final class GetOnlineUserRequested extends MessageEvent {}
