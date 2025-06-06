import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:gramify/add_post/presentation/bloc/cubit/selectedPicture_cubit.dart';
import 'package:gramify/app_bloc/wrapper_bloc/wrapper_bloc.dart';
import 'package:gramify/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/auth/presentation/login_res_page.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/routes/app_routes_config.dart';
import 'package:gramify/dependencies.dart';
import 'package:gramify/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:gramify/explore/presentation/bloc/explore_tab_bloc/explore_tab_bloc.dart';
import 'package:gramify/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/test.dart';
import 'package:gramify/wrapper.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sAuth;

void main() async {
  await sAuth.Supabase.initialize(
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
                selectimageUsecase: servicelocator(),
                loginUsecase: servicelocator(),
                signupUsecase: servicelocator(),
                logoutUsecase: servicelocator(),
                uploadProfilepictureUsecase: servicelocator(),
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
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: MyAppRoutes.router,
        title: 'Gramify',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: themeColor,
            brightness: Brightness.dark,
          ),
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}

class Gramify extends StatefulWidget {
  const Gramify({super.key});

  @override
  State<Gramify> createState() => _GramifyState();
}

class _GramifyState extends State<Gramify> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [backGrad1, backGrad2]),
          ),
          child: AppStart(),
        ),
      ),
    );
  }
}

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<InternetStatus>(
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
                  authSnapshot.data?.event != sAuth.AuthChangeEvent.signedOut) {
                final userId = session.user.id;
                return WrapperRes(userID: userId);
              } else {
                return LoginResPage();
              }
            },
          );
        } else if (netSnapshot.hasData &&
            netSnapshot.data == InternetStatus.disconnected) {
          return const Test(receivedText: 'No Internet');
        } else if (netSnapshot.hasError) {
          return Test(receivedText: '${netSnapshot.error} is the error');
        }

        return const Test(receivedText: 'Unknown connection state');
      },
    );
  }
}
