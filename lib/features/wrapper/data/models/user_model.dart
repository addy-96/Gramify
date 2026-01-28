import 'package:gramify/features/wrapper/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.email, required super.username, required super.followerCount, required super.followingCount, super.profile, required super.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'], username: json['username'], followerCount: json['followers'], followingCount: json['following'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'username': username};
  }
}
