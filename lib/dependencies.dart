import 'package:get_it/get_it.dart';
import 'package:gramify/app_bloc/wrapper_bloc/wrapper_bloc.dart';
import 'package:gramify/auth/data/datasources/auth_remote_datasource.dart';
import 'package:gramify/auth/data/repositories/auth_repository_impl.dart';
import 'package:gramify/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/auth/domain/usecase/login_usecase.dart';
import 'package:gramify/auth/domain/usecase/signup_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt servicelocator = GetIt.instance;

Future initDpendencies() async {
  await _authDepInit();
  await _wrapperInit();
}

_authDepInit() {
  servicelocator.registerFactory(() => Supabase.instance);

  servicelocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(supabase: servicelocator()),
  );

  servicelocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: servicelocator()),
  );

  servicelocator.registerFactory(
    () => SignupUsecase(authRepository: servicelocator()),
  );

  servicelocator.registerFactory(
    () => LoginUsecase(authRepository: servicelocator()),
  );
}

_wrapperInit() {
  servicelocator.registerFactory(() => WrapperBloc());
}
