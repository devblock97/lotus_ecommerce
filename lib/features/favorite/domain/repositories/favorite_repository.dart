import 'package:ecommerce_app/core/models/product_model.dart';

abstract class FavoriteRepository {
  Future<void> addProductToFavorite(ProductModel product);

  Future<void> removeProductFromFavorite(ProductModel product);

  Future<List<ProductModel>> favoriteLists();

  Future<void> clearAllFavoriteLists();
}
