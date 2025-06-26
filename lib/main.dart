import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/core/dependencies.dart';
import 'package:gramify/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:gramify/features/add_post/presentation/bloc/cubit/selectedPicture_cubit.dart';
import 'package:gramify/features/home/presentation/bloc/post_bloc/post_bloc.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:gramify/features/messaging/presentation/bloc/ui/messaging_ui_bloc.dart';
import 'package:gramify/main_presentaiton/app_bloc/wrapper_bloc/wrapper_bloc.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/login_res_page.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/routes/app_routes_config.dart';
import 'package:gramify/features/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:gramify/features/explore/presentation/bloc/explore_tab_bloc/explore_tab_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:gramify/core/ignore.dart';
import 'package:gramify/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/test.dart';
import 'package:gramify/wrapper.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sAuth;

void main() async {
  await sAuth.Supabase.initialize(
    anonKey: SUPABSE_ANNON_KEY,
    url: SUPABASE_URL,
  );
  await initDpendencies();
  runApp(const MyApp());
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => AuthBloc(
                selectimageUsecase: servicelocator(),
                loginUsecase: servicelocator(),
                signupUsecase: servicelocator(),
                logoutUsecase: servicelocator(),
                uploadProfilepictureUsecase: servicelocator(),
                checkUsernameUsecase: servicelocator(),
              ),
        ),
        BlocProvider(create: (context) => WrapperBloc()),
        BlocProvider(
          create:
              (context) => AddPostBloc(
                addPostRepositories: servicelocator(), //implement use case
              ),
        ),
        BlocProvider(create: (context) => SelectedpictureCubit()),
        BlocProvider(create: (context) => ExploreTabBloc()),
        BlocProvider(
          create: (context) => ProfileBloc(profileRepository: servicelocator()),
        ),
        BlocProvider(
          create: (context) => ExploreBloc(exploreRepository: servicelocator()),
        ),

        BlocProvider(
          create: (context) => HomepageBloc(homeRepositorie: servicelocator()),
        ),

        BlocProvider(
          create: (context) => MessageBloc(messageRepository: servicelocator()),
        ),

        BlocProvider(create: (context) => MessagingUiBloc()),
        BlocProvider(
          create: (context) => PostBloc(homeRepositories: servicelocator()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: MyAppRoutes.router,
        title: 'Gramify',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
        ),
      ),
    );
  }
}

//
class Gramify extends StatefulWidget {
  const Gramify({super.key});

  @override
  State<Gramify> createState() => _GramifyState();
}

class _GramifyState extends State<Gramify> {
  late final AppLifecycleListener _lifeCycleListener;

  @override
  void initState() {
    super.initState();
    sendUserOnlineStat();
    _lifeCycleListener = AppLifecycleListener(
      onRestart: () => log('App restareted'),
      onPause: () => log('App restareted'),
      onResume: () => log('App restareted'),
      onInactive: () => log('App restareted'),
      onStateChange: (value) {
        log('App state changed to ${value.name}');
      },
    );
  }

  void sendUserOnlineStat() async {
    try {
      await Future.delayed(const Duration(minutes: 2));
      log('executed\n');

      sendUserOnlineStat();
    } catch (err) {
      log(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [backGrad1, backGrad2]),
          ),
          child: const AppStart(),
        ),
      ),
    );
  }
}

//
class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<InternetStatus>(
        stream: InternetConnection().onStatusChange,
        builder: (context, netSnapshot) {
          if (netSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (netSnapshot.hasData &&
              netSnapshot.data == InternetStatus.connected) {
            return StreamBuilder(
              stream: sAuth.Supabase.instance.client.auth.onAuthStateChange,
              builder: (context, authSnapshot) {
                final session =
                    sAuth.Supabase.instance.client.auth.currentSession;

                if (authSnapshot.connectionState == ConnectionState.waiting &&
                    session == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (session != null &&
                    authSnapshot.data?.event !=
                        sAuth.AuthChangeEvent.signedOut) {
                  final userId = session.user.id;
                  return WrapperRes(userID: userId);
                } else {
                  return const LoginResPage();
                }
              },
            );
          } else if (netSnapshot.hasData &&
              netSnapshot.data == InternetStatus.disconnected) {
            return const Test(receivedText: 'No internet');
          } else if (netSnapshot.hasError) {
            return Test(receivedText: '${netSnapshot.error} is the error');
          }
          return const Test(receivedText: 'Unknown connection state');
        },
      ),
    );
  }
}
