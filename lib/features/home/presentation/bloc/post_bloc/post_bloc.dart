import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:gramify/features/home/domain/models/comment_model.dart';
import 'package:gramify/features/home/domain/repositories/home_repositories.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_state.dart';
import 'package:gramify/features/home/presentation/bloc/post_bloc/post_event.dart';
import 'package:gramify/features/home/presentation/bloc/post_bloc/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final HomeRepositories homeRepositories;

  PostBloc({required this.homeRepositories}) : super(PostUiInitialState()) {
    on<PostLikeActionRequested>(_onPostLikeActionRequested);

    //
    on<CommentsRequeested>(_onCommentsRequeested);

    //
    on<AddCommentsRequested>(_onAddCommentsRequested);
  }

  void _onPostLikeActionRequested(
    PostLikeActionRequested event,
    Emitter<PostState> emit,
  ) async {
    try {
      final res = await homeRepositories.postLikeAction(postID: event.postId);
    } catch (err) {
      emit(PostErrorState(errorMessage: err.toString()));
    }
  }

  void _onCommentsRequeested(
    CommentsRequeested event,
    Emitter<PostState> emit,
  ) async {
    try {
      emit(LoadingCommentsState());
      final res = await homeRepositories.loadComments(postID: event.postId);
      res.fold(
        (l) => emit(PostErrorState(errorMessage: l.message)),
        (r) => emit(CommentsFetchedState(commentList: r)),
      );
    } catch (err) {
      emit(PostErrorState(errorMessage: err.toString()));
    }
  }

  _onAddCommentsRequested(
    AddCommentsRequested event,
    Emitter<PostState> emit,
  ) async {
    try {
      final loggedUSerId = await getLoggedUserId();
      final res = await homeRepositories.addComment(
        postID: event.postId,
        comment: event.comment,
      );
      final currentState = state as CommentsFetchedState;
      final List<CommentModel> commentList = currentState.commentList;
      commentList.add(
        CommentModel(
          postId: commentList.last.postId,
          commentId: commentList.last.commentId,
          comment: event.comment,
          commentTime: DateTime.now(),
          commenterUserId: loggedUSerId,
          commenterUsername:
              'xyz', // here to add the actual username after chaching
          commentProfileImageUrl: null, //here too
        ),
      );
      res.fold((l) => emit(PostErrorState(errorMessage: l.message)), (r) {
        emit(CommentsFetchedState(commentList: commentList));
      });
    } catch (err) {
      emit(PostErrorState(errorMessage: err.toString()));
    }
  }
}
