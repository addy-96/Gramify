import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/home/domain/models/comment_model.dart';
import 'package:gramify/features/home/domain/models/post_model.dart';

abstract interface class HomeRepositories {
  Future<Either<Failure, List<PostModel>>> loadUserFeeds();
  Future<Either<Failure, void>> postLikeAction({required String postID});
  Future<Either<Failure, List<CommentModel>>> loadComments({required String postID});
  Future<Either<Failure, void>> addComment({required String postID, required String comment});
  Future<Either<Failure, void>> addToStory({required File stooryImage});
  
}
