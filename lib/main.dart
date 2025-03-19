import 'package:flutter/material.dart';
import 'package:gramify/auth/presentation/login_res_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRobWp6c3hicW9teGlkY3FoY3VkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc3NDA3NDIsImV4cCI6MjA1MzMxNjc0Mn0.bD_zzbPdJdfhAHTmBRrsW1Ulem_1G35tZQb8T_qPmAI",
    url: "https://dhmjzsxbqomxidcqhcud.supabase.co",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gramify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Gramify(),
    );
  }
}

class Gramify extends StatelessWidget {
  const Gramify({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginResPage();
  }
}
