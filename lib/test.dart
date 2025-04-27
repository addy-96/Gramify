import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Test extends StatelessWidget {
  const Test({super.key, required this.receivedText});
  final String receivedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ShaderText(textWidget: Text(receivedText)),
            if (receivedText == 'Profile')
              IconButton(
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                },
                icon: Icon(Ionicons.log_out_outline),
              ),
          ],
        ),
      ),
    );
  }
}
