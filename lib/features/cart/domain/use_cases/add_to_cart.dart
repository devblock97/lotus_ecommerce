import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:flutter/widgets.dart';

class AddToCartUseCase with ChangeNotifier {
  final CartRepository _cartRepository;

  AddToCartUseCase(this._cartRepository);
  
  Future<void> addToCart(ProductModel product, int quantity) async {
    _cartRepository.addToCart(product, quantity);
  }
}
