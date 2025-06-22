import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/home/data/datasources/home_remote_datasorce.dart';
import 'package:gramify/features/home/domain/models/comment_model.dart';
import 'package:gramify/features/home/domain/models/post_model.dart';
import 'package:gramify/features/home/domain/repositories/home_repositories.dart';

class HomeRepsitoriedImpl implements HomeRepositories {
  final HomeRemoteDatasorce homeRemoteDatasorce;

  HomeRepsitoriedImpl({required this.homeRemoteDatasorce});
  @override
  Future<Either<Failure, List<PostModel>>> loadUserFeeds() async {
    try {
      final res = await homeRemoteDatasorce.loadFeeds();
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> postLikeAction({required String postID}) async {
    try {
      final res = await homeRemoteDatasorce.postLikeAction(postId: postID);
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> loadComments({
    required String postID,
  }) async {
    try {
      final res = await homeRemoteDatasorce.loadComments(postId: postID);
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addComment({
    required String postID,
    required String comment,
  }) async {
    try {
      final res = await homeRemoteDatasorce.addComment(
        postId: postID,
        comment: comment,
      );
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }
}
