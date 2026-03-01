enum UsernameStatus { initial, checking, available, unavailable }

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? errorMessage;
  final UsernameStatus usernameStatus;

  AuthState({this.isLoading = false, this.isAuthenticated = false, this.errorMessage, this.usernameStatus = UsernameStatus.initial});

  AuthState copyWith({bool? isLoading, bool? isAuthenticated, String? errorMessage, UsernameStatus? usernameStatus}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage,
      usernameStatus: usernameStatus ?? this.usernameStatus,
    );
  }
}
