sealed class ExploreEvent {}

final class SearchAllRequested extends ExploreEvent {
  final String searchQuery;

  SearchAllRequested({required this.searchQuery});
}

final class SearchPeopleRequested extends ExploreEvent {
  final String searchQuery;

  SearchPeopleRequested({required this.searchQuery});
}

final class SearchGramsRequested extends ExploreEvent {
  final String searchQuery;

  SearchGramsRequested({required this.searchQuery});
}
