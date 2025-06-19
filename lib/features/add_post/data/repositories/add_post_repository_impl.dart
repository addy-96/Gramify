import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:gramify/features/add_post/data/datasources/add_post_datasource.dart';
import 'package:gramify/features/add_post/domain/repositories/add_post_repositories.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPostRepositoryImpl implements AddPostRepositories {
  AddPostRepositoryImpl({required this.addPostDatasource});

  final AddPostDataSource addPostDatasource;
  @override
  Future<Either<Failure, List<AssetPathEntity>?>> loadAlbumbs(
    RequestType requestType,
  ) async {
    try {
      final res = await addPostDatasource.loadAlbums(requestType);
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AssetEntity>?>> loadAssets(
    AssetPathEntity selectedAlbumName,
  ) async {
    try {
      final res = await addPostDatasource.loadAssests(selectedAlbumName);
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> uploadPost({
    required File postImage,
    required String? postCaption,
  }) async {
    try {
      final res = await addPostDatasource.uploadPost(
        selectedImageFile: postImage,
        postCaption: postCaption,
      );
      return right(null);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }
}
