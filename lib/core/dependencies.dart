import 'package:get_it/get_it.dart';
import 'package:gramify/features/add_post/data/datasources/add_post_datasource.dart';
import 'package:gramify/features/add_post/data/repositories/add_post_repository_impl.dart';
import 'package:gramify/features/add_post/domain/repositories/add_post_repositories.dart';
import 'package:gramify/features/auth/domain/usecase/check_username_usecase.dart';
import 'package:gramify/features/messaging/data/datasorces/message_datasorce.dart';
import 'package:gramify/features/messaging/data/repositories/message_repositories_impl.dart';
import 'package:gramify/features/messaging/domain/repositories/message_repository.dart';
import 'package:gramify/main_presentaiton/app_bloc/wrapper_bloc/wrapper_bloc.dart';
import 'package:gramify/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:gramify/features/auth/data/datasources/local_datasource.dart';
import 'package:gramify/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:gramify/features/auth/domain/repositories/auth_repository.dart';
import 'package:gramify/features/auth/domain/usecase/login_usecase.dart';
import 'package:gramify/features/auth/domain/usecase/logout_usecase.dart';
import 'package:gramify/features/auth/domain/usecase/selectimage_usecase.dart';
import 'package:gramify/features/auth/domain/usecase/signup_usecase.dart';
import 'package:gramify/features/auth/domain/usecase/upload_profilepicture_usecase.dart';
import 'package:gramify/features/explore/data/datasources/explore_remote_datasource.dart';
import 'package:gramify/features/explore/data/repositories/explore_repository_impl.dart';
import 'package:gramify/features/explore/domain/repository/explore_repository.dart';
import 'package:gramify/features/home/data/datasources/home_remote_datasorce.dart';
import 'package:gramify/features/home/data/repositories/home_repsitoried_impl.dart';
import 'package:gramify/features/home/domain/repositories/home_repositories.dart';
import 'package:gramify/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:gramify/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:gramify/features/profile/domain/repositories/profile_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final GetIt servicelocator = GetIt.instance;

Future initDpendencies() async {
  await _authDepInit();
  await _wrapperInit();
  await _addPostInit();
  await _profileInit();
  await _exploreInit();
  await _homeInit();
  await _messagingInit();
}

_authDepInit() async {
  servicelocator.registerFactory(() => Supabase.instance);
  servicelocator.registerFactory(() => ImagePicker());

  final sharedPref = await SharedPreferences.getInstance();
  servicelocator.registerSingleton<SharedPreferences>(sharedPref);

  servicelocator.registerFactory<LocalDatasource>(
    () => LocalDatasourceImpl(imagePicker: servicelocator()),
  );

  servicelocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      supabase: servicelocator(),
      sharedPref: servicelocator<SharedPreferences>(),
    ),
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

  servicelocator.registerFactory(
    () => CheckUsernameUsecase(authRepository: servicelocator()),
  );
}

_wrapperInit() {
  servicelocator.registerFactory(() => WrapperBloc());
}

_addPostInit() {
  servicelocator.registerFactory(() => const Uuid());

  servicelocator.registerFactory<AddPostDataSource>(
    () => AddPostDataSourceImpl(
      supabase: servicelocator(),
      uuid: servicelocator(),
    ),
  );

  servicelocator.registerFactory<AddPostRepositories>(
    () => AddPostRepositoryImpl(addPostDatasource: servicelocator()),
  );
}

_profileInit() {
  servicelocator.registerFactory<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(supabase: servicelocator()),
  );

  servicelocator.registerFactory<ProfileRepository>(
    () => ProfileRepositoryImpl(profileRemoteDatasource: servicelocator()),
  );
}

_exploreInit() {
  servicelocator.registerFactory<ExploreRemoteDatasource>(
    () => ExploreRemoteDatasourceImpl(supabase: servicelocator()),
  );
  servicelocator.registerFactory<ExploreRepository>(
    () => ExploreRepositoryImpl(exploreRemoteDatasource: servicelocator()),
  );
}

_homeInit() {
  servicelocator.registerFactory<HomeRemoteDatasorce>(
    () => HomeRemoteDatasourceImpl(supabase: servicelocator()),
  );

  servicelocator.registerFactory<HomeRepositories>(
    () => HomeRepsitoriedImpl(homeRemoteDatasorce: servicelocator()),
  );
}

_messagingInit() {
  servicelocator.registerFactory<MessageDatasorce>(
    () => MessageDataSourceImpl(supabase: servicelocator()),
  );
  servicelocator.registerFactory<MessageRepository>(
    () => MessageRepositoriesImpl(messageDatasorce: servicelocator()),
  );
}
