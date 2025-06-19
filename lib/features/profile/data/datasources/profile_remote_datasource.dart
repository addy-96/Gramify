import 'dart:developer';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/features/profile/domain/models/other_user_profile_model.dart';
import 'package:gramify/features/profile/domain/models/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDatasource {
  Future<UserProfileModel?> getProfileData();
  Future<UserProfileModel?> getProfileDataOfOtherUser({required String userID});
  Future<bool?> followStatus({required String userIDforAction});
  Future followRequested({required String userID});
  Future addToFollowing({
    required String followedID,
    required String followerID,
  });
  Future addToFollowers({
    required String followerID,
    required String followedID,
  });
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final Supabase supabase;
  ProfileRemoteDatasourceImpl({required this.supabase});

  //
  @override
  Future<UserProfileModel?> getProfileData() async {
    try {
      final userID = await getLoggedUserId();
      final response = await supabase.client
          .from(userTable)
          .select()
          .eq('user_id', userID);

      final userPostIdAndUrl = await supabase.client
          .from(userPostTable)
          .select('post_id , image_url')
          .eq('posted_by', userID);

      final List<dynamic> listOfFollowers =
          response.first['list-of-followers'] ?? [];
      final List<dynamic> listOfFollowing =
          response.first['list-of-following'] ?? [];
      Map<String, String> postMap = {};

      for (var entry in userPostIdAndUrl) {
        postMap[entry['post_id']] = entry['image_url'];
      }

      return UserProfileModel(
        username: response.first['username'],
        fullname: response.first['fullname'],
        profileImageUrl: response.first['profile_image_url'],
        followersCount: listOfFollowers.length,
        followingCount: listOfFollowing.length,
        userPostMap: postMap,
      );
    } catch (err, stack) {
      log('getProfilePicture: Error occurred - $err\n$stack');
      return null;
    }
  }

  //
  @override
  Future<OtherUserProfileModel?> getProfileDataOfOtherUser({
    required String userID,
  }) async {
    try {
      final response = await supabase.client
          .from(userTable)
          .select()
          .eq('user_id', userID);

      bool? isFollowing = await followStatus(userIDforAction: userID);
      final List<dynamic> listOfFollowers =
          response.first['list-of-followers'] ?? [];
      final List<dynamic> listOfFollowing =
          response.first['list-of-following'] ?? [];
      return OtherUserProfileModel(
        username: response.first['username'],
        fullname: response.first['fullname'],
        profileImageUrl: response.first['profile_image_url'],
        followersCount: listOfFollowers.length,
        followingCount: listOfFollowing.length,
        isFollowing: isFollowing,
        userPostMap: {},
      );
    } catch (err, stack) {
      log('getProfilePicture: Error occurred - $err\n$stack');
      return null;
    }
  }

  //
  @override
  Future<bool?> followStatus({required String userIDforAction}) async {
    try {
      final userid = await getLoggedUserId();

      final user =
          await supabase.client
              .from(userTable)
              .select('list-of-followers')
              .eq('user_id', userIDforAction)
              .single();

      List<dynamic> followers = user['list-of-followers'] ?? [];
      if (!followers.contains(userid)) {
        return false;
      } else if (followers.contains(userid)) {
        return true;
      }
      return null;
    } catch (err, stack) {
      log('getFollowUnfollowStatus: Error occurred - $err\n$stack');
      throw Exception('Failed to fetch follow/unfollow status');
    }
  }

  //
  @override
  Future followRequested({required String userID}) async {
    try {
      final loggedInUserID = await getLoggedUserId();

      await addToFollowing(followedID: userID, followerID: loggedInUserID);

      await addToFollowers(followerID: loggedInUserID, followedID: userID);
    } catch (err) {
      log(err.toString());
    }
  }

  //
  @override
  Future addToFollowing({
    required String followedID,
    required String followerID,
  }) async {
    try {
      final followerData = await supabase.client
          .from(userTable)
          .select('list-of-following')
          .eq('user_id', followerID);

      final List<dynamic> listOfFollowing =
          followerData.first['list-of-following'] ?? [];

      listOfFollowing.add(followedID);

      await supabase.client
          .from(userTable)
          .update({'list-of-following': listOfFollowing})
          .eq('user_id', followerID);
    } catch (err) {
      log(err.toString());
    }
  }

  //
  @override
  Future addToFollowers({
    required String followerID,
    required String followedID,
  }) async {
    try {
      final followedData = await supabase.client
          .from(userTable)
          .select('list-of-followers')
          .eq('user_id', followedID);

      final List<dynamic> listOfFollowers =
          followedData.first['list-of-followers'] ?? [];

      listOfFollowers.add(followerID);

      await supabase.client
          .from(userTable)
          .update({'list-of-followers': listOfFollowers})
          .eq('user_id', followedID);
    } catch (err) {
      log(err.toString());
    }
  }
}
