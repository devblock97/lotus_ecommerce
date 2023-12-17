
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';

class GetCartList {

  GetCartList(this._cartRepository);

  CartRepository _cartRepository;

  Future<List<CartItemModel>> getCartLists() async {
    return _cartRepository.cartLists();
  }
}