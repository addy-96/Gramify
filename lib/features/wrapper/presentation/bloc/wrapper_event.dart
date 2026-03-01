sealed class WrapperEvent {}

final class FetchUserEvent extends WrapperEvent {}

final class UploadUserProfileImageEvent extends WrapperEvent {
  final String imagePath;

  UploadUserProfileImageEvent({required this.imagePath});
}

final class EditProfileEvent extends WrapperEvent {
  final String firstName;
  final String lastName;
  final String gender;
  final String pronoun;
  final String state;
  final String country;
  final String? profileImageUrl;

  EditProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.pronoun,
    required this.state,
    required this.country,
    required this.profileImageUrl,
  });
}
