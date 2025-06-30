import 'dart:developer';
import 'dart:io';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/cal_fun.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/core/errors/server_exception.dart';
import 'package:gramify/features/auth/data/datasources/auth_remote_datasource.dart';
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
  Future unfollowRequested({required String userID});

  Future editProfileDetails({
    required String fullname,
    required String username,
    required GenderEnum genderenum,
    required String bio,
  });

  Future<String?> editProfilePicture({required File? profileImageFile});

  Future<bool?> editProfileCheckUsername({
    required String enteredUsername,
    required String currentUsername,
  });
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final Supabase supabase;
  final AuthRemoteDatasource
  authRemoteDatasource; // here this breaks the sepration of concern principle but its temporary and will be resolved later
  ProfileRemoteDatasourceImpl({
    required this.supabase,
    required this.authRemoteDatasource,
  });

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
        bio: response.first['bio'],
        gender: response.first['gender'],
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

      bool isFollowing = await followStatus(userIDforAction: userID);
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
        isPrivate: response.first['is_private'] as bool,
        userPostMap: {},
        userID: userID,
        bio: response.first['bio'],
        gender: response.first['gender'] as String,
      );
    } catch (err, stack) {
      log('getProfilePicture: Error occurred - $err\n$stack');
      return null;
    }
  }

  //
  @override
  Future<bool> followStatus({required String userIDforAction}) async {
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
      return false;
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
      log('profile_remote_datasorce.addtofollowing: Error occurred - $err');
      throw Exception('Failed to fetch follow/unfollow status');
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
      log('profile_remote_datasorce.addtofollowers: Error occurred - $err');
      throw Exception('Failed to fetch follow/unfollow status');
    }
  }

  @override
  Future unfollowRequested({required String userID}) async {
    try {
      final loggedInUserId = await getLoggedUserId();
      {
        final getloggedUserIdfollowingList =
            await supabase.client
                .from(userTable)
                .select('list-of-following')
                .eq('user_id', loggedInUserId)
                .single();

        final List<dynamic> followingList =
            getloggedUserIdfollowingList['list-of-following'];

        followingList.contains(userID) ? followingList.remove(userID) : null;

        await supabase.client
            .from(userTable)
            .update({'list-of-following': followingList})
            .eq('user_id', loggedInUserId);
      }

      {
        final getotherUserfollowerList =
            await supabase.client
                .from(userTable)
                .select('list-of-followers')
                .eq('user_id', userID)
                .single();

        final List<dynamic> followerList =
            getotherUserfollowerList['list-of-followers'];

        followerList.contains(loggedInUserId)
            ? followerList.remove(loggedInUserId)
            : null;

        await supabase.client
            .from(userTable)
            .update({'list-of-followers': followerList})
            .eq('user_id', userID);
      }
    } catch (err) {
      log('profile_remote_datasorce.addtofollowing: Error occurred - $err');
      throw Exception('Failed to fetch follow/unfollow status');
    }
  }

  @override
  Future editProfileDetails({
    required String fullname,
    required String username,
    required GenderEnum genderenum,
    required String bio,
  }) async {
    try {
      final loggedUSerId = await getLoggedUserId();
      await supabase.client
          .from(userTable)
          .update({
            'username': username,
            'fullname': getProperFullname(fullname),
            'gender': genderenum.name,
            'bio': bio,
          })
          .eq('user_id', loggedUSerId);
    } catch (err) {
      log(
        'error in profileRemotedatasourceimpl.editProfileDetails: ${err.toString()}',
      );
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<String?> editProfilePicture({required File? profileImageFile}) async {
    try {
      final loggedUSerId = await getLoggedUserId();
      if (profileImageFile == null) {
        await supabase.client.storage.from(userProfilePictureBucket).remove([
          '$loggedUSerId-profile-picture',
        ]);
        await supabase.client
            .from(userTable)
            .update({'profile_image_url': null})
            .eq('user_id', loggedUSerId);
        return null;
      } else {
        await supabase.client.storage
            .from(userProfilePictureBucket)
            .update('$loggedUSerId-profile-picture', profileImageFile);
        final fileUrl = supabase.client.storage
            .from(userProfilePictureBucket)
            .getPublicUrl('$loggedUSerId-profile-picture');
        await supabase.client
            .from(userTable)
            .update({'profile_image_url': fileUrl})
            .eq('user_id', loggedUSerId);
        return fileUrl;
      }
    } catch (err) {
      log('error in profileremotedatasoource.editProfilePicture');
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<bool?> editProfileCheckUsername({
    required String enteredUsername,
    required String currentUsername,
  }) async {
    if (enteredUsername == currentUsername) {
      return null;
    }
    try {
      final res = await supabase.client
          .from(userTable)
          .select('username')
          .eq('username', enteredUsername);
      if (res.isEmpty) {
        return true;
      } else if (res.first['username'] == enteredUsername) {
        return false;
      }
      return true;
    } catch (err) {
      log('error in auth remnotdatatsourec. checkUserna: ${err.toString()}');
      throw ServerException(message: err.toString());
    }
  }
}
