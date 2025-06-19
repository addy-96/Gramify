class PostModel {
  final String postId;
  final DateTime createdAt;
  final String posterUserId;
  final String caption;
  final String imageUrl;
  final int likesCount;
  final String username;

  PostModel({
    required this.postId,
    required this.createdAt,
    required this.posterUserId,
    required this.caption,
    required this.likesCount,
    required this.imageUrl,
    required this.username,
  });
}
