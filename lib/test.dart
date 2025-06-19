import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/main_presentaiton/app_bloc/wrapper_bloc/wrapper_bloc.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:ionicons/ionicons.dart';

class Test extends StatelessWidget {
  const Test({super.key, required this.receivedText});
  final String receivedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {},
                icon: const Icon(Icons.check_box),
              ),
              Text(receivedText),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLogedOut) {
                    context.go('/');
                  }
                },
                child: IconButton(
                  onPressed: () async {
                    context.read<AuthBloc>().add(LogOutRequested());
                    context.read<WrapperBloc>().add(
                      PageChageRequestedMobile(selectedIndex: 0),
                    );
                    context.go('/');
                  },
                  icon: const Icon(Ionicons.log_out, size: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
