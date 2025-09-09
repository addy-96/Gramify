sealed class StoryState {}

class StoryInitialState extends StoryState {}

class LoadingAllStoryState extends StoryState {}

class AllStoriesLoadedState extends StoryState {
  final List<String> stories;

  AllStoriesLoadedState({required this.stories});
}

class LoadingStoriesFailureState extends StoryState {
  final String errorMessage;

  LoadingStoriesFailureState({required this.errorMessage});
}

class FetchSelfStoriesFailureState extends StoryState {}

class SelfStoriesFetchedState extends StoryState {
  List<String> selfStories;

  SelfStoriesFetchedState({required this.selfStories});
}
