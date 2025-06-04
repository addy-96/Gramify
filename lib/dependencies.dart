import 'package:get_it/get_it.dart';
import 'package:gramify/add_post/data/datasources/add_post_datasource.dart';
import 'package:gramify/add_post/data/repositories/add_post_repository_impl.dart';
import 'package:gramify/add_post/domain/repositories/add_post_repositories.dart';
import 'package:gramify/app_bloc/wrapper_bloc/wrapper_bloc.dart';
import 'package:gramify/auth/data/datasources/auth_remote_datasource.dart';
import 'package:gramify/auth/data/datasources/local_datasource.dart';
import 'package:gramify/auth/data/repositories/auth_repository_impl.dart';
import 'package:gramify/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/auth/domain/usecase/login_usecase.dart';
import 'package:gramify/auth/domain/usecase/logout_usecase.dart';
import 'package:gramify/auth/domain/usecase/selectimage_usecase.dart';
import 'package:gramify/auth/domain/usecase/signup_usecase.dart';
import 'package:gramify/auth/domain/usecase/upload_profilepicture_usecase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt servicelocator = GetIt.instance;

Future initDpendencies() async {
  await _authDepInit();
  await _wrapperInit();
  await _addPostInit();
}

_authDepInit() {
  servicelocator.registerFactory(() => Supabase.instance);
  servicelocator.registerFactory(() => ImagePicker());

  servicelocator.registerFactory<LocalDatasource>(
    () => LocalDatasourceImpl(imagePicker: servicelocator()),
  );

  servicelocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(supabase: servicelocator()),
  );

  servicelocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: servicelocator(),
      localDatasource: servicelocator(),
    ),
  );

  servicelocator.registerFactory(
    () => SignupUsecase(authRepository: servicelocator()),
  );

  servicelocator.registerFactory(
    () => LoginUsecase(authRepository: servicelocator()),
  );

  servicelocator.registerFactory(
    () => LogoutUsecase(authRepository: servicelocator()),
  );

  servicelocator.registerFactory(
    () => UploadProfilepictureUsecase(authRepository: servicelocator()),
  );

  servicelocator.registerFactory(
    () => SelectimageUsecase(authRepository: servicelocator()),
  );
}

_wrapperInit() {
  servicelocator.registerFactory(() => WrapperBloc());
}

_addPostInit() {
  servicelocator.registerFactory<AddPostDataSource>(
    () => AddPostDataSourceImpl(supabase: servicelocator()),
  );

  servicelocator.registerFactory<AddPostRepositories>(
    () => AddPostRepositoryImpl(addPostDatasource: servicelocator()),
  );
}
