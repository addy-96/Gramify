import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/profile/domain/models/other_user_profile_model.dart';
import 'package:gramify/features/profile/domain/repositories/profile_repository.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_event.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository})
    : super(ProfileInitialState()) {
    //
    on<ProfileDataRequested>(_onProfileDataRequested);

    //
    on<ProfileOfOtherUserRequested>(_onProfileOfOtherUserRequested);

    //
    on<FollowRequested>(_onFollowRequested);

    //
    on<UnfollowRequested>(_onUnfollowRequested);
  }

  _onProfileDataRequested(
    ProfileDataRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    try {
      final res = await profileRepository.getProfileData();
      res.fold((l) => emit(ProfileErrorState(errorMessage: l.message)), (r) {
        if (r == null) {
          emit(
            ProfileErrorState(errorMessage: 'profile user data model is null'),
          );
          return;
        }
        emit(ProfileDataFetchSuccessState(userdata: r));
      });
    } catch (err) {
      emit(ProfileErrorState(errorMessage: err.toString()));
    }
  }

  _onProfileOfOtherUserRequested(
    ProfileOfOtherUserRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    try {
      final res = await profileRepository.getOtherUserProfileData(
        userIdForAction: event.userIDforAction,
      );
      res.fold((l) => emit(ProfileErrorState(errorMessage: l.message)), (r) {
        if (r == null) {
          emit(
            ProfileErrorState(errorMessage: 'profile user data model is null'),
          );
          return;
        }
        emit(OtherUserProfileFetchedState(userdata: r));
      });
    } catch (err) {
      emit(ProfileErrorState(errorMessage: err.toString()));
    }
  }

  _onFollowRequested(FollowRequested event, Emitter<ProfileState> emit) async {
    try {
      await profileRepository.followRequested(
        followedUserId: event.otherUserProfileModel.userID,
      );
      final currentState = state as OtherUserProfileFetchedState;
      final newOtherUserDataModel = OtherUserProfileModel(
        userID: currentState.userdata.userID,
        username: currentState.userdata.username,
        fullname: currentState.userdata.fullname,
        profileImageUrl: currentState.userdata.profileImageUrl,
        followersCount: currentState.userdata.followersCount + 1,
        followingCount: currentState.userdata.followingCount,
        userPostMap: currentState.userdata.userPostMap,
        isFollowing: true,
      );
      emit(OtherUserProfileFetchedState(userdata: newOtherUserDataModel));
    } catch (err) {
      emit(ProfileErrorState(errorMessage: err.toString()));
    }
  }

  _onUnfollowRequested(
    UnfollowRequested event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final res = await profileRepository.unfollowRequested(
        followedUserID: event.otherUserProfileModel.userID,
      );
      final currentState = state as OtherUserProfileFetchedState;
      final newOtherUserDataModel = OtherUserProfileModel(
        userID: currentState.userdata.userID,
        username: currentState.userdata.username,
        fullname: currentState.userdata.fullname,
        profileImageUrl: currentState.userdata.profileImageUrl,
        followersCount: currentState.userdata.followersCount - 1,
        followingCount: currentState.userdata.followingCount,
        userPostMap: currentState.userdata.userPostMap,
        isFollowing: false,
      );
      emit(OtherUserProfileFetchedState(userdata: newOtherUserDataModel));
    } catch (err) {
      emit(ProfileErrorState(errorMessage: err.toString()));
    }
  }
}
