
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class CartRepository {

  Future<Either<Failure, Cart>> addItemCart(CartItemModel cart) => throw UnimplementedError('Stub');

  Future<Either<Failure, Cart?>> getCarts() => throw UnimplementedError('Stub');

  Future<Either<Failure, Cart>> deleteItemCart(String key) => throw UnimplementedError('Stub');

  Future<Either<Failure, Cart>> updateItem(String key, int quantity) => throw UnimplementedError('Stub');

  Future<Either<Failure, Cart>> deleteAllItems() => throw UnimplementedError('Stub');

  Future<Either<Failure, Cart>> getCartsLocal() => throw UnimplementedError('Stub');

}
