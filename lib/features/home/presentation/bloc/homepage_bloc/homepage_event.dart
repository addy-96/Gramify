sealed class HomepageEvent {}

final class FeedsRequested extends HomepageEvent {}

//post events

class UpdateFeedPostLikeStatus extends HomepageEvent {
  final String postId;
  final bool isLiked;

  UpdateFeedPostLikeStatus({required this.postId, required this.isLiked});
}
