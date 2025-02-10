import 'dart:convert';

import 'package:ecommerce_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartLocalDataSource {

  Future<Cart?> getCart() => throw UnimplementedError('Stub');

  Future<Cart> addItem(Cart cart) => throw UnimplementedError('Stub');

  Future<Cart> deleteItem(Cart cart) => throw UnimplementedError('Stub');

  Future<Cart> updateItem(Cart cart) => throw UnimplementedError('Stub');

  Future<Cart> deleteAllItems(Cart cart) => throw UnimplementedError('Stub');

  Future<void> syncLocalAndRemoteCart(Cart cart) => throw UnimplementedError('Stub');

}

const CACHED_CART_INFO = 'CACHED_CART_INFO';

class CartLocalDataSourceImpl implements CartLocalDataSource {

  @override
  Future<Cart> addItem(Cart cart) {
    throw UnimplementedError();
  }

  @override
  Future<Cart> deleteAllItems(Cart cart) {
    throw UnimplementedError();
  }

  @override
  Future<Cart> deleteItem(Cart cart) {
    throw UnimplementedError();
  }

  @override
  Future<Cart> updateItem(Cart cart) {
    throw UnimplementedError();
  }

  @override
  Future<void> syncLocalAndRemoteCart(Cart cart) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(CACHED_CART_INFO, jsonEncode(cart.toJson()));
  }

  @override
  Future<Cart?> getCart() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final localCart = pref.getString(CACHED_CART_INFO);
    if (localCart != null) {
      final cart = Cart.fromJson(jsonDecode(localCart));
      return cart;
    }
    return null;
  }

}