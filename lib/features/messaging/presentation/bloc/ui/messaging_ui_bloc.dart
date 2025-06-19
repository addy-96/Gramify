import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/messaging/presentation/bloc/ui/messaging_ui_event.dart';
import 'package:gramify/features/messaging/presentation/bloc/ui/messaging_ui_state.dart';

class MessagingUiBloc extends Bloc<MessagingUiEvent, MessagingUiState> {
  MessagingUiBloc() : super(MessageUIinitialStat()) {
    on<SearchBoxToggledUIevent>(_onSearchBoxToggledUIevent);

    //
  }

  _onSearchBoxToggledUIevent(
    SearchBoxToggledUIevent event,
    Emitter<MessagingUiState> emit,
  ) {
    if (event.action == true) {
      emit(SearchBoxOpenUIState());
    } else {
      emit(SearchBoxClosedUIState());
    }
  }
}
