import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/auth/domain/usecase/login_usecase.dart';
import 'package:gramify/auth/domain/usecase/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;

  AuthBloc({required this.loginUsecase, required this.signupUsecase})
    : super(AuthInitialState()) {
    on<LogInRequested>(_onLogInRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  _onLogInRequested(LogInRequested event, Emitter<AuthState> emit) async {
    final res = await loginUsecase.call(
      LoginUserParams(email: event.email, password: event.password),
    );

    res.fold(
      (l) => emit(AuthFilure(errorMessage: l.message)),
      (r) => emit(AuthLogInSuccess()),
    );
  }

  _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) {}
}
