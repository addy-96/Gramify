part of 'wrapper_bloc.dart';

sealed class WrapperEvent {}

final class PageChageRequestedMobile extends WrapperEvent {
  final int selectedIndex;
  PageChageRequestedMobile({required this.selectedIndex});
}

final class PageChageRequestedWeb extends WrapperEvent {
  final int selectedIndex;
  PageChageRequestedWeb({required this.selectedIndex});
}
