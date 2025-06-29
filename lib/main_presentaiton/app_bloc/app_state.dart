sealed class AppState {}

final class AppInitialState extends AppState {}

final class AppErrorState extends AppState {
  final String errorMessage;

  AppErrorState({required this.errorMessage});
}
