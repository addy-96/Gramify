import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:gramify/core/backend/api_routes.dart';
import 'package:gramify/core/network/auth_interceptor.dart';
import 'package:gramify/core/network/dio_service.dart';
import 'package:gramify/core/shared_pref_repo.dart';
import 'package:gramify/features/auth/data/datasorces/auth_datasource.dart';
import 'package:gramify/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/features/auth/domain/usecases/login_usecase.dart';
import 'package:gramify/features/auth/domain/usecases/logout_usecase.dart';
import 'package:gramify/features/auth/domain/usecases/signup_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependcies() async {
  await _initApp();
  _initServer();
  _initAuth();
}

Future<void> _initApp() async {
  serviceLocator.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  serviceLocator.registerSingleton<SharedPrefRepo>(SharedPrefRepo());
}

void _initServer() {
  serviceLocator.registerSingleton<DioService>(DioService(baseUrl: dotenv.get('BASE_URL'), authInterceptor: AuthInterceptor()));

  serviceLocator.registerSingleton<DioService>(
    DioService(baseUrl: dotenv.get('BASE_URL'), authInterceptor: AuthInterceptor(), authorization: false),
    instanceName: 'noAuth',
  );

  serviceLocator.registerSingleton<ApiRoutes>(ApiRoutes());
}

void _initAuth() {
  serviceLocator.registerSingleton<AuthDatasource>(AuthDatasourceImpl(apiRoutes: serviceLocator(), dioService: serviceLocator(instanceName: 'noAuth')));

  serviceLocator.registerSingleton<AuthRepository>(AuthRepositoryImpl(authDatasource: serviceLocator(), pref: serviceLocator()));

  serviceLocator.registerSingleton<SignupUsecase>(SignupUsecase(authRepository: serviceLocator()));

  serviceLocator.registerSingleton<LoginUsecase>(LoginUsecase(authRepository: serviceLocator()));

  serviceLocator.registerSingleton<LogoutUsecase>(LogoutUsecase(authRepository: serviceLocator()));
}
