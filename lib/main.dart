import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gramify/core/backend/api_routes.dart';
import 'package:gramify/core/network/auth_interceptor.dart';
import 'package:gramify/core/network/dio_service.dart';
import 'package:gramify/features/auth/data/datasorces/auth_datasource.dart';
import 'package:gramify/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:gramify/features/auth/domain/usecases/signup_usecase.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/screens/signup_screen.dart';

void main() async {
  await loadEnv();
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
    return BlocProvider(
      create:
          (_) => AuthBloc(
            signupUsecase: SignupUsecase(
              authRepository: AuthRepositoryImpl(
                authDatasource: AuthDatasourceImpl(
                  apiRoutes: ApiRoutes(),
                  dioService: DioService(baseUrl: dotenv.get('BASE_URL'), authInterceptor: AuthInterceptor(), authorization: false),
                ),
              ),
            ),
          ),
      child: const MaterialApp(home: SignupScreen()),
    );
  }
}
