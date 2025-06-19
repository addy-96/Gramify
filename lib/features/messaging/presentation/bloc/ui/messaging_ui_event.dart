sealed class MessagingUiEvent {}

final class SearchBoxToggledUIevent extends MessagingUiEvent {
  final bool action;
  SearchBoxToggledUIevent({required this.action});
}
