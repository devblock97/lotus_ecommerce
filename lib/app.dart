import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/screens/account_screen.dart';
import 'package:ecommerce_app/features/cart/presentation/cart_screen.dart';
import 'package:ecommerce_app/screens/explore_screen.dart';
import 'package:ecommerce_app/features/favorite/presentation/favorite_screen.dart';
import 'package:ecommerce_app/features/home/presentation/view/home_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class GroceryApp extends StatefulWidget {
  const GroceryApp({super.key});

  @override
  State<GroceryApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<GroceryApp> {
  int _selectedIndex = 0;

  List<Widget> screens = [
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
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartRepositoryImpl>();

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
                color: _selectedIndex == 0 ? primaryButton : Colors.black,
              ),
              label: 'Sản phẩm',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore_outlined,
                  color: _selectedIndex == 1 ? primaryButton : Colors.black,
                ),
                label: 'Khám phá'),
            BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    if (cart.cartLists().isNotEmpty)
                      Positioned(
                          left: 10,
                          bottom: 10,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                            ),
                            child: Text(
                              '${cart.cartLists().length}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    Icon(
                      Icons.shopping_cart_checkout,
                      color: _selectedIndex == 2 ? primaryButton : Colors.black,
                    ),
                  ],
                ),
                label: 'Giỏ hàng'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_outline,
                  color: _selectedIndex == 3 ? primaryButton : Colors.black,
                ),
                label: 'Yêu thích'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.people_outlined,
                  color: _selectedIndex == 4 ? primaryButton : Colors.black,
                ),
                label: 'Tài khoản')
          ],
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          selectedItemColor: primaryButton,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
