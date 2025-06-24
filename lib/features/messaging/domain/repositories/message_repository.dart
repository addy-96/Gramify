import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/messaging/domain/model/chat_user_model.dart';
import 'package:gramify/features/messaging/domain/model/message_model.dart';
import 'package:gramify/features/messaging/domain/model/search_user_model.dart';

abstract interface class MessageRepository {
  Future<Either<Failure, List<SearchUserModel>?>> searchUsersToChat({
    required String searchQuery,
  });

  Future<Either<Failure, String>> setChatRoom({required String userId});

  Future<Either<Failure, void>> sendMessage({
    required String receipintID,
    required String message,
  });

  Future<Either<Failure, Stream<List<MessageModel>>>> loadMessage({
    required String chatId,
  });

  Future<Either<Failure, List<ChatUserModel>>> loadprevChats();
}
