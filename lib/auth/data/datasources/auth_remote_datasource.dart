import 'dart:developer';
import 'dart:io';

import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/errors/server_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> signUserUp({
    required String username,
    required String email,
    required String password,
    required String fullname,
    required String? profileImageUrl,
  });

  Future<String> logUserIn({required String email, required String password});

  Future<void> logUserOut();

  Future<void> storeUserData({
    required String email,
    required String username,
    required String userId,
    required String fullname,
    required String? profileImageUrl,
  });

  Future<void> uploadProfilePicture({
    required File profileImage,
    required String username,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl({required this.supabase});

  final Supabase supabase;

  @override
  Future<String> logUserIn({
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabase.client.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (res.user == null) {
        throw ServerException(message: 'Authentication Failed!');
      }
      log('${res.user!.id} Signed Up');
      return res.user!.id;
    } on ServerException catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<void> logUserOut() async {
    try {
      await supabase.client.auth.signOut();
      log('user logged out!');
    } catch (err) {
      log(err.toString());
    }
  }

  @override
  Future<String> signUserUp({
    required String username,
    required String email,
    required String password,
    required String fullname,
    required String? profileImageUrl,
  }) async {
    try {
      final res = await supabase.client.auth.signUp(
        email: email,
        password: password,
      );
      if (res.user == null) {
        throw ServerException(message: 'Failed! Server Authentication Error!');
      }

      log('${res.user!.id} Signed Up');

      await storeUserData(
        email: email,
        username: username,
        userId: res.user!.id,
        fullname: fullname,
        profileImageUrl: profileImageUrl,
      );

      return res.user!.id;
    } on ServerException catch (err) {
      throw ServerException(message: err.message);
    }
  }

  @override
  Future<void> storeUserData({
    required String email,
    required String username,
    required String userId,
    required String fullname,
    required String? profileImageUrl,
  }) async {
    try {
      await supabase.client.from(userTable).insert({
        'email': email,
        'username': username,
        'user_id': userId,
        'fullname': fullname,
        'profile_image_url': profileImageUrl,
      });
    } catch (err) {
      log(err.toString());
    }
  }

  @override
  Future<void> uploadProfilePicture({
    required File profileImage,
    required String username,
  }) async {
    try {
      final ref = supabase.client.storage.from(userProfilePictureBucket);

      await ref.upload('$username-profile-picture', profileImage);
      final userID = supabase.client.auth.currentUser!.id;
      final profileImageUrl = ref.getPublicUrl('$username-profile-picture');
      await supabase.client
          .from('users_table')
          .update({'profile_image_url': profileImageUrl})
          .eq('user_id', userID)
          .select();
    } on ServerException catch (err) {
      throw ServerException(message: err.toString());
    }
  }
}
