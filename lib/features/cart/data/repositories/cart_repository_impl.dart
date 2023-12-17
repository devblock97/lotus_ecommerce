import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
// ignore: unused_import
import 'package:ecommerce_app/features/notification/data/repositories/notify_repository_impl.dart';
import 'package:flutter/material.dart';

class CartRepositoryImpl extends ChangeNotifier implements CartRepository {
  List<CartItemModel> _cartLists = [];

  @override
  void addToCart(ProductModel product, int quantity) {
    if (quantity < 0) return;
    var isInCart =
        _cartLists.any((element) => element.product.id == product.id);

    if (isInCart) {
      for (var p in _cartLists) {
        if (p.product.id == product.id) {
          p.quantity += quantity;
        }
      }
    } else {
      final item = CartItemModel(product: product, quantity: quantity);
      _cartLists.add(item);
    }
    notifyListeners();
  }

  @override
  void addAllProductFromFavorite(List<ProductModel> listItems) {
    for (var i = 0; i < listItems.length; i++) {
      addToCart(listItems[i], 1);
    }
    notifyListeners();
  }

  @override
  void clearItemAllItemToCart() {
    _cartLists.clear();
    notifyListeners();
  }

  @override
  void decrementItem(ProductModel product) {
    _cartLists.firstWhere((cart) => cart.product.id == product.id).quantity--;
    notifyListeners();
  }

  @override
  void incrementItem(ProductModel product) {
    _cartLists.firstWhere((cart) => cart.product.id == product.id).quantity++;
    notifyListeners();
  }

  @override
  void removeItemToCart(ProductModel product) {
    final item = _cartLists.firstWhere((cart) => cart.product.id == product.id);
    _cartLists.remove(item);
    notifyListeners();
  }

  @override
  List<CartItemModel> cartLists() {
    return _cartLists;
  }

  @override
  String totalPrice() => _cartLists
      .fold<double>(
          0,
          (previousValue, cart) =>
              previousValue + (cart.product.price * cart.quantity))
      .toStringAsPrecision(6);

  @override
  int productQuantity(ProductModel product) {
    return _cartLists
        .firstWhere((cart) => cart.product.id == product.id)
        .quantity;
  }
}
