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

  CommentModel copyWith({
    String? postId,
    String? commentId,
    String? comment,
    DateTime? commentTime,
    String? commenterUserId,
    String? commenterUsername,
    String? commentProfileImageUrl,
  }) {
    return CommentModel(
      postId: this.postId,
      commentId: this.commentId,
      comment: this.comment,
      commentTime: this.commentTime,
      commenterUserId: this.commenterUserId,
      commenterUsername: this.commenterUsername,
      commentProfileImageUrl: commentProfileImageUrl,
    );
  }
}
