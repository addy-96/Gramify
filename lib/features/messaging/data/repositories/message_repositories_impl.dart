import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/core/errors/server_exception.dart';
import 'package:gramify/features/messaging/data/datasorces/message_datasorce.dart';
import 'package:gramify/features/messaging/domain/model/message_model.dart';
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
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>?>> setChatRoom({
    required String userId,
  }) async {
    try {
      final res = await messageDatasorce.setChatRoom(userIdToChat: userId);
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String chatID,
    required String receipintID,
    required String message,
  }) async {
    try {
      final res = await messageDatasorce.sendMessage(
        chatID: chatID,
        reciepntuserID: receipintID,
        message: message,
      );
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>?>> loadMessage({
    required String chatId,
  }) async {
    try {
      final res = await messageDatasorce.loadChats(chatId: chatId);

      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }
}
