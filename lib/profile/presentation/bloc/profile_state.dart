import 'package:gramify/profile/domain/models/user_profile_model.dart';

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
