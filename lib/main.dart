import 'dart:io';

import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:ecommerce_app/features/notification/data/repositories/notify_repository_impl.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

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
              if (favorite == null) throw ArgumentError('Favortie');
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