import 'package:gramify/features/messaging/domain/model/chat_user_model.dart';
import 'package:gramify/features/messaging/domain/model/message_model.dart';
import 'package:gramify/features/messaging/domain/model/online_user_model.dart';
import 'package:gramify/features/messaging/domain/model/search_user_model.dart';

sealed class MessageState {}

final class MessageInitialState extends MessageState {}

final class MessageLoadingState extends MessageState {}

final class SearchedUserState extends MessageState {
  final List<SearchUserModel>? searchedUserList;

  SearchedUserState({required this.searchedUserList});
}

final class RoomSetState extends MessageState {
  final String chatID;

  RoomSetState({required this.chatID});
}

final class SearchUserFailureState extends MessageState {
  final String errorMessage;
  SearchUserFailureState({required this.errorMessage});
}

final class LoadUserMessageState extends MessageState {
  final Stream<List<MessageModel>> messages;
  final String loggedUserId;
  LoadUserMessageState({required this.messages, required this.loggedUserId});
}

final class LoadUserMessageFailureState extends MessageState {
  final String errorMessage;
  LoadUserMessageFailureState({required this.errorMessage});
}

final class MessageSentState extends MessageState {}

final class MessageSendFailState extends MessageState {
  final String errorMessage;
  MessageSendFailState({required this.errorMessage});
}

final class ChatsLoadedState extends MessageState {
  final List<ChatUserModel> chatsList;
  ChatsLoadedState({required this.chatsList});
}

final class ChatLoadingState extends MessageState {}

final class LoadUserChatsFailureState extends MessageState {
  final String errorMessage;
  LoadUserChatsFailureState({required this.errorMessage});
}

final class OnlineUserFetchedState extends MessageState {
  final List<OnlineUserModel> listOfOnlineUser;
  OnlineUserFetchedState({required this.listOfOnlineUser});
}

final class OnlineUserFetchErrorState extends MessageState {
  final String errorMessage;
  OnlineUserFetchErrorState({required this.errorMessage});
}
