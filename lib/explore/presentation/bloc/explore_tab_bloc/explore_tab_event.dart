sealed class ExploreTabEvent {}

final class ExploreTabSelectedEvent extends ExploreTabEvent {
  final int index;

  ExploreTabSelectedEvent({required this.index});
}
