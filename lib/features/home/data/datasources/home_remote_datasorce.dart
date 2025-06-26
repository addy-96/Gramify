import 'dart:developer';

import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/core/errors/server_exception.dart';
import 'package:gramify/features/home/domain/models/comment_model.dart';
import 'package:gramify/features/home/domain/models/post_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class HomeRemoteDatasorce {
  Future<List<PostModel>> loadFeeds();
  Future<void> postLikeAction({required String postId});
  Future<List<CommentModel>> loadComments({required String postId});
  Future<void> addComment({required String postId, required String comment});
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasorce {
  final Supabase supabase;

  HomeRemoteDatasourceImpl({required this.supabase});
  @override
  Future<List<PostModel>> loadFeeds() async {
    try {
      final userId = await getLoggedUserId();
      final res =
          await supabase.client
              .from(userTable)
              .select('feed')
              .eq('user_id', userId)
              .single();

      final List<dynamic> feedList = res['feed'] ?? [];

      final List<PostModel> postList = [];
      for (var postId in feedList) {
        final post =
            await supabase.client
                .from(userPostTable)
                .select()
                .eq('post_id', postId)
                .single();

        final response =
            await supabase.client
                .from(userTable)
                .select('username, profile_image_url, fullname')
                .eq('user_id', post['posted_by'])
                .single();

        final username = response['username'];
        final fullname = response['fullname'];
        final profileImageUrl = response['profile_image_url'];
        final List<dynamic> likedby = post['liked_by'] ?? [];
        final getCommentCount = await supabase.client
            .from(commentsTable)
            .count()
            .eq('post_id', post['post_id']);

        postList.add(
          PostModel(
            postId: post['post_id'],
            createdAt: DateTime.parse(post['created_at']),
            posterUserId: post['posted_by'],
            caption: post['text_content'],
            likesCount: likedby.length,
            postimageUrl: post['image_url'],
            username: username,
            posterProfileImageUrl: profileImageUrl,
            isLiked: likedby.contains(userId),
            fullname: fullname,
            commentsCount: getCommentCount,
          ),
        );
      }
      return postList;
    } catch (err) {
      log('error in home remote datasoource.loadfeeds : ${err.toString()}');
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<void> postLikeAction({required String postId}) async {
    try {
      final userId = await getLoggedUserId();
      final res =
          await supabase.client
              .from(userPostTable)
              .select('liked_by')
              .eq('post_id', postId)
              .single();

      final List<dynamic> likeduserlist = res['liked_by'] ?? [];
      if (likeduserlist.contains(userId)) {
        likeduserlist.remove(userId);
      } else if (!likeduserlist.contains(userId)) {
        likeduserlist.add(userId);
      }
      await supabase.client
          .from(userPostTable)
          .update({'liked_by': likeduserlist})
          .eq('post_id', postId);
    } catch (err) {
      log('error in Homeremotedatasource.postLiked : ${err.toString()}');
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<List<CommentModel>> loadComments({required String postId}) async {
    try {
      final List<CommentModel> commentList = [];
      final commentData = await supabase.client
          .from(commentsTable)
          .select('comment_id, created_at, commentor_id,comment')
          .eq('post_id', postId)
          .order('created_at', ascending: false);

      if (commentData.isEmpty) {
        return [];
      }

      for (var item in commentData) {
        final userdata =
            await supabase.client
                .from(userTable)
                .select('username, profile_image_url')
                .eq('user_id', item['commentor_id'])
                .single();

        final comment = CommentModel(
          postId: postId,
          commentId: item['comment_id'],
          comment: item['comment'],
          commentTime: DateTime.parse(item['created_at']),
          commenterUserId: item['commentor_id'],
          commenterUsername: userdata['username'],
          commentProfileImageUrl: userdata['profile_image_url'],
        );

        commentList.add(comment);
      }
      return commentList;
    } catch (err) {
      log('error in Homeremotedatasource.loadcomments : ${err.toString()}');
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<void> addComment({
    required String postId,
    required String comment,
  }) async {
    try {
      final loggedUserId = await getLoggedUserId();
      await supabase.client.from(commentsTable).insert({
        'commentor_id': loggedUserId,
        'comment': comment,
        'post_id': postId,
      });
    } catch (err) {
      log('error in Homeremotedatasource.addcomment : ${err.toString()}');
      throw ServerException(message: err.toString());
    }
  }
}
