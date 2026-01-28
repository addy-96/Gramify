import 'package:flutter/material.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppGradientScaffold(
      body: Column(
        children: [
          Row(children: [CircleAvatar(radius: 20, backgroundColor: Colors.grey)]),
          Expanded(child: Text('wrapper screeen')),
        ],
      ),
    );
  }
}
