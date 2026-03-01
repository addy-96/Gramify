import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/core/models.dart';
import 'package:gramify/core/shared_pref_repo.dart';
import 'package:gramify/features/auth/domain/usecases/check_username_usecase.dart';
import 'package:gramify/features/auth/domain/usecases/login_usecase.dart';
import 'package:gramify/features/auth/domain/usecases/logout_usecase.dart';
import 'package:gramify/features/auth/domain/usecases/signup_usecase.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_events.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final SignupUsecase signupUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final CheckUsernameUsecase checkUsernameUsecase;
  final SharedPreferences pref;

  AuthBloc({required this.signupUsecase, required this.loginUsecase, required this.pref, required this.logoutUsecase, required this.checkUsernameUsecase})
    : super(AuthState()) {
    on<SignUpEvent>(_onSignUpEvent);
    on<LoginEvent>(_onLoginEvent);
    on<CheckAuthStatusEvent>(_onCheckAuthStatusEvent);
    on<LogOutEvent>(_onLogOutEvent);
    on<CheckUsernameAvailablity>(_onCheckUsernameAvailablity);
  }

  Future<void> _onCheckAuthStatusEvent(CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final accessToken = pref.getString(SharedPrefRepo.accessToken);
    final refreshToken = pref.getString(SharedPrefRepo.refreshToken);

    if (accessToken != null && refreshToken != null) {
      emit(state.copyWith(isLoading: false, isAuthenticated: true, errorMessage: null));
    } else {
      emit(state.copyWith(isLoading: false, isAuthenticated: false, errorMessage: null));
    }
  }

  Future<void> _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await signupUsecase(SignUpParams(email: event.email, password: event.password, username: event.username, phone: event.phone));

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (authToken) => emit(state.copyWith(isLoading: false, isAuthenticated: true, errorMessage: null)),
    );
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await loginUsecase.call(LoginParams(email: event.email, password: event.password));

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (authToken) => emit(state.copyWith(isLoading: false, isAuthenticated: true, errorMessage: null)),
    );
  }

  Future<void> _onLogOutEvent(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    await logoutUsecase.call(UsecaseNoParams());

    emit(state.copyWith(isLoading: false, isAuthenticated: false, errorMessage: null));
  }
  
  Future<void> _onCheckUsernameAvailablity(CheckUsernameAvailablity event, Emitter<AuthState> emit) async {

    emit(state.copyWith(usernameStatus: UsernameStatus.checking));

    final result = await checkUsernameUsecase.call(CheckUsernameParams(typedUsername: event.username));

    result.fold(
      (failure) => emit(state.copyWith(usernameStatus: UsernameStatus.unavailable)),
      (available) => emit(state.copyWith(usernameStatus: available ? UsernameStatus.available : UsernameStatus.unavailable)),
    );
  }
}
