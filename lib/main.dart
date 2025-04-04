import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/auth/presentation/signup_res_page.dart';
import 'package:gramify/core/routes/app_routes_config.dart';
import 'package:gramify/dependencies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRobWp6c3hicW9teGlkY3FoY3VkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc3NDA3NDIsImV4cCI6MjA1MzMxNjc0Mn0.bD_zzbPdJdfhAHTmBRrsW1Ulem_1G35tZQb8T_qPmAI",
    url: "https://dhmjzsxbqomxidcqhcud.supabase.co",
  );

  await initDpendencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => AuthBloc(
                loginUsecase: servicelocator(),
                signupUsecase: servicelocator(),
              ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: MyAppRoutes.router,
        title: 'Gramify',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}

class Gramify extends StatelessWidget {
  const Gramify({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupResPage();
  }
}
