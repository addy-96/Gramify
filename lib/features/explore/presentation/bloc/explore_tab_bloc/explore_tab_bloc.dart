import 'package:flutter_bloc/flutter_bloc.dart';
part 'explore_tab_event.dart';
part 'explore_tab_state.dart';

class ExploreTabBloc extends Bloc<ExploreTabEvent, ExploreTabState> {
  ExploreTabBloc() : super(ExploreTabInititalState()) {
    on<ExploreTabSelectedEvent>((event, emit) {
      if (event.index == 0) {
        emit(PeopleTabSelected());
      } else if (event.index == 1) {
        emit(GramsTabSelected());
      }
    });
  }
}
