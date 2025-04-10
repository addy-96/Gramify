import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userID, required this.username});

  final String userID;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(children: [Text(userID), Text(username)])),
    );
  }
}
