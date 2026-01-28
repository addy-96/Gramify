import 'package:gramify/features/wrapper/domain/entities/profile.dart';

class User {
  final String id;
  final String email;
  final String username;
  final int followerCount;
  final int followingCount;
  final Profile? profile;
  User({required this.email, required this.username, required this.followerCount, required this.followingCount, this.profile,required this.id});
}
