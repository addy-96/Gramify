import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/auth/domain/usecases/signup_usecase.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_events.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final SignupUsecase signupUsecase;

  AuthBloc({required this.signupUsecase})
      : super(UnAuthenticatedState()) {
    on<SignUpEvent>(_onSignUpEvent);
  }

  Future<void> _onSignUpEvent(
    SignUpEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(AuthLoadingState());

    final result = await signupUsecase(
      SignUpParams(
        email: event.email,
        password: event.password,
        username: event.username,
        phone: event.phone,
      ),
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.message)),
      (user) => emit(AuthenticatedState(logedInUser: user)),
    );
  }
}
