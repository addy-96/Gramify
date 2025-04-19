
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key, required this.receivedText});
  final String receivedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(children: [Text(receivedText)])),
    );
  }
}
