import 'package:gramify/features/home/domain/models/comment_model.dart';

sealed class PostState {}

final class PostUiInitialState extends PostState {}

final class PostErrorState extends PostState {
  final String errorMessage;
  PostErrorState({required this.errorMessage});
}

final class PostLikeStatusState extends PostState {}

final class LoadingCommentsState extends PostState {}

final class CommentsFetchedState extends PostState {
  final List<CommentModel> commentList;
  CommentsFetchedState({required this.commentList});
}

final class CommentedState extends PostState {}
