
import 'package:ecommerce_app/core/catchers/errors/failure.dart';
import 'package:ecommerce_app/core/catchers/exceptions/exception.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartLocalDataSource {
  Future<void> addToCart(ProductModel product, int quantity) => throw UnimplementedError('Stub');
}

const CART = 'CART';

class CartLocalDataSourceImpl implements CartLocalDataSource {

  CartLocalDataSourceImpl(this.localDataSource);

  final SharedPreferences localDataSource;

  @override
  Future<void> addToCart(ProductModel product, int quantity) async {
    try {
      // Retrieve cart from local data source
      final localData = localDataSource.getString(CART);
      // Check cart is not empty
      if (localData != null) {
        // Handle cart data string to cart data model
      }
      // final response = await localDataSource.setString(key, value)
    } on CacheException {
      throw CacheFailure('Cache error');
    } catch (_) {
      rethrow;
    }
  }

}