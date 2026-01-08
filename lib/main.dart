import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gramify/core/dependicies.dart';
import 'package:gramify/core/routes/go_router.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  await initDependcies();
  runApp(const MyApp());
}

Future<void> loadEnv() async {
  String env = const String.fromEnvironment('ENV');
  switch (env) {
    case "dev":
      await dotenv.load(fileName: 'env/env.dev');
      break;
    case "prod":
      await dotenv.load(fileName: 'env/env.prod');
      break;
    default:
      await dotenv.load(fileName: 'env/env.prod');
      break;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthBloc(signupUsecase: serviceLocator()), child: MaterialApp.router(routerConfig: router));
  }
}
