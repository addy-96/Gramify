sealed class ProfileEvent {}

final class ProfileDataRequested extends ProfileEvent {}

final class ProfileOfOtherUserRequested extends ProfileEvent {
  final String userIDforAction;

  ProfileOfOtherUserRequested({required this.userIDforAction});
}

final class FollowRequested extends ProfileEvent {
  final String followedId;

  FollowRequested({required this.followedId});
}
