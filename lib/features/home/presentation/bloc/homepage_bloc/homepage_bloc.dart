import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/home/domain/repositories/home_repositories.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_event.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final HomeRepositories homeRepositorie;
  HomepageBloc({required this.homeRepositorie})
    : super(HomePageInititalState()) {
    on<FeedsRequested>(_onFeedsRequested);

    //
    on<UpdateFeedPostLikeStatus>(_onUpdateFeedPostLikeStatus);
  }

  void _onFeedsRequested(
    FeedsRequested event,
    Emitter<HomepageState> emit,
  ) async {
    try {
      if (state is FeedsFetchedState) {
        return;
      }
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

  void _onUpdateFeedPostLikeStatus(
    UpdateFeedPostLikeStatus event,
    Emitter<HomepageState> emit,
  ) {
    if (state is FeedsFetchedState) {
      final currentState = state as FeedsFetchedState;
      final updatedFeeds =
          currentState.feedList.map((post) {
            if (post.postId == event.postId) {
              return post.copyWith(isLiked: event.isLiked);
            }
            return post;
          }).toList();

      emit(FeedsFetchedState(feedList: updatedFeeds));
    }
  }
}
