sealed class HomepageEvent {}

final class FeedsRequested extends HomepageEvent {}

//post events
final class PostEvent extends HomepageEvent {}

class UpdateFeedPostLikeStatus extends HomepageEvent {
  final String postId;
  final bool isLiked;

  UpdateFeedPostLikeStatus({required this.postId, required this.isLiked});
}
