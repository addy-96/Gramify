sealed class PostEvent {}

final class PostLikeActionRequested extends PostEvent {
  final String postId;

  PostLikeActionRequested({required this.postId});
}

final class CommentsRequeested extends PostEvent {
  final String postId;
  CommentsRequeested({required this.postId});
}

final class AddCommentsRequested extends PostEvent {
  final String postId;
  final String comment;
  AddCommentsRequested({required this.postId, required this.comment});
}
