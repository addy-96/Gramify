class PostModel {
  final String postId;
  final DateTime createdAt;
  final String posterUserId;
  final String? posterProfileImageUrl;
  final String caption;
  final String postimageUrl;
  final int likesCount;
  final int commentsCount;
  final String username;
  final String fullname;
  final bool isLiked; // made final

  PostModel({
    required this.commentsCount,
    required this.isLiked,
    required this.posterProfileImageUrl,
    required this.postId,
    required this.createdAt,
    required this.posterUserId,
    required this.caption,
    required this.likesCount,
    required this.postimageUrl,
    required this.username,
    required this.fullname,
  });

  PostModel copyWith({
    String? postId,
    DateTime? createdAt,
    String? posterUserId,
    String? posterProfileImageUrl,
    String? caption,
    String? postimageUrl,
    int? likesCount,
    int? commentsCount,
    String? username,
    String? fullname,
    bool? isLiked,
  }) {
    return PostModel(
      commentsCount: commentsCount ?? this.commentsCount,
      postId: postId ?? this.postId,
      createdAt: createdAt ?? this.createdAt,
      posterUserId: posterUserId ?? this.posterUserId,
      posterProfileImageUrl:
          posterProfileImageUrl ?? this.posterProfileImageUrl,
      caption: caption ?? this.caption,
      postimageUrl: postimageUrl ?? this.postimageUrl,
      likesCount: likesCount ?? this.likesCount,
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
