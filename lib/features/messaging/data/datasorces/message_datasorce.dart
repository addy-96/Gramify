import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/core/errors/server_exception.dart';
import 'package:gramify/features/messaging/domain/model/message_model.dart';
import 'package:gramify/features/messaging/domain/model/search_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class MessageDatasorce {
  // one function to get all user chats
  Future<List<SearchUserModel>?> searchUserToChat({
    required String searchQuery,
  });
  Future<List<MessageModel>?> setChatRoom({required String userIdToChat});
  Future<String?> getChatId({
    required String loggedUserId,
    required String receipintUserID,
  });
  Future<void> addToUsersChats({
    required String chatId,
    required String loggedUserId,
    required String receipintUserID,
  });

  Future<void> sendMessage({
    required String chatID,
    required String reciepntuserID,
    required String message,
  });

  Future<List<MessageModel>?> loadChats({required String chatId});
  Future<String> createChatRoom({
    required String loggedUSerId,
    required String userIdToChat,
  });
}

class MessageDataSourceImpl implements MessageDatasorce {
  MessageDataSourceImpl({required this.supabase});
  final Supabase supabase;

  //
  @override
  Future<List<MessageModel>?> setChatRoom({
    required String userIdToChat,
  }) async {
    try {
      final loggedUserId = await getLoggedUserId();

      //check if chatroom exist
      final checkChatId = await getChatId(
        loggedUserId: loggedUserId,
        receipintUserID: userIdToChat,
      ); // if exist load messages
      if (checkChatId != null) {
        log('not nuull');
        final getchats = await loadChats(chatId: checkChatId);
        return getchats;
      } else {
        final res = await createChatRoom(
          loggedUSerId: loggedUserId,
          userIdToChat: userIdToChat,
        );
      }
      return [];
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<String?> getChatId({
    required String loggedUserId,
    required String receipintUserID,
  }) async {
    try {
      final getCreatedChats = await supabase.client
          .from(userTable)
          .select('created_chats')
          .eq('user_id', loggedUserId);

      final List<dynamic> createdChats =
          getCreatedChats.first['created_chats'] ?? [];

      final List<dynamic> getRecievedChats = await supabase.client
          .from(userTable)
          .select('received_chats')
          .eq('user_id', receipintUserID);

      final List<dynamic> receivedChats =
          getRecievedChats.first['received_chats'] ?? [];

      if ((createdChats == null || createdChats.isEmpty) ||
          (receivedChats == null || receivedChats.isEmpty)) {
        return null;
      }
      final Set<dynamic> set1 = createdChats.toSet();
      final Set<dynamic> set2 = receivedChats.toSet();
      final commonChat = set1.concat(set2);

      if (commonChat == {} || commonChat.isEmpty) {
        return null;
      }
      return commonChat.first as String;
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<void> addToUsersChats({
    required String chatId,
    required String loggedUserId,
    required String receipintUserID,
  }) async {
    try {
      //logged user data modify
      final loggedUsrDat = await supabase.client
          .from(userTable)
          .select('created_chats')
          .eq('user_id', loggedUserId);

      final List<dynamic> listOfCreatedChats =
          loggedUsrDat.first['created_chats'] ?? [];

      if (!listOfCreatedChats.contains(chatId)) {
        listOfCreatedChats.add(chatId);
      }

      await supabase.client
          .from(userTable)
          .update({'created_chats': listOfCreatedChats})
          .eq('user_id', loggedUserId);

      //other user data modify
      final recepintUsrDat = await supabase.client
          .from(userTable)
          .select('received_chats')
          .eq('user_id', receipintUserID);

      final List<dynamic> listOfRecievedChats =
          recepintUsrDat.first['received_chats'] ?? [];

      if (!listOfRecievedChats.contains(chatId)) {
        listOfRecievedChats.add(chatId);
      }

      await supabase.client
          .from(userTable)
          .update({'received_chats': listOfRecievedChats})
          .eq('user_id', receipintUserID);
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<List<SearchUserModel>?> searchUserToChat({
    required String searchQuery,
  }) async {
    try {
      if (searchQuery == null || searchQuery.isEmpty) {
        return [];
      }
      final loggedUserId = await getLoggedUserId();

      final List<SearchUserModel> listOfSearchedUser = [];
      final getFollowerList = await supabase.client
          .from(userTable)
          .select('list-of-followers')
          .eq('user_id', loggedUserId);

      final List<dynamic> listOfFollowers =
          getFollowerList.first['list-of-followers'] ?? [];

      for (var userid in listOfFollowers) {
        final res2 = await supabase.client
            .from(userTable)
            .select('username, profile_image_url, user_id')
            .eq('user_id', userid);

        var chatID = await getChatId(
          loggedUserId: loggedUserId,
          receipintUserID: res2.first['user_id'],
        );

        chatID ??= await createChatRoom(
          loggedUSerId: loggedUserId,
          userIdToChat: res2.first['user_id'],
        );

        final username = res2.first['username'] as String;
        if (username.startsWith(searchQuery)) {
          final user = SearchUserModel(
            profileImageUrl: res2.first['profile_image_url'] ?? null,
            userId: res2.first['user_id'],
            username: res2.first['username'],
            chatId: chatID,
          );

          listOfSearchedUser.add(user);
        }
      }
      return listOfSearchedUser;
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<void> sendMessage({
    required String chatID,
    required String reciepntuserID,
    required String message,
  }) async {
    try {
      final loggedUserId = await getLoggedUserId();
      final res = await supabase.client.from(messageTable).insert({
        'chat_id': chatID,
        'sender_id': loggedUserId,
        'receiver_id': reciepntuserID,
        'message': message,
      });
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<List<MessageModel>?> loadChats({required String chatId}) async {
    try {
      List<MessageModel> messageList = [];
      final getMessagesRequest = await supabase.client
          .from(messageTable)
          .select('sender_id, receiver_id, message, created_at')
          .eq('chat_id', chatId)
          .order('created_at', ascending: true);
      for (var message in getMessagesRequest) {
        final msg = MessageModel(
          senderId: message['sender_id'],
          receiverId: message['receiver_id'],
          message: message['message'],
          messageTime: DateTime.now(),
        );
        messageList.add(msg);
      }
      return messageList;
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<String> createChatRoom({
    required String loggedUSerId,
    required String userIdToChat,
  }) async {
    try {
      final createChatroom =
          await supabase.client.from(chatsTable).insert({
            'participants_id': [loggedUSerId, userIdToChat],
          }).select();

      final chatId = createChatroom.first['chat_id'];

      await addToUsersChats(
        chatId: chatId,
        loggedUserId: loggedUSerId,
        receipintUserID: userIdToChat,
      );
      return chatId;
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }
}




















































/*        if (res2.first['username'].toString().startsWith(searchQuery)) {
          final user = SearchUserModel(
            profileImageUrl: res2.first['profile_image_url'],
            userId: res2.first['user_id'],
            username: res2.first['username'],
          );
          listOfSearchedUser.add(user);
        } */