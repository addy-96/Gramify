import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/explore/domain/repository/explore_repository.dart';
import 'package:gramify/explore/presentation/bloc/explore_bloc/explore_event.dart';
import 'package:gramify/explore/presentation/bloc/explore_bloc/explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final ExploreRepository exploreRepository;

  ExploreBloc({required this.exploreRepository})
    : super(ExploreInintialState()) {
    //
    on<SearchPeopleRequested>(_onSearchPeopleRequested);
    //
  }
  _onSearchPeopleRequested(
    SearchPeopleRequested event,
    Emitter<ExploreState> emit,
  ) async {
    emit(ExploreLoadingState());

    try {
      final res = await exploreRepository.searchPeople(event.searchQuery);
      res.fold(
        (l) => emit(SearchFailureState(errorMessage: l.message)),
        (r) => emit(SearchPeopleSuccessState(peopleList: r)),
      );
    } catch (err) {
      emit(SearchFailureState(errorMessage: err.toString()));
    }
  }
}
