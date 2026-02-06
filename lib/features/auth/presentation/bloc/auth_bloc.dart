import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/core/models.dart';
import 'package:gramify/core/shared_pref_repo.dart';
import 'package:gramify/features/auth/domain/entites/auth_token.dart';
import 'package:gramify/features/auth/domain/usecases/login_usecase.dart';
import 'package:gramify/features/auth/domain/usecases/logout_usecase.dart';
import 'package:gramify/features/auth/domain/usecases/signup_usecase.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_events.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final SignupUsecase signupUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final SharedPreferences pref;

  AuthBloc({required this.signupUsecase, required this.loginUsecase, required this.pref, required this.logoutUsecase}) : super(UnAuthenticatedState()) {
    on<SignUpEvent>(_onSignUpEvent);
    on<LoginEvent>(_onLoginEvent);
    on<CheckAuthStatusEvent>(_onCheckAuthStatusEvent);
    on<LogOutEvent>(_onLogOutEvent);
  }

  Future<void> _onCheckAuthStatusEvent(CheckAuthStatusEvent event, Emitter<AuthStates> emit) async {
    emit(AuthLoadingState());
    final accessToken = pref.getString(SharedPrefRepo.accessToken);
    final refreshToken = pref.getString(SharedPrefRepo.refreshToken);
    if (accessToken != null && refreshToken != null) {
      emit(AuthenticatedState(authToken: AuthToken(accessToken: accessToken, refreshToken: refreshToken)));
    } else {
      emit(UnAuthenticatedState());
    }
  }

  Future<void> _onSignUpEvent(SignUpEvent event, Emitter<AuthStates> emit) async {
    emit(AuthLoadingState());

    final result = await signupUsecase(SignUpParams(email: event.email, password: event.password, username: event.username, phone: event.phone));

    result.fold((failure) => emit(AuthErrorState(message: failure.message)), (authToken) => emit(AuthenticatedState(authToken: authToken)));
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthStates> emit) async {
    emit(AuthLoadingState());

    final result = await loginUsecase.call(LoginParams(email: event.email, password: event.password));

    result.fold((failure) => emit(AuthErrorState(message: failure.message)), (authToken) => emit(AuthenticatedState(authToken: authToken)));
  }

  Future<void> _onLogOutEvent(LogOutEvent event, Emitter<AuthStates> emit) async {
    emit(AuthLoadingState());
    await logoutUsecase.call(UsecaseNoParams());
    emit(UnAuthenticatedState());
  }
}
