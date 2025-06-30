import 'dart:io';

import 'package:gramify/core/common/shared_attri/constrants.dart';
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

final class EditProfileInfoRequested extends ProfileEvent {
  final String fullname;
  final String username;
  final GenderEnum genderenum;
  final String bio;

  EditProfileInfoRequested({
    required this.fullname,
    required this.username,
    required this.genderenum,
    required this.bio,
  });
}

final class ProfilePictureEditRequested extends ProfileEvent {
  final File? profilePicture;
  ProfilePictureEditRequested({required this.profilePicture});
}

final class CheckUsernameRequested extends ProfileEvent {
  final String enteredUSername;
  final String currentUSername;
  CheckUsernameRequested({
    required this.enteredUSername,
    required this.currentUSername,
  });
}
