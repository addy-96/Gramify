import 'dart:io';

import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/core/errors/local_mobile_exception.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract interface class AddPostDataSource {
  Future<List<AssetPathEntity>?> loadAlbums(RequestType requestType);

  Future<List<AssetEntity>?> loadAssests(AssetPathEntity selectedAlbumName);

  Future<void> uploadPost({
    required File selectedImageFile,
    required String? postCaption,
  });

  Future addToFeed({required String postID});
}

class AddPostDataSourceImpl implements AddPostDataSource {
  final Supabase supabase;
  final Uuid uuid;
  AddPostDataSourceImpl({required this.supabase, required this.uuid});

  @override
  Future<List<AssetPathEntity>?> loadAlbums(RequestType requestType) async {
    try {
      List<AssetPathEntity> albumList = [];
      albumList = await PhotoManager.getAssetPathList(type: requestType);
      return albumList;
    } catch (err) {
      throw LocalMobileException(message: err.toString());
    }
  }

  @override
  Future<List<AssetEntity>?> loadAssests(
    AssetPathEntity selectedAlbumName,
  ) async {
    try {
      List<AssetEntity> assetList = await selectedAlbumName.getAssetListRange(
        start: 0,
        end: await selectedAlbumName.assetCountAsync,
      );
      return assetList;
    } catch (err) {
      throw LocalMobileException(message: err.toString());
    }
  }

  @override
  Future uploadPost({
    required File selectedImageFile,
    required String? postCaption,
  }) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      final ref = supabase.client.from(userPostTable);
      final createdPostId = uuid.v4();
      await ref.insert({
        'post_id': createdPostId,
        'posted_by': userId,
        'text_content': postCaption,
        'likes_count': 0,
        'image_url': '.',
      }).select();

      final postbucketRef = supabase.client.storage.from(postPictureBucket);
      await postbucketRef.upload(createdPostId.toString(), selectedImageFile);
      final postImageUrl = postbucketRef.getPublicUrl(createdPostId);
      await ref
          .update({'image_url': postImageUrl})
          .eq('post_id', createdPostId);

      await addToFeed(postID: createdPostId);
    } catch (err) {
      throw LocalMobileException(message: err.toString());
    }
  }

  @override
  Future addToFeed({required String postID}) async {
    try {
      final loggedUserID = await getLoggedUserId();

      final supabase = Supabase.instance;

      final res = await supabase.client
          .from(userTable)
          .select('list-of-followers')
          .eq('user_id', loggedUserID);

      final List<dynamic> followerList = res.first['list-of-followers'] ?? [];

      for (var item in followerList) {
        final response = await supabase.client
            .from(userTable)
            .select('feed')
            .eq('user_id', item);

        final List<dynamic> feedLIst = response.first['feed'] ?? [];

        if (!feedLIst.contains(postID)) {
          feedLIst.add(postID);
        }

        await supabase.client
            .from(userTable)
            .update({'feed': feedLIst})
            .eq('user_id', item);
      }
    } catch (err) {
      throw LocalMobileException(message: err.toString());
    }
  }
}
