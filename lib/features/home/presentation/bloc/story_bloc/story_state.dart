import 'package:gramify/features/home/domain/models/story_model.dart';

sealed class StoryState {}

class StoryInitialState extends StoryState {}

class LoadingAllStoryState extends StoryState {}

class AllStoriesLoadedState extends StoryState {
  final List<StoryModel> stories;

  AllStoriesLoadedState({required this.stories});
}

class LoadingStoriesFailureState extends StoryState {
  final String errorMessage;

  LoadingStoriesFailureState({required this.errorMessage});
}
