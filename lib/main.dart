import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_app/bloc/tv_show_bloc/tvshow_bloc.dart';
import 'package:movie_app/repository/auth_repository.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/screen/auth_screen/get_started.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screen/main_screen.dart';
import 'package:movie_app/screen/auth_screen/signin_screen.dart';
import 'package:movie_app/services/movie_service.dart';
import 'package:movie_app/services/tv_show_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context))),
          BlocProvider(
              create: (context) => MovieBloc(movieRepository: MovieService())
                ..add(LoadedDataEvent())),
          BlocProvider(
              create: (context) =>
                  TvshowBloc(tv_show_repository: TvShowService())
                    ..add(GetTvshowEvent())),
        ],
        child: ScreenUtilInit(
          designSize: Size(375, 812),
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute:
                initScreen == 0 || initScreen == null ? 'onboard' : 'signin',
            routes: {
              'signin': (context) => StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return MainScreen();
                    }
                    return SignInScreen();
                  }),
              'onboard': (context) => GetStarted(),
            },
          ),
        ),
      ),
    );
  }
}
