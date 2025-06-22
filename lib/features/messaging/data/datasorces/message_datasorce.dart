import 'dart:developer';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/core/errors/server_exception.dart';
import 'package:gramify/features/messaging/domain/model/message_model.dart';
import 'package:gramify/features/messaging/domain/model/search_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class MessageDatasorce {
  Future<List<SearchUserModel>?> loadUserPrevChats();

  Future<List<SearchUserModel>> searchUserToChat({required String searchQuery});

  Future<String> setChatRoom({required String userIdToChat});

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
    required String reciepntuserID,
    required String message,
  });

  Stream<List<MessageModel>> loadChatsStream({required String chatId});

  Future<String> createChatRoom({
    required String loggedUSerId,
    required String userIdToChat,
  });
}

class MessageDataSourceImpl implements MessageDatasorce {
  MessageDataSourceImpl({required this.supabase});
  final Supabase supabase;

  @override
  Future<String> setChatRoom({required String userIdToChat}) async {
    try {
      final loggedUserId = await getLoggedUserId();

      final checkChatId = await getChatId(
        loggedUserId: loggedUserId,
        receipintUserID: userIdToChat,
      );

      if (checkChatId != null) {
        return checkChatId;
      } else {
        final chatId = createChatRoom(
          loggedUSerId: loggedUserId,
          userIdToChat: userIdToChat,
        );
        return chatId;
      }
    } catch (err) {
      log('Error in messagedatasource.swtchatroom : ${err.toString()}');
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<String?> getChatId({
    required String loggedUserId,
    required String receipintUserID,
  }) async {
    log('logged user');
    try {
      final res = await supabase.client
          .from(chatsTable)
          .select('chat_id')
          .or(
            'and(participant_1.eq.$loggedUserId,participant_2.eq.$receipintUserID),and(participant_1.eq.$receipintUserID,participant_2.eq.$loggedUserId)',
          );
      if (res.isEmpty) {
        return null;
      }
      return res.first['chat_id'];
    } catch (err) {
      log('Error in messagedatasource.getchatid : ${err.toString()}');
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
      final loggedUsrDat = await supabase.client
          .from(userTable)
          .select('chats')
          .eq('user_id', loggedUserId);

      final List<dynamic> listOfLoggedChats = loggedUsrDat.first['chats'] ?? [];

      if (!listOfLoggedChats.contains(chatId)) {
        listOfLoggedChats.add(chatId);
      }

      await supabase.client
          .from(userTable)
          .update({'chats': listOfLoggedChats})
          .eq('user_id', loggedUserId);

      //other user data modify
      final recepintUsrDat = await supabase.client
          .from(userTable)
          .select('chats')
          .eq('user_id', receipintUserID);

      final List<dynamic> listOfRecieverChats =
          recepintUsrDat.first['chats'] ?? [];

      if (!listOfRecieverChats.contains(chatId)) {
        listOfRecieverChats.add(chatId);
      }

      await supabase.client
          .from(userTable)
          .update({'chats': listOfRecieverChats})
          .eq('user_id', receipintUserID);
    } catch (err) {
      log('Error in messagedatasource.addtouserchat : ${err.toString()}');
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<List<SearchUserModel>> searchUserToChat({
    required String searchQuery,
  }) async {
    try {
      final loggedUserId = await getLoggedUserId();

      final List<SearchUserModel> listOfSearchedUser = [];

      final getFollowerList = await supabase.client
          .from(userTable)
          .select('list-of-followers, list-of-following')
          .eq('user_id', loggedUserId);

      final List<dynamic> listOfFollowers =
          getFollowerList.first['list-of-followers'] ?? [];
      final List<dynamic> listOfFollowing =
          getFollowerList.first['list-of-following'] ?? [];

      Set<dynamic> listOfAllUSer = {...listOfFollowers, ...listOfFollowing};

      for (var userid in listOfAllUSer) {
        final res2 = await supabase.client
            .from(userTable)
            .select('username, profile_image_url, user_id')
            .eq('user_id', userid);

        final username = res2.first['username'] as String;

        var chatID = await getChatId(
          loggedUserId: loggedUserId,
          receipintUserID: res2.first['user_id'],
        );

        chatID ??= await createChatRoom(
          loggedUSerId: loggedUserId,
          userIdToChat: res2.first['user_id'],
        );

        if (username.startsWith(searchQuery)) {
          final user = SearchUserModel(
            profileImageUrl: res2.first['profile_image_url'],
            userId: res2.first['user_id'],
            username: res2.first['username'],
            chatID: chatID,
          );

          listOfSearchedUser.add(user);
        }
      }
      return listOfSearchedUser;
    } catch (err) {
      log('Error in messagedatasource.searchusertochat : ${err.toString()}');

      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<void> sendMessage({
    required String reciepntuserID,
    required String message,
  }) async {
    try {
      final loggedUserId = await getLoggedUserId();
      final getChatID = await getChatId(
        loggedUserId: loggedUserId,
        receipintUserID: reciepntuserID,
      );
      await supabase.client.from(messageTable).insert({
        'chat_id': getChatID,
        'sender_id': loggedUserId,
        'receiver_id': reciepntuserID,
        'message': message,
      });
    } catch (err) {
      log('Error in messagedatasource.searchusertochat : ${err.toString()}');

      throw ServerException(message: err.toString());
    }
  }

  @override
  Stream<List<MessageModel>> loadChatsStream({required String chatId}) {
    log('calllllllllllllllllllled');
    return supabase.client
        .from(messageTable)
        .stream(
          primaryKey: ['chat_id'],
        ) // Replace 'id' with your actual primary key column
        .eq('chat_id', chatId)
        .order('created_at', ascending: true)
        .map((data) {
          return data.map((message) {
            log(message['message']);
            return MessageModel(
              senderId: message['sender_id'],
              receiverId: message['receiver_id'],
              message: message['message'],
              messageTime: DateTime.parse(message['created_at']),
            );
          }).toList();
        });
  }

  @override
  Future<String> createChatRoom({
    required String loggedUSerId,
    required String userIdToChat,
  }) async {
    try {
      final addchatIdRequest =
          await supabase.client.from(chatsTable).insert({
            'participant_1': loggedUSerId,
            'participant_2': userIdToChat,
          }).select();

      await addToUsersChats(
        chatId: addchatIdRequest.first['chat_id'],
        loggedUserId: loggedUSerId,
        receipintUserID: userIdToChat,
      );
      return addchatIdRequest.first['chat_id'];
    } catch (err) {
      log('Error in messagedatasource.createchatroom : ${err.toString()}');
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<List<SearchUserModel>?> loadUserPrevChats() async {
    final loggedUSerID = await getLoggedUserId();
    try {
      final listOfChatId = await supabase.client
          .from(userTable)
          .select('chats')
          .eq('user_id', loggedUSerID);

      if (listOfChatId.isEmpty) {
        return [];
      }
      for (var item in listOfChatId) {}
    } catch (err) {}
    return null;
  }
}




















































/*        if (res2.first['username'].toString().startsWith(searchQuery)) {
          final user = SearchUserModel(
            profileImageUrl: res2.first['profile_image_url'],
            userId: res2.first['user_id'],
            username: res2.first['username'],
          );
          listOfSearchedUser.add(user);
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
          messageTime: DateTime.now(), // to add the actual time
        );
        messageList.add(msg);
      }
      return messageList;
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }
        */