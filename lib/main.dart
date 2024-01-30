import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_app/features/auth/data/models/sign_in_model.dart';
import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:ecommerce_app/features/notification/data/repositories/notify_repository_impl.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:ecommerce_app/features/auth/presentation/views/login_screen.dart';
import 'package:ecommerce_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  /// Local DB with Hive
  await Hive.initFlutter();

  final sharedPreferences = await SharedPreferences.getInstance();
  final userCached = sharedPreferences.getString(CACHED_USER_INFO);

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
    return MultiProvider(
      providers: [
        /// Use Clean Architecture
        /// Cart
        ChangeNotifierProxyProvider(
            create: (context) => CartRepositoryImpl(),
            update: (context, value, CartRepositoryImpl? cart) {
              if (cart == null) throw ArgumentError('Cart');
              return cart;
            }),

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
        ChangeNotifierProvider(create: (_) => ThemeSelector())
      ],
      child: Selector<ThemeSelector, ThemeMode>(
        builder: (context, themeMode, child) {
          return MaterialApp(
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              theme: EcommerceTheme.buildLightTheme(context),
              darkTheme: EcommerceTheme.buildDarkTheme(context),
              home: userLogged ? const GroceryApp() : const LoginScreen(),
          );
        },
        selector: (context, theme) => theme.themeMode
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