class CommentModel {
  final String postId;
  final String commentId;
  final String comment;
  final DateTime commentTime;
  final String commenterUserId;
  final String commenterUsername;
  final String? commentProfileImageUrl;

  CommentModel({
    required this.postId,
    required this.commentId,
    required this.comment,
    required this.commentTime,
    required this.commenterUserId,
    required this.commenterUsername,
    required this.commentProfileImageUrl,
  });
}
