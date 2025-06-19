part of 'explore_bloc.dart';

sealed class ExploreState {}

final class ExploreInintialState extends ExploreState {}

final class ExploreLoadingState extends ExploreState {}

final class SearchPeopleSuccessState extends ExploreState {
  List<SearchPeopleModel> peopleList;

  SearchPeopleSuccessState({required this.peopleList});
}

final class SearchFailureState extends ExploreState {
  final String errorMessage;
  SearchFailureState({required this.errorMessage});
}
