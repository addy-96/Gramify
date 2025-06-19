part of 'explore_tab_bloc.dart';

sealed class ExploreTabEvent {}

final class ExploreTabSelectedEvent extends ExploreTabEvent {
  final int index;

  ExploreTabSelectedEvent({required this.index});
}
