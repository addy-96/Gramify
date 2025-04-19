sealed class WrapperEvent {}

final class PageChageRequested extends WrapperEvent {
  final int selectedIndex;
  PageChageRequested({required this.selectedIndex});
}
