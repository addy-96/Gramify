import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/main_domain/repository/app_repositories.dart';
import 'package:gramify/main_presentaiton/app_bloc/app_event.dart';
import 'package:gramify/main_presentaiton/app_bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepositories appRepositories;
  AppBloc({required this.appRepositories}) : super(AppInitialState()) {
    on<SetUserOnlineEvent>(_onSetUserOnlineEvent);
  }
  _onSetUserOnlineEvent(
    SetUserOnlineEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      final res = await appRepositories.setUserOnline();
      res.fold((l) => emit(AppErrorState(errorMessage: l.message)), (r) {});
    } catch (err) {
      emit(
        AppErrorState(
          errorMessage: 'error in setting user online: ${err.toString()}',
        ),
      );
    }
  }
}
