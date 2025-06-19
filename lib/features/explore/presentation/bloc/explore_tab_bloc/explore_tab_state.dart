part of 'explore_tab_bloc.dart';

sealed class ExploreTabState {}

final class ExploreTabInititalState extends ExploreTabState {}

final class PeopleTabSelected extends ExploreTabState {}

final class GramsTabSelected extends ExploreTabState {}
