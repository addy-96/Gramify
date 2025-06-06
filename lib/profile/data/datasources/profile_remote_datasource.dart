import 'dart:developer';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/profile/domain/models/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDatasource {
  Future<UserProfileModel?> getProfileData({required String? userID});
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final Supabase supabase;
  ProfileRemoteDatasourceImpl({required this.supabase});

  @override
  Future<UserProfileModel?> getProfileData({required String? userID}) async {
    try {
      userID ??= await getLoggedUserId();
      final response = await supabase.client
          .from(userTable)
          .select()
          .eq('user_id', userID);
      return UserProfileModel(
        username: response.first['username'],
        fullname: response.first['fullname'],
        profileImageUrl: response.first['profile_image_url'],
        followersCount: response.first['followers'],
        followingCount: response.first['following'],
      );
    } catch (err, stack) {
      log('getProfilePicture: Error occurred - $err\n$stack');
      return null;
    }
  }
}
