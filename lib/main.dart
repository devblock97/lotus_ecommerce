import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/app.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  /// Local DB with Hive
  await Hive.initFlutter();
  var user = await Hive.openBox('userBox');

  /// Dependencies injection
  await init();


  // Bloc.observer = SimpleBlocObserver();
  // if (user.isNotEmpty) {
  //   runApp(const EcommerceApp());
  // } else {
  //   runApp(const MaterialApp(home: LoginScreen(),));
  // }

  runApp(const MaterialApp(home: EcommerceApp(),));

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


class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Hive.openBox('userBox');

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
              home: LoginScreen(),
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