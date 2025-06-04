import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/explore/presentation/bloc/explore_tab_bloc/explore_tab_event.dart';
import 'package:gramify/explore/presentation/bloc/explore_tab_bloc/explore_tab_state.dart';

class ExploreTabBloc extends Bloc<ExploreTabEvent, ExploreTabState> {
  ExploreTabBloc() : super(ExploreTabInititalState()) {
    on<ExploreTabSelectedEvent>((event, emit) {
      if (event.index == 0) {
        emit(AllTabSelected());
      } else if (event.index == 1) {
        emit(PeopleTabSelected());
      } else if (event.index == 2) {
        emit(GramsTabSelected());
      }
    });
  }
}
