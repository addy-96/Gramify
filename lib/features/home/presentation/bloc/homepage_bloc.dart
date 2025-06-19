import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/home/domain/repositories/home_repositories.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_event.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final HomeRepositories homeRepositorie;
  HomepageBloc({required this.homeRepositorie})
    : super(HomePageInititalState()) {
    on<FeedsRequested>(_onFeedsRequested);
  }

  void _onFeedsRequested(
    FeedsRequested event,
    Emitter<HomepageState> emit,
  ) async {
    try {
      emit(HomePageLoadingState());
      final res = await homeRepositorie.loadUserFeeds();
      res.fold(
        (l) => emit(
          HomePageErrorState(
            errorMessage: 'error in returiving feeds : ${l.message}',
          ),
        ),
        (r) => emit(FeedsFetchedState(feedList: r)),
      );
    } catch (err) {
      emit(
        HomePageErrorState(
          errorMessage: 'error in returiving feeds : ${err.toString()}',
        ),
      );
    }
  }
}
