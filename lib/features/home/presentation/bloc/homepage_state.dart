import 'package:gramify/features/home/domain/models/post_model.dart';

sealed class HomepageState {}

class HomePageInititalState extends HomepageState {}

class HomePageLoadingState extends HomepageState {}

class HomePageErrorState extends HomepageState {
  final String errorMessage;

  HomePageErrorState({required this.errorMessage});
}

class FeedsFetchedState extends HomepageState {
  final List<PostModel> feedList;
  FeedsFetchedState({required this.feedList});
}
