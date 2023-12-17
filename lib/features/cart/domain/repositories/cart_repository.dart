import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/core/models/product_model.dart';

abstract class CartRepository {

  void addToCart(ProductModel product, int quantity);

  void addAllProductFromFavorite(List<ProductModel> listItems);

  void incrementItem(ProductModel product);

  void decrementItem(ProductModel product);

  void removeItemToCart(ProductModel product);

  void clearItemAllItemToCart();

  int productQuantity(ProductModel product);

  List<CartItemModel> cartLists();

  String totalPrice();
}
