sealed class ProfileEvent {}

final class ProfileDataRequested extends ProfileEvent {
  final String? userId;

  ProfileDataRequested({required this.userId});
}
