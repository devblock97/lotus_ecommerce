import 'dart:io';

import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/views/login_screen.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:ecommerce_app/features/notification/data/repositories/notify_repository_impl.dart';
import 'package:ecommerce_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:ecommerce_app/localizations/app_localizations.dart';
import 'package:ecommerce_app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  /// Local DB with Hive
  await Hive.initFlutter();

  /// Dependencies injection
  await init();

  Bloc.observer = SimpleBlocObserver();
  runApp(const EcommerceApp());

}

class SimpleBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }
}


class EcommerceApp extends StatefulWidget {
  const EcommerceApp({super.key});

  @override
  State<EcommerceApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<EcommerceApp> {

  late bool userLogged = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        /// Favorite
        ChangeNotifierProxyProvider(
            create: (context) => FavoriteRepositoryImpl(),
            update: (context, value, FavoriteRepositoryImpl? favorite) {
              if (favorite == null) throw ArgumentError('Favorite');
              return favorite;
            }),

        /// Notify
        ChangeNotifierProxyProvider(
          create: (context) => NotifyRepositoryImpl(),
          update: (context, value, NotifyRepositoryImpl? notify) {
            if (notify == null) throw ArgumentError('Notify');
            return notify;
          },
        ),

        /// Theme Selector
        ChangeNotifierProvider(create: (_) => ThemeSelector()),

        BlocProvider(create: (_) => sl<CartBloc>()),
        BlocProvider(create: (_) => sl<ThemeBloc>()..add(const GetThemeRequest())),
        BlocProvider(create: (_) => sl<AuthBloc>()..add(CheckSignedIn()))
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          debugPrint('check theme state: $state');
          final themeMode = (state is SetThemeSuccess) ? state.theme : ThemeMode.system;
          return MaterialApp(
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            theme: EcommerceTheme.buildLightTheme(context),
            darkTheme: EcommerceTheme.buildDarkTheme(context),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('vn', 'VN'),
              Locale('en', 'US')
            ],
            home: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_)
                      => const GroceryApp()), (route) => false);
                } else {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_)
                      => const LoginScreen()), (route) => false);
                }
              },
              builder: (context, state) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator(),),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}