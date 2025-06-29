import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/messaging/data/datasorces/message_datasorce.dart';
import 'package:gramify/features/messaging/domain/model/chat_user_model.dart';
import 'package:gramify/features/messaging/domain/model/message_model.dart';
import 'package:gramify/features/messaging/domain/model/online_user_model.dart';
import 'package:gramify/features/messaging/domain/model/search_user_model.dart';
import 'package:gramify/features/messaging/domain/repositories/message_repository.dart';

class MessageRepositoriesImpl implements MessageRepository {
  MessageRepositoriesImpl({required this.messageDatasorce});
  final MessageDatasorce messageDatasorce;

  @override
  Future<Either<Failure, List<SearchUserModel>?>> searchUsersToChat({
    required String searchQuery,
  }) async {
    try {
      final res = await messageDatasorce.searchUserToChat(
        searchQuery: searchQuery,
      );
      return right(res);
    } catch (err) {
      log('Error in messagerepositry.searchusertochat : ${err.toString()}');

      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> setChatRoom({required String userId}) async {
    try {
      final res = await messageDatasorce.setChatRoom(userIdToChat: userId);
      return right(res);
    } catch (err) {
      log('Error in messagerepositry.setchatroom : ${err.toString()}');

      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String receipintID,
    required String message,
  }) async {
    try {
      final res = await messageDatasorce.sendMessage(
        reciepntuserID: receipintID,
        message: message,
      );
      return right(res);
    } catch (err) {
      log('Error in messagerepositry.sendmessage : ${err.toString()}');

      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<MessageModel>>>> loadMessage({
    required String chatId,
  }) async {
    try {
      final res = messageDatasorce.loadChatsStream(chatId: chatId);

      return right(res);
    } catch (err) {
      log('Error in messagerepositry.loadmessage : ${err.toString()}');

      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatUserModel>>> loadprevChats() async {
    try {
      final res = await messageDatasorce.getUserChats();
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OnlineUserModel>>> getOnlineUsers() async {
    try {
      final res = await messageDatasorce.getOnlineUsers();
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }
}
