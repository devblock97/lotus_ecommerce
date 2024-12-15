import 'dart:async';
import 'package:ecommerce_app/features/account/presentation/views/account_screen.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/view/cart_screen.dart';
import 'package:ecommerce_app/features/favorite/presentation/favorite_screen.dart';
import 'package:ecommerce_app/features/home/presentation/view/home_screen.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:ecommerce_app/screens/explore_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class GroceryApp extends StatefulWidget {
  const GroceryApp({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  State<GroceryApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<GroceryApp> {
  late int _selectedIndex;

  final connectivity = InternetConnectionChecker();
  late StreamSubscription<InternetConnectionChecker> _connectivitySubscription;

  final List<Widget> screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const CartScreen(),
    const FavoriteScreen(),
    const AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shop_outlined,
                color: _selectedIndex == 0
                  ? primaryButton
                  : theme.bottomNavigationBarTheme.backgroundColor,
              ),
              label: 'Sản phẩm',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.explore_outlined,
                color: _selectedIndex == 1
                  ? primaryButton
                  : theme.bottomNavigationBarTheme.backgroundColor,
              ),
              label: 'Khám phá'
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart_checkout,
                    color: _selectedIndex == 2
                      ? primaryButton
                      : theme.bottomNavigationBarTheme.backgroundColor,
                  ),
                ],
              ),
              label: 'Giỏ hàng'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
                color: _selectedIndex == 3
                  ? primaryButton
                  : theme.bottomNavigationBarTheme.backgroundColor,
              ),
              label: 'Yêu thích'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people_outlined,
                color: _selectedIndex == 4
                  ? primaryButton
                  : theme.bottomNavigationBarTheme.backgroundColor,
              ),
              label: 'Tài khoản'
            )
          ],
          unselectedItemColor: theme.bottomNavigationBarTheme.backgroundColor,
          showUnselectedLabels: true,
          selectedItemColor: primaryButton,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
