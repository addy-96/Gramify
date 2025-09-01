import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/home/domain/repositories/home_repositories.dart';
import 'package:gramify/features/home/presentation/bloc/story_bloc/story_event.dart';
import 'package:gramify/features/home/presentation/bloc/story_bloc/story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final HomeRepositories homeRepositories;
  StoryBloc({required this.homeRepositories}) : super(StoryInitialState()) {
    on<GetAllUserStoriesRequested>(_onGetAllUserStoriesRequested);
  }

  _onGetAllUserStoriesRequested(GetAllUserStoriesRequested event, Emitter<StoryState> emit) async {
    try {
      emit(LoadingAllStoryState());
      final res = await homeRepositories.fetchAllStories();
      res.fold((l) => emit(LoadingStoriesFailureState(errorMessage: l.message)), (r) => emit(AllStoriesLoadedState(stories: r)));
    } catch (err) {
      emit(LoadingStoriesFailureState(errorMessage: err.toString()));
    }
  }
}
