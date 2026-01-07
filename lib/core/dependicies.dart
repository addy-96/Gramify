import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:gramify/core/backend/api_routes.dart';
import 'package:gramify/core/network/auth_interceptor.dart';
import 'package:gramify/core/network/dio_service.dart';
import 'package:gramify/features/auth/data/datasorces/auth_datasource.dart';
import 'package:gramify/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/features/auth/domain/usecases/signup_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependcies() async {
  _initServer();
  _initAuth();
}

void _initServer() {
  serviceLocator.registerSingleton<DioService>(
    DioService(baseUrl: dotenv.get('BASE_URL'), authInterceptor: AuthInterceptor()),
  );

  serviceLocator.registerSingleton<DioService>(
    DioService(baseUrl: dotenv.get('BASE_URL'), authInterceptor: AuthInterceptor(), authorization: false),
    instanceName: 'noAuth',
  );

  serviceLocator.registerSingleton<ApiRoutes>(ApiRoutes());
}

void _initAuth() {
  serviceLocator.registerSingleton<AuthDatasource>(
    AuthDatasourceImpl(
      apiRoutes: serviceLocator(),
      dioService: serviceLocator(instanceName: 'noAuth'),
    ),
  );

  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(authDatasource: serviceLocator()),
  );

  serviceLocator.registerSingleton<SignupUsecase>(
    SignupUsecase(authRepository: serviceLocator()),
  );
}
