import 'dart:developer';
import 'dart:io';

import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

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
  final Uuid uuid;
  AddPostDataSourceImpl({required this.supabase, required this.uuid});

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
    } catch (err) {
      log(err.toString());
    }
  }
}
