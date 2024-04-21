
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class CartRepository {

  Future<Either<Failure, void>> addProductToCart(CartItemModel cart) => throw UnimplementedError('Stub');

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
