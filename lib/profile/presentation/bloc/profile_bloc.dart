import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/profile/domain/repositories/profile_repository.dart';
import 'package:gramify/profile/presentation/bloc/profile_event.dart';
import 'package:gramify/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository})
    : super(ProfileInitialState()) {
    on<ProfileDataRequested>(_onProfileDataRequested);
  }

  _onProfileDataRequested(
    ProfileDataRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    try {
      final res = await profileRepository.getProfileDate(userId: event.userId);
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
}
