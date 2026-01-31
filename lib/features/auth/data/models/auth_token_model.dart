import 'package:gramify/features/auth/domain/entites/auth_token.dart';

class AuthTokenModel extends AuthToken {
  AuthTokenModel({required super.accessToken, required super.refreshToken});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) => AuthTokenModel(accessToken: json['accessToken'], refreshToken: json['refreshToken']);

  Map<String,dynamic> toJson() {
    return {'accessToken': accessToken,'refreshToken': refreshToken};
  }
}
