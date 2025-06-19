import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/core/errors/server_exception.dart';
import 'package:gramify/features/home/domain/models/post_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class HomeRemoteDatasorce {
  Future<List<PostModel>> loadFeeds();
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
                .select('username')
                .eq('user_id', post['posted_by'])
                .single();

        final username = response['username'];
        postList.add(
          PostModel(
            postId: post['post_id'],
            createdAt: DateTime.parse(post['created_at']),
            posterUserId: post['posted_by'],
            caption: post['text_content'],
            likesCount: post['likes_count'],
            imageUrl: post['image_url'],
            username: username,
          ),
        );
      }
      return postList;
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }
}
