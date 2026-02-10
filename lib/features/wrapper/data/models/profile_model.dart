import 'package:gramify/features/wrapper/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({super.fullname, super.bio, super.avatarUrl, super.location, super.dob});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(fullname: json['fullname'], bio: json['bio'], avatarUrl: json['avatar_url'], location: json['location'], dob: json['dob']);
  }

  Map<String, dynamic> toJson() {
    return {'fullname': fullname, 'bio': bio, 'avatar_url': avatarUrl, 'location': location, 'dob': dob};
  }
}
