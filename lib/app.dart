import 'dart:convert';

import 'package:ecommerce_app/core/constants/api_config.dart';
import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/screens/account_screen.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/explore_screen.dart';
import 'package:ecommerce_app/screens/favorite_screen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
          children: screens,
          index: _selectedIndex,
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
                    if (cart.cartLists().length > 0)
                      Positioned(
                          left: 10,
                          bottom: 10,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                            ),
                            child: Text(
                              '${cart.cartLists().length}',
                              style: TextStyle(
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

Future<void> fetchData() async {
  String url = 'https://192.168.110.47/senhong/wp-json/wc/v3/products?consumer_key=ck_27711f499d97c090120b9dcef1e1f40af1778570&consumer_secret=cs_f62d5e2ce67c8bc1be8cd46a915e36adcb5f1aa2';
  var response = await http.get(Uri.parse(url));
  print('status code: ${response.statusCode}');
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    print('loading success');
    print(jsonResponse);
  } else {
    throw Exception('Failed to loading data');
  }
}

