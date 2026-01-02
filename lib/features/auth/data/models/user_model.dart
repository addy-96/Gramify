import 'package:gramify/features/auth/domain/entites/user.dart';

class UserModel extends User {
  UserModel({required super.email, required super.username, required super.followerCount, required super.followingCount, super.profile});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'], username: json['username'], followerCount: json['followers'], followingCount: json['following']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'username': username};
  }
}
