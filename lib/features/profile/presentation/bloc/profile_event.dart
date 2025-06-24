import 'package:gramify/features/profile/domain/models/other_user_profile_model.dart';

sealed class ProfileEvent {}

final class ProfileDataRequested extends ProfileEvent {}

final class ProfileOfOtherUserRequested extends ProfileEvent {
  final String userIDforAction;

  ProfileOfOtherUserRequested({required this.userIDforAction});
}

final class FollowRequested extends ProfileEvent {
  final OtherUserProfileModel otherUserProfileModel;

  FollowRequested({required this.otherUserProfileModel});
}

final class UnfollowRequested extends ProfileEvent {
  final OtherUserProfileModel otherUserProfileModel;
  UnfollowRequested({required this.otherUserProfileModel});
}
