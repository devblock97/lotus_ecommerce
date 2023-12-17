import 'package:ecommerce_app/screens/account_screen.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/explore_screen.dart';
import 'package:ecommerce_app/screens/favorite_screen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
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
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => screens[_selectedIndex]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shop_outlined,
            color: _selectedIndex == 0 ? primaryButton : Colors.black,
          ),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.explore_outlined,
              color: _selectedIndex == 1 ? primaryButton : Colors.black,
            ),
            label: 'Explore'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: _selectedIndex == 2 ? primaryButton : Colors.black,
            ),
            label: 'Cart'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
              color: _selectedIndex == 3 ? primaryButton : Colors.black,
            ),
            label: 'Favorite'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outlined,
              color: _selectedIndex == 4 ? primaryButton : Colors.black,
            ),
            label: 'Account')
      ],
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      selectedItemColor: primaryButton,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
