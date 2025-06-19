import 'package:flutter/widgets.dart';
import 'package:gramify/features/messaging/domain/model/message_model.dart';
import 'package:gramify/features/messaging/domain/model/search_user_model.dart';

sealed class MessageState {}

final class MessageInitialState extends MessageState {}

final class MessageLoadingState extends MessageState {}

final class SearchedUserState extends MessageState {
  final List<SearchUserModel>? searchedUserList;

  SearchedUserState({required this.searchedUserList});
}

final class SearchUserFailureState extends MessageState {
  final String errorMessage;
  SearchUserFailureState({required this.errorMessage});
}

final class LoadUserChatsState extends MessageState {
  final List<MessageModel>? messages;
  LoadUserChatsState({required this.messages});
}

final class LoadUserChatsFailureState extends MessageState {
  final String errorMessage;
  LoadUserChatsFailureState({required this.errorMessage});
}

final class MessageSentState extends MessageState {}

final class MessageSendFailState extends MessageState {
  final String errorMessage;
  MessageSendFailState({required this.errorMessage});
}
