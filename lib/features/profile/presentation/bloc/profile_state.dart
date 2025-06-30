import 'package:gramify/features/profile/domain/models/other_user_profile_model.dart';
import 'package:gramify/features/profile/domain/models/user_profile_model.dart';

sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileErrorState extends ProfileState {
  final String errorMessage;

  ProfileErrorState({required this.errorMessage});
}

final class ProfileDataFetchSuccessState extends ProfileState {
  final UserProfileModel userdata;

  ProfileDataFetchSuccessState({required this.userdata});
}

final class OtherUserProfileFetchedState extends ProfileState {
  final OtherUserProfileModel userdata;

  OtherUserProfileFetchedState({required this.userdata});
}

final class FollowLoadingState extends ProfileState {}

final class ProfilePictureUploadingState extends ProfileState {}

final class ProfilePictureEditEditSuccessState extends ProfileState {
  final String? newImageUrl;
  ProfilePictureEditEditSuccessState({required this.newImageUrl});
}

final class ProfilePictureEditFailureState extends ProfileState {
  final String errorMessage;
  ProfilePictureEditFailureState({required this.errorMessage});
}

final class ProfileInfoEditLoadingState extends ProfileState {}

final class ProfileInfoEditSuccessState extends ProfileState {}

final class ProfileInfoEditFailureState extends ProfileState {
  final String errorMessage;
  ProfileInfoEditFailureState({required this.errorMessage});
}

final class UsernameCheckedState extends ProfileState {
  final bool? isAvailable;
  UsernameCheckedState({required this.isAvailable});
}
