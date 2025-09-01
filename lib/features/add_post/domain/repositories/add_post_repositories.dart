import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:photo_manager/photo_manager.dart';

abstract interface class AddPostRepositories {
  Future<Either<Failure, List<AssetPathEntity>?>> loadAlbumbs(final RequestType requestType);
  Future<Either<Failure, List<AssetEntity>?>> loadAssets(final AssetPathEntity selectedAlbumName);
  Future<Either<Failure, void>> uploadPost({required File postImage, required String? postCaption});
  Future<Either<Failure, void>> addToStory({required File storyImage});
}
