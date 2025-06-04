import 'dart:developer';
import 'dart:io';

import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AddPostDataSource {
  Future<List<AssetPathEntity>?> loadAlbums(RequestType requestType);

  Future<List<AssetEntity>?> loadAssests(AssetPathEntity selectedAlbumName);

  Future uploadPost({
    required File selectedImageFile,
    required String? postCaption,
  });
}

class AddPostDataSourceImpl implements AddPostDataSource {
  final Supabase supabase;
  AddPostDataSourceImpl({required this.supabase});

  @override
  Future<List<AssetPathEntity>?> loadAlbums(RequestType requestType) async {
    try {
      List<AssetPathEntity> albumList = [];
      albumList = await PhotoManager.getAssetPathList(type: requestType);
      return albumList;
    } catch (err) {
      log('error in getting album list, check loadAlbums() : $err');
      return null;
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
      log('lenght');
      log(assetList[0].relativePath!);
      return assetList;
    } catch (err) {
      log('error in getting loadasset, check loadAssets() : $err');
      return null;
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

      final response =
          await ref.insert({
            'posted_by': userId,
            'text_content': postCaption,
            'likes_count': 0,
          }).select();

      final insertedPost = response.first;
      final postId = insertedPost['post_id'];
      final postbucketRef = supabase.client.storage.from(postPictureBucket);
      await postbucketRef.upload(postId, selectedImageFile);
      final postIMageUrl = postbucketRef.getPublicUrl(postId);
      await ref.update({'image_url': postIMageUrl});
    } catch (err) {
      log(err.toString());
      return null;
    }
  }
}
