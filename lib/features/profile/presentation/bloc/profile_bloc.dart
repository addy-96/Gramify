import 'package:flutter_bloc/flutter_bloc.dart';
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
      await profileRepository.followRequested(followedUserId: event.followedId);
      emit(FollowedUserSuccessState());
    } catch (err) {
      emit(ProfileErrorState(errorMessage: err.toString()));
    }
  }
}
